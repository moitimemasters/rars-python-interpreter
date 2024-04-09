#include "interpreter.h"

#include "allocator.h"
#include "c_functions.h"
#include "interpreter_error.h"
#include "pyobject.h"
#include "weak_ptr.h"

#define common_args                                            \
    Instruction *instruction, linked_list_node **current_node, \
        Interpreter *interpreter, InterpreterError *error

void interpret_instruction(common_args);
void interpret_load_float(common_args);
void interpret_load_int(common_args);
void interpret_binop(common_args);
void interpret_jump_relative(common_args);
void interpret_jump_relative_if_false(common_args);
void interpret_store(common_args);
void interpret_load(common_args);
void interpret_anon_fun(common_args);
void interpret_return(common_args);
void interpret_load_none(common_args);
void interpret_return(common_args);
void interpret_call(common_args);
void interpret_break(common_args);
void interpret_mark(common_args);

void interpret_unit(CompilationUnit *unit, Interpreter *interpreter,
                    InterpreterError *error) {
    linked_list_node *current_node = unit->instructions->head;
    while (current_node != NULL) {
        Instruction *instruction = current_node->item;
        interpret_instruction(instruction, &current_node, interpreter, error);
        if (error != NULL) {
            return;
        }
    }
}

void interpret_instruction(common_args) {
    switch (instruction->type) {
        case COMP_LOAD: {
            interpret_load(instruction, current_node, interpreter, error);
            return;
        }
        case COMP_LOAD_NONE: {
            interpret_load_none(instruction, current_node, interpreter, error);
            return;
        }
        case COMP_RETURN: {
            interpret_return(instruction, current_node, interpreter, error);
            return;
        }
        case COMP_LOAD_INT: {
            interpret_load_int(instruction, current_node, interpreter, error);
            return;
        }
        case COMP_LOAD_FLOAT: {
            interpret_load_float(instruction, current_node, interpreter, error);
            return;
        }
        case COMP_BINOP: {
            interpret_binop(instruction, current_node, interpreter, error);
            return;
        }
        case COMP_JUMP_REL: {
            interpret_jump_relative(instruction, current_node, interpreter,
                                    error);
            return;
        }
        case COMP_JUMP_REL_IF_FALSE: {
            interpret_jump_relative_if_false(instruction, current_node,
                                             interpreter, error);
            return;
        }
        case COMP_STORE: {
            interpret_store(instruction, current_node, interpreter, error);
            return;
        }
        case COMP_FUNCTION_ANON: {
            interpret_anon_fun(instruction, current_node, interpreter, error);
            return;
        }
        case COMP_CALL: {
            interpret_call(instruction, current_node, interpreter, error);
            return;
        }
        case COMP_BREAK: {
            interpret_break(instruction, current_node, interpreter, error);
            return;
        }
        case COMP_MARK: {
            interpret_mark(instruction, current_node, interpreter, error);
        }
        default: {
            *error = UnrecognizedOperationError;
            my_printf("Unknown instruction type: %d\n", instruction->type);
            return;
        }
    }
}

void interpret_load_float(common_args) {
    PyObject *value = create_value(interpreter->pool, PY_FLOAT);
    value->data.value.data.float_value = instruction->data.float_value;
    stack_push(interpreter->stack, value);
    *current_node = (*current_node)->next;
}

void interpret_load_int(common_args) {
    PyObject *value = create_value(interpreter->pool, PY_INT);
    value->data.value.data.int_value = instruction->data.int_value;
    stack_push(interpreter->stack, value);
    *current_node = (*current_node)->next;
}

void interpret_binop(common_args) {
    PyObject *right = interpreter->stack->head->item;
    stack_pop(interpreter->stack);
    PyObject *left = interpreter->stack->head->item;
    stack_pop(interpreter->stack);
    TokenType op = instruction->data.binop.op;
    switch (op) {
        case TOK_PLUS: {
            CFunctionPointer binop_c = hash_table_get_string(
                interpreter->c_functions,
                (string_view_t){.str = "add_binop", .len = 9});
            if (binop_c == NULL) {
                *error = NoMatchingImplementationError;
                return;
            }
            linked_list *payload = linked_list_create(interpreter->pool);
            linked_list_push(payload, left);
            linked_list_push(payload, right);
            PyObject *result = binop_c(interpreter->pool, payload, error);
            if (error != NULL) {
                return;
            }
            stack_push(interpreter->stack, result);
            break;
        }
        case TOK_MINUS: {
            CFunctionPointer binop_c = hash_table_get_string(
                interpreter->c_functions,
                (string_view_t){.str = "sub_binop", .len = 9});
            if (binop_c == NULL) {
                *error = NoMatchingImplementationError;
                return;
            }
            linked_list *payload = linked_list_create(interpreter->pool);
            linked_list_push(payload, left);
            linked_list_push(payload, right);
            PyObject *result = binop_c(interpreter->pool, payload, error);
            if (error != NULL) {
                return;
            }
            stack_push(interpreter->stack, result);
            break;
        }
        case TOK_MUL: {
            CFunctionPointer binop_c = hash_table_get_string(
                interpreter->c_functions,
                (string_view_t){.str = "mul_binop", .len = 9});
            if (binop_c == NULL) {
                *error = NoMatchingImplementationError;
                return;
            }
            linked_list *payload = linked_list_create(interpreter->pool);
            linked_list_push(payload, left);
            linked_list_push(payload, right);
            PyObject *result = binop_c(interpreter->pool, payload, error);
            if (error != NULL) {
                return;
            }
            stack_push(interpreter->stack, result);
            break;
        }
        case TOK_DIV: {
            CFunctionPointer binop_c = hash_table_get_string(
                interpreter->c_functions,
                (string_view_t){.str = "div_binop", .len = 9});
            if (binop_c == NULL) {
                *error = NoMatchingImplementationError;
                return;
            }
            linked_list *payload = linked_list_create(interpreter->pool);
            linked_list_push(payload, left);
            linked_list_push(payload, right);
            PyObject *result = binop_c(interpreter->pool, payload, error);
            if (error != NULL) {
                return;
            }
            stack_push(interpreter->stack, result);
            break;
        }
        case TOK_LT: {
            CFunctionPointer binop_c = hash_table_get_string(
                interpreter->c_functions,
                (string_view_t){.str = "lt_binop", .len = 8});
            if (binop_c == NULL) {
                *error = NoMatchingImplementationError;
                return;
            }
            linked_list *payload = linked_list_create(interpreter->pool);
            linked_list_push(payload, left);
            linked_list_push(payload, right);
            PyObject *result = binop_c(interpreter->pool, payload, error);
            if (error != NULL) {
                return;
            }
            stack_push(interpreter->stack, result);
            break;
        }
        case TOK_LEQ: {
            CFunctionPointer binop_c = hash_table_get_string(
                interpreter->c_functions,
                (string_view_t){.str = "leq_binop", .len = 9});
            if (binop_c == NULL) {
                *error = NoMatchingImplementationError;
                return;
            }
            linked_list *payload = linked_list_create(interpreter->pool);
            linked_list_push(payload, left);
            linked_list_push(payload, right);
            PyObject *result = binop_c(interpreter->pool, payload, error);
            if (error != NULL) {
                return;
            }
            stack_push(interpreter->stack, result);
            break;
        }
        case TOK_GT: {
            CFunctionPointer binop_c = hash_table_get_string(
                interpreter->c_functions,
                (string_view_t){.str = "gt_binop", .len = 8});
            if (binop_c == NULL) {
                *error = NoMatchingImplementationError;
                return;
            }
            linked_list *payload = linked_list_create(interpreter->pool);
            linked_list_push(payload, left);
            linked_list_push(payload, right);
            PyObject *result = binop_c(interpreter->pool, payload, error);
            if (error != NULL) {
                return;
            }
            stack_push(interpreter->stack, result);
            break;
        }
        case TOK_GEQ: {
            CFunctionPointer binop_c = hash_table_get_string(
                interpreter->c_functions,
                (string_view_t){.str = "geq_binop", .len = 9});
            if (binop_c == NULL) {
                *error = NoMatchingImplementationError;
                return;
            }
            linked_list *payload = linked_list_create(interpreter->pool);
            linked_list_push(payload, left);
            linked_list_push(payload, right);
            PyObject *result = binop_c(interpreter->pool, payload, error);
            if (error != NULL) {
                return;
            }
            stack_push(interpreter->stack, result);
            break;
        }
        case TOK_EQ: {
            CFunctionPointer binop_c = hash_table_get_string(
                interpreter->c_functions,
                (string_view_t){.str = "eq_binop", .len = 8});
            if (binop_c == NULL) {
                *error = NoMatchingImplementationError;
                return;
            }
            linked_list *payload = linked_list_create(interpreter->pool);
            linked_list_push(payload, left);
            linked_list_push(payload, right);
            PyObject *result = binop_c(interpreter->pool, payload, error);
            if (error != NULL) {
                return;
            }
            stack_push(interpreter->stack, result);
            break;
        }
        case TOK_NEQ: {
            CFunctionPointer binop_c = hash_table_get_string(
                interpreter->c_functions,
                (string_view_t){.str = "neq_binop", .len = 9});
            if (binop_c == NULL) {
                *error = NoMatchingImplementationError;
                return;
            }
            linked_list *payload = linked_list_create(interpreter->pool);
            linked_list_push(payload, left);
            linked_list_push(payload, right);
            PyObject *result = binop_c(interpreter->pool, payload, error);
            if (error != NULL) {
                return;
            }
            stack_push(interpreter->stack, result);
            break;
        }
        default: {
            *error = UnrecognizedOperationError;
            my_printf("Unknown binary operation: %d\n", op);
            return;
        }
    }
    *current_node = (*current_node)->next;
}

void perform_jump(linked_list_node **current_node, int offset) {
    if (offset < 0) {
        for (int i = 0; i < -offset && *current_node != NULL; i++) {
            *current_node = (*current_node)->previous;
        }
    } else {
        for (int i = 0; i < offset && current_node != NULL; i++) {
            *current_node = (*current_node)->next;
        }
    }
}

void interpret_jump_relative(common_args) {
    int offset = instruction->data.jump_relative.target;
    perform_jump(current_node, offset);
}

void interpret_jump_relative_if_false(common_args) {
    PyObject *value = interpreter->stack->head->item;
    stack_pop(interpreter->stack);
    if (value == NULL) {
        int offset = instruction->data.jump_relative_if_false.target;
        perform_jump(current_node, offset);
        return;
    }
    if (value->object_type == OBJ_T_REFERENCE &&
        value->data.reference.data.ptr != NULL) {
        *current_node = (*current_node)->next;
        return;
    }
    if (value->object_type == OBJ_T_REFERENCE) {
        int offset = instruction->data.jump_relative_if_false.target;
        perform_jump(current_node, offset);
        return;
    }
    bool can_perform_jump = false;
    if (value->data.value.type == PY_INT) {
        can_perform_jump = value->data.value.data.int_value == 0;
    } else if (value->data.value.type == PY_FLOAT) {
        can_perform_jump = value->data.value.data.float_value == 0;
    } else if (value->data.value.type == PY_BOOL) {
        can_perform_jump = value->data.value.data.bool_value == false;
    } else {
        *error = TypeError;
        return;
    }
    if (can_perform_jump) {
        int offset = instruction->data.jump_relative_if_false.target;
        perform_jump(current_node, offset);
    } else {
        *current_node = (*current_node)->next;
    }
}

void interpret_store(common_args) {
    PyObject *value = interpreter->stack->head->item;
    stack_pop(interpreter->stack);
    env_store(interpreter->env, instruction->data.store.ident, value);
    *current_node = (*current_node)->next;
}

void interpret_load(common_args) {
    PyObject *value = env_load(interpreter->env, instruction->data.load.ident);
    if (value == NULL) {
        my_printf("ERROR: Variable not found\n");
        *error = VariableNotFoundError;
        return;
    }
    stack_push(interpreter->stack, value);
    *current_node = (*current_node)->next;
}

void interpret_anon_fun(common_args) {
    PyObject *lambda = create_pyobject(interpreter->pool, OBJ_T_REFERENCE);
    lambda->data.reference.type = PY_FUNC;
    Func *func = my_alloc(interpreter->pool, sizeof(Func));
    *func = instruction->data.anonymous_function;
    lambda->data.reference.data = make_shared(interpreter->pool, func);
    stack_push(interpreter->stack, lambda);
    *current_node = (*current_node)->next;
}

void interpret_return(common_args) { *current_node = NULL; }
void interpret_mark(common_args) { *current_node = (*current_node)->next; }
void interpret_break(common_args) {
    while ((*current_node) &&
           ((Instruction *)(*current_node)->item)->type != COMP_MARK) {
        *current_node = (*current_node)->next;
    }
}

void interpret_load_none(common_args) {
    stack_push(interpreter->stack, NULL);
    *current_node = (*current_node)->next;
}

void interpret_call(common_args) {
    PyObject *function_obj = interpreter->stack->head->item;
    stack_pop(interpreter->stack);
    Func *function = function_obj->data.reference.data.ptr;
    if (instruction->data.call.num_args != function->signature->size) {
        my_printf("not enough args\n");
        *error = NotEnoughArgsError;
        return;
    }
    linked_list *args = linked_list_create(interpreter->pool);
    for (int i = 0; i < instruction->data.call.num_args; i++) {
        ;
        PyObject *arg = interpreter->stack->head->item;
        stack_pop(interpreter->stack);
        linked_list_push(args, arg);
    }
    linked_list_reverse(args);
    Env *sub_env = my_alloc(interpreter->pool, sizeof(Env));
    sub_env->pool = interpreter->pool;
    sub_env->parent = interpreter->env;
    sub_env->context = hash_table_create(interpreter->pool);
    linked_list_node *current_arg_node = args->head;
    linked_list_node *current_signature_node = function->signature->head;
    for (int i = 0; i < args->size; ++i) {
        env_store(sub_env, *(string_view_t *)current_signature_node->item,
                  (PyObject *)current_arg_node->item);
        current_arg_node = current_arg_node->next;
        current_signature_node = current_signature_node->next;
    }
    Interpreter *sub_interpreter =
        my_alloc(interpreter->pool, sizeof(Interpreter));
    sub_interpreter->pool = interpreter->pool;
    sub_interpreter->env = sub_env;
    sub_interpreter->stack = stack_create(interpreter->pool);
    sub_interpreter->c_functions = interpreter->c_functions;
    sub_interpreter->program = function->__code__;
    interpret(sub_interpreter);
    stack_push(interpreter->stack, sub_interpreter->stack->head->item);
    stack_free(sub_interpreter->stack);
    hash_table_free(sub_env->context);
    my_free(sub_interpreter->env->pool, sub_interpreter->env);
    my_free(interpreter->pool, sub_interpreter);
    *current_node = (*current_node)->next;
}

void interpret(Interpreter *interpreter) {
    InterpreterError *error = NULL;
    interpret_unit(interpreter->program, interpreter, error);
}
