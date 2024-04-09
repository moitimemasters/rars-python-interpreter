#include "compiler.h"

#include "allocator.h"
#include "ast.h"

#define comp_f_args Compiler *compiler, ASTNode *node, linked_list *instructions
#define add_instruction(instr) linked_list_push(instructions, instr)

Instruction *create_instruction(MemoryPool *pool, InstructionType type) {
    Instruction *instr = my_alloc(pool, sizeof(Instruction));
    instr->type = type;
    return instr;
}

Instruction *create_load_int(MemoryPool *pool, int value) {
    Instruction *instr = create_instruction(pool, COMP_LOAD_INT);
    instr->data.int_value = value;
    return instr;
}

Instruction *create_load_float(MemoryPool *pool, float value) {
    Instruction *instr = create_instruction(pool, COMP_LOAD_FLOAT);
    instr->data.float_value = value;
    return instr;
}

Instruction *create_load_bool(MemoryPool *pool, bool value) {
    Instruction *instr = create_instruction(pool, COMP_LOAD_BOOL);
    instr->data.bool_value = value;
    return instr;
}

Instruction *create_jump_relative_instruction(MemoryPool *pool) {
    return create_instruction(pool, COMP_JUMP_REL);
}

Instruction *create_jump_relative_if_false_instruction(MemoryPool *pool) {
    return create_instruction(pool, COMP_JUMP_REL_IF_FALSE);
}

void compile_node(comp_f_args);

void compile_ident(comp_f_args) {
    Instruction *instr = create_instruction(compiler->pool, COMP_LOAD);
    instr->data.load.ident = node->data.ident_name;
    linked_list_push(instructions, instr);
}

void compile_int(comp_f_args) {
    Instruction *instr = create_load_int(compiler->pool, node->data.int_value);
    linked_list_push(instructions, instr);
}

void compile_float(comp_f_args) {
    Instruction *instr =
        create_load_float(compiler->pool, node->data.float_value);
    linked_list_push(instructions, instr);
}

void compile_bool(comp_f_args) {
    Instruction *instr =
        create_load_float(compiler->pool, node->data.float_value);
    linked_list_push(instructions, instr);
}

void compile_binop(comp_f_args) {
    compile_node(compiler, node->data.binary_op.left, instructions);
    compile_node(compiler, node->data.binary_op.right, instructions);
    Instruction *instr = create_instruction(compiler->pool, COMP_BINOP);
    instr->data.binop.op = node->data.binary_op.op;
    linked_list_push(instructions, instr);
}

void compile_ternary_if(comp_f_args) {
    compile_node(compiler, node->data.ternary_if.if_expr, instructions);
    Instruction *jump_if_false =
        create_jump_relative_if_false_instruction(compiler->pool);
    int if_false_save = instructions->size;
    add_instruction(jump_if_false);
    compile_node(compiler, node->data.ternary_if.if_body, instructions);
    Instruction *jump = create_jump_relative_instruction(compiler->pool);
    int jump_save = instructions->size;
    add_instruction(jump);
    jump_if_false->data.jump_relative.target =
        instructions->size - if_false_save;
    compile_node(compiler, node->data.ternary_if.else_body, instructions);
    jump->data.jump_relative.target = instructions->size - jump_save;
}

TokenType match_aug_to_binop(TokenType binop_tt) {
    switch (binop_tt) {
        case TOK_AUGPLUS:
            return TOK_PLUS;
        case TOK_AUGMINUS:
            return TOK_MINUS;
        case TOK_AUGMUL:
            return TOK_MUL;
        case TOK_AUGDIV:
            return TOK_DIV;
        case TOK_AUGFLOORDIV:
            return TOK_FLOORDIV;
        case TOK_AUGMOD:
            return TOK_MOD;
        case TOK_AUGPOW:
            return TOK_POW;
        default:
            return TOK_INVALID;
    }
}

void compile_assign(comp_f_args) {
    ASTNodeType assignee_type = node->data.assign.target->type;
    if (assignee_type != AST_IDENT && assignee_type != AST_SLICE &&
        assignee_type != AST_INDEX) {
        my_printf("invalid assign target\n");
        return;
    }
    TokenType binop_tt = match_aug_to_binop(node->data.assign.op);
    if (binop_tt == TOK_INVALID) {
        compile_node(compiler, node->data.assign.value, instructions);
        if (assignee_type == AST_IDENT) {
            Instruction *instr = create_instruction(compiler->pool, COMP_STORE);
            instr->data.store.ident = node->data.assign.target->data.ident_name;
            linked_list_push(instructions, instr);
            return;
        }
        compile_node(compiler, node->data.assign.target, instructions);
        Instruction *instr =
            create_instruction(compiler->pool, COMP_STORE_INDEX);
        linked_list_push(instructions, instr);
        return;
    }
    compile_node(compiler, node->data.assign.target, instructions);
    compile_node(compiler, node->data.assign.value, instructions);
    Instruction *instr = create_instruction(compiler->pool, COMP_BINOP);
    instr->data.binop.op = binop_tt;
    linked_list_push(instructions, instr);
    if (assignee_type == AST_IDENT) {
        instr = create_instruction(compiler->pool, COMP_STORE);
        instr->data.store.ident = node->data.assign.target->data.ident_name;
        linked_list_push(instructions, instr);
        return;
    }
    compile_node(compiler, node->data.assign.target, instructions);
    instr = create_instruction(compiler->pool, COMP_STORE_INDEX);
    linked_list_push(instructions, instr);
}

void compile_function_def(comp_f_args) {
    ASTNode *arguments_node = node->data.function_def.arguments;
    linked_list *arguments = arguments_node->data.argument_list.arguments;
    linked_list_node *current = arguments->head;
    linked_list *signature = linked_list_create(compiler->pool);
    while (current != NULL) {
        ASTNode *post_arg = current->item;
        string_view_t *str = my_alloc(compiler->pool, sizeof(string_view_t));
        *str = post_arg->data.ident_name;
        linked_list_push(signature, str);
        current = current->next;
    }
    ASTNode *root = compiler->root;
    compiler->root = node->data.function_def.body;
    CompilationUnit *__code__ = compile(compiler);
    linked_list_push(__code__->instructions,
                     create_instruction(compiler->pool, COMP_LOAD_NONE));
    linked_list_push(__code__->instructions,
                     create_instruction(compiler->pool, COMP_RETURN));
    compiler->root = root;
    Instruction *instr = create_instruction(compiler->pool, COMP_FUNCTION_ANON);
    instr->data.anonymous_function.__code__ = __code__;
    instr->data.anonymous_function.signature = signature;
    linked_list_push(instructions, instr);
    Instruction *store = create_instruction(compiler->pool, COMP_STORE);
    store->data.store.ident = node->data.function_def.name->data.ident_name;
    linked_list_push(instructions, store);
}

void compile_lambda_def(comp_f_args) {
    ASTNode *arguments_node = node->data.lambda_def.args;
    linked_list *arguments = arguments_node->data.argument_list.arguments;
    linked_list *signature = linked_list_create(compiler->pool);
    linked_list_node *current = arguments->head;
    while (current != NULL) {
        ASTNode *post_arg = current->item;
        string_view_t *str = my_alloc(compiler->pool, sizeof(string_view_t));
        *str = post_arg->data.ident_name;
        linked_list_push(signature, str);
        current = current->next;
    }
    ASTNode *root = compiler->root;
    compiler->root = node->data.lambda_def.body;
    CompilationUnit *__code__ = compile(compiler);
    linked_list_push(__code__->instructions,
                     create_instruction(compiler->pool, COMP_RETURN));
    compiler->root = root;
    Instruction *instr = create_instruction(compiler->pool, COMP_FUNCTION_ANON);
    instr->data.anonymous_function.__code__ = __code__;
    instr->data.anonymous_function.signature = signature;
    linked_list_push(instructions, instr);
}

void compile_return(comp_f_args) {
    compile_node(compiler, node->data.unary_stmt.target, instructions);
    Instruction *instr = create_instruction(compiler->pool, COMP_RETURN);
    linked_list_push(instructions, instr);
}

void compile_function_call(comp_f_args) {
    ASTNode *arguments_node = node->data.function_call.argument_list;
    linked_list *arguments = arguments_node->data.function_call_partial
                                 .arguments->data.argument_list.arguments;
    linked_list_node *current_arg = arguments->head;
    while (current_arg != NULL) {
        ASTNode *arg = current_arg->item;
        compile_node(compiler, arg, instructions);
        current_arg = current_arg->next;
    }
    compile_node(compiler, node->data.function_call.callee, instructions);
    Instruction *instr = create_instruction(compiler->pool, COMP_CALL);
    instr->data.call.num_args = arguments->size;
    linked_list_push(instructions, instr);
}

void compile_while_loop(comp_f_args) {
    int start = instructions->size;
    compile_node(compiler, node->data.while_loop.condition, instructions);
    int jump_if_false_save = instructions->size;
    Instruction *jump_if_false =
        create_jump_relative_if_false_instruction(compiler->pool);
    linked_list_push(instructions, jump_if_false);
    linked_list_node *current_node = node->data.while_loop.body->head;
    while (current_node != NULL) {
        compile_node(compiler, current_node->item, instructions);
        current_node = current_node->next;
    }
    Instruction *jump = create_jump_relative_instruction(compiler->pool);
    jump->data.jump_relative.target = start - instructions->size;
    linked_list_push(instructions, jump);
    Instruction *mark = create_instruction(compiler->pool, COMP_MARK);
    linked_list_push(instructions, mark);
    jump_if_false->data.jump_relative.target =
        instructions->size - jump_if_false_save;
}

void compile_many_nodes(linked_list *body, comp_f_args) {
    linked_list_node *current_node = body->head;
    while (current_node != NULL) {
        compile_node(compiler, current_node->item, instructions);
        current_node = current_node->next;
    }
}

void compile_if_statement(comp_f_args) {
    ASTNode *if_partial = node->data.if_statement.if_part;
    linked_list *end_jumps = linked_list_create(compiler->pool);
    Instruction *end_jump = create_jump_relative_instruction(compiler->pool);
    linked_list_push(end_jumps, end_jump);
    Instruction *if_partial_else_jump =
        create_jump_relative_if_false_instruction(compiler->pool);
    ASTNode *if_condition = if_partial->data.if_partial.condition;
    compile_node(compiler, if_partial->data.if_partial.condition, instructions);
    int current_save = instructions->size;
    add_instruction(if_partial_else_jump);
    compile_many_nodes(if_partial->data.if_partial.body, compiler, node,
                       instructions);
    end_jump->data.jump_relative.target = instructions->size;
    add_instruction(end_jump);
    linked_list_node *current_node = node->data.if_statement.elifs->head;
    while (current_node != NULL) {
        if_partial_else_jump->data.jump_relative.target =
            instructions->size - current_save;
        ASTNode *elif = current_node->item;
        if_partial_else_jump =
            create_jump_relative_if_false_instruction(compiler->pool);
        compile_node(compiler, elif->data.if_partial.condition, instructions);
        current_save = instructions->size;
        add_instruction(if_partial_else_jump);
        compile_many_nodes(elif->data.if_partial.body, compiler, node,
                           instructions);
        Instruction *end_jump =
            create_jump_relative_instruction(compiler->pool);
        linked_list_push(end_jumps, end_jump);
        end_jump->data.jump_relative.target = instructions->size;
        add_instruction(end_jump);
        current_node = current_node->next;
    }
    ASTNode *else_part = node->data.if_statement.else_part;
    if (else_part != NULL) {
        if_partial_else_jump->data.jump_relative.target =
            instructions->size - current_save;
        compile_many_nodes(else_part->data.if_partial.body, compiler, node,
                           instructions);
    } else {
        if_partial_else_jump->data.jump_relative.target =
            instructions->size - current_save;
    }
    current_node = end_jumps->head;
    while (current_node != NULL) {
        Instruction *end_jump = current_node->item;
        end_jump->data.jump_relative.target =
            instructions->size - end_jump->data.jump_relative.target;
        current_node = current_node->next;
    }
}

void compile_break(comp_f_args) {
    Instruction *instr = create_instruction(compiler->pool, COMP_BREAK);
    linked_list_push(instructions, instr);
}

void compile_node(comp_f_args) {
    if (node == NULL) {
        return;
    }
    switch (node->type) {
        case AST_IDENT: {
            compile_ident(compiler, node, instructions);
            break;
        }
        case AST_INT: {
            compile_int(compiler, node, instructions);
            break;
        }
        case AST_FLOAT: {
            compile_float(compiler, node, instructions);
            break;
        }
        case AST_BINARY_OP: {
            compile_binop(compiler, node, instructions);
            break;
        }
        case AST_TERNARY: {
            compile_ternary_if(compiler, node, instructions);
            break;
        }
        case AST_ASSIGN: {
            compile_assign(compiler, node, instructions);
            break;
        }
        case AST_FUNCTION_DEF: {
            compile_function_def(compiler, node, instructions);
            break;
        }
        case AST_LAMBDA: {
            compile_lambda_def(compiler, node, instructions);
            break;
        }
        case AST_FUNCTION_CALL: {
            compile_function_call(compiler, node, instructions);
            break;
        }
        case AST_RETURN: {
            compile_return(compiler, node, instructions);
            break;
        }
        case AST_BREAK: {
            compile_break(compiler, node, instructions);
            break;
        }
        case AST_WHILE_LOOP: {
            compile_while_loop(compiler, node, instructions);
            break;
        }
        case AST_IF_STATEMENT: {
            compile_if_statement(compiler, node, instructions);
            break;
        }
        default:
            my_printf("unrecognized node!\n");
            my_printf("node type: %d\n", node->type);
            break;
    }
}

CompilationUnit *compile(Compiler *compiler) {
    if (compiler->root->type == AST_SUBPROGRAM) {
        CompilationUnit *unit =
            my_alloc(compiler->pool, sizeof(CompilationUnit));
        unit->instructions = linked_list_create(compiler->pool);
        unit->pool = compiler->pool;
        linked_list_node *item_node =
            compiler->root->data.subprogram.statements->head;
        while (item_node != NULL) {
            compile_node(compiler, item_node->item, unit->instructions);
            item_node = item_node->next;
        }
        return unit;
    }
    CompilationUnit *unit = my_alloc(compiler->pool, sizeof(CompilationUnit));
    unit->instructions = linked_list_create(compiler->pool);
    unit->pool = compiler->pool;
    compile_node(compiler, compiler->root, unit->instructions);
    return unit;
}
