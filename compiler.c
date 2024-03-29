#include "compiler.h"

void compile_node(MemoryPool *pool, ASTNode *node, linked_list *instructions)
{
}

Instruction *create_instruction(MemoryPool *pool, InstructionType type)
{
    Instruction *instruction = my_alloc(pool, sizeof(Instruction));
    instruction->type = type;
    return instruction;
}

void compile_ident(MemoryPool *pool, ASTNode *node, linked_list *instructions)
{
    Instruction *inst = create_instruction(pool, LOAD);
    inst->data.load.name = node->data.ident_name;
    linked_list_push(instructions, inst);
}

void compile_number(MemoryPool *pool, ASTNode *node, linked_list *instructions)
{
    Instruction *inst = create_instruction(pool, PUSH);
}
