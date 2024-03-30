#include "interpreter.h"

#include "c_functions.h"
#include "interpreter_error.h"
#include "pyobject.h"

#define common_args                                            \
    Instruction *instruction, linked_list_node **current_node, \
        Interpreter *interpreter, InterpreterError *error

void interpret_instruction(common_args);
void interpret_load_float(common_args);
void interpret_load_int(common_args);
void interpret_binop(common_args);
void interpret_jump_relative(common_args);
void interpret_jump_relative_if_false(common_args);

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
        default: {
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
        default: {
            *error = UnrecognizedOperationError;
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
        value->data.reference.data != NULL) {
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

void interpret(Interpreter *interpreter) {
    my_printf("started_interpreting\n");
    InterpreterError *error = NULL;
    CompilationUnit *first_unit = interpreter->compilation_units->head->item;
    interpret_unit(first_unit, interpreter, error);
    my_printf("ended_interpreting\n");
    // currently only arithmetic, so
    if (error != NULL) {
        my_printf("Interpretation Error: %d\n", *error);
        return;
    }
    PyObject *result = interpreter->stack->head->item;
    if (result->object_type == OBJ_T_VALUE) {
        if (result->data.value.type == PY_INT) {
            my_printf("Interpretation result: %d\n",
                      result->data.value.data.int_value);
        } else if (result->data.value.type == PY_FLOAT) {
            my_printf("Interpretation result: %f\n",
                      result->data.value.data.float_value);
        } else {
            my_printf("Unsupported type: %d\n", result->data.value.type);
        }
    } else {
        my_printf("Unsupported type\n");
    }
}
