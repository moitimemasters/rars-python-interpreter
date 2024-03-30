#include "compiler.h"

#include "ast.h"

#define comp_f_args MemoryPool *pool, ASTNode *node, linked_list *instructions
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

void compile_int(comp_f_args) {
    Instruction *instr = create_load_int(pool, node->data.int_value);
    linked_list_push(instructions, instr);
}

void compile_float(comp_f_args) {
    Instruction *instr = create_load_float(pool, node->data.float_value);
    linked_list_push(instructions, instr);
}

void compile_bool(comp_f_args) {
    Instruction *instr = create_load_float(pool, node->data.float_value);
    linked_list_push(instructions, instr);
}

void compile_binop(comp_f_args) {
    compile_node(pool, node->data.binary_op.left, instructions);
    compile_node(pool, node->data.binary_op.right, instructions);
    Instruction *instr = create_instruction(pool, COMP_BINOP);
    instr->data.binop.op = node->data.binary_op.op;
    linked_list_push(instructions, instr);
}

void compile_ternary_if(comp_f_args) {
    compile_node(pool, node->data.ternary_if.if_expr, instructions);
    Instruction *jump_if_false =
        create_jump_relative_if_false_instruction(pool);
    int if_false_save = instructions->size;
    add_instruction(jump_if_false);
    compile_node(pool, node->data.ternary_if.if_body, instructions);
    Instruction *jump = create_jump_relative_instruction(pool);
    int jump_save = instructions->size;
    add_instruction(jump);
    jump_if_false->data.jump_relative.target =
        instructions->size - if_false_save;
    compile_node(pool, node->data.ternary_if.else_body, instructions);
    jump->data.jump_relative.target = instructions->size - jump_save;
}

void compile_node(comp_f_args) {
    switch (node->type) {
        case AST_INT: {
            compile_int(pool, node, instructions);
            return;
        }
        case AST_FLOAT: {
            compile_float(pool, node, instructions);
            return;
        }
        case AST_BINARY_OP: {
            compile_binop(pool, node, instructions);
            return;
        }
        case AST_TERNARY: {
            compile_ternary_if(pool, node, instructions);
            return;
        }
        default:
            my_printf("unrecognized node!\n");
            my_printf("node type: %d\n", node->type);
            return;
    }
}

linked_list *compile(Compiler *compiler) {
    CompilationUnit *unit = my_alloc(compiler->pool, sizeof(CompilationUnit));
    unit->instructions = linked_list_create(compiler->pool);
    unit->pool = compiler->pool;
    compile_node(unit->pool, compiler->root, unit->instructions);
    linked_list_push(compiler->compilation_units, unit);
    return compiler->compilation_units;
}
