#include "ast.h"
#include "lib.h"

#ifndef COMPILER_H
#define COMPILER_H

typedef enum {
    COMP_LOAD,
    COMP_LOAD_NONE,
    COMP_LOAD_INT,
    COMP_LOAD_FLOAT,
    COMP_LOAD_BOOL,
    COMP_JUMP_REL,
    COMP_JUMP_REL_IF_FALSE,
    COMP_BINOP,
    COMP_STORE,
    COMP_STORE_INDEX,
    COMP_FUNCTION_ANON,
    COMP_RETURN,
    COMP_CALL,
} InstructionType;

typedef struct CompilationUnit {
    MemoryPool *pool;
    linked_list *instructions;
} CompilationUnit;

typedef struct {
    linked_list *signature;
    struct CompilationUnit *__code__;
} Func;

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

        struct {
            string_view_t ident;
        } load;
        struct {
            string_view_t ident;
        } store;
        struct {
            int num_args;
        } call;
        Func anonymous_function;
    } data;

} Instruction;

typedef struct {
    MemoryPool *pool;
    ASTNode *root;
} Compiler;

CompilationUnit *compile(Compiler *compiler);

#endif
