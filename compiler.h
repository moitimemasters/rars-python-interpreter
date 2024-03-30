#include "ast.h"
#include "lib.h"

#ifndef COMPILER_H
#define COMPILER_H

typedef enum {
    COMP_LOAD,
    COMP_LOAD_INT,
    COMP_LOAD_FLOAT,
    COMP_LOAD_BOOL,
    COMP_JUMP_REL,
    COMP_JUMP_REL_IF_FALSE,
    COMP_BINOP,
} InstructionType;

typedef struct {
    InstructionType type;
    union {
        int int_value;
        float float_value;
        bool bool_value;
        struct {
            TokenType op;
        } binop;

        struct {
            int target;
        } jump_relative;

        struct {
            int target;
        } jump_relative_if_false;
    } data;

} Instruction;

typedef struct {
    MemoryPool *pool;
    linked_list *instructions;
} CompilationUnit;

typedef struct {
    MemoryPool *pool;
    ASTNode *root;
    linked_list *compilation_units;
} Compiler;

linked_list *compile(Compiler *compiler);

#endif
