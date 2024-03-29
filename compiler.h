#include "ast.h"
#include "lib.h"
#include "allocator.h"

#ifndef COMPILER_HF
#define COMPILER_H

typedef enum
{
    LABEL,
    LOAD,
    STORE,
    CALL,
    DEF,
    PUSH,
} InstructionType;

typedef struct
{
    InstructionType type;
    union
    {
        struct
        {
            string_view_t name;
        } label;
        struct
        {
            string_view_t name;
        } load;
        struct
        {

        } push;
    } data;

} Instruction;

typedef struct
{
    ASTNode *node;
    linked_list *instructions;
} CompilationUnit;

typedef struct
{
    ASTNode *root;
    linked_list *compilation_units;
} Compiler;

typedef enum
{
    COMPILE_SUCCESS,
    COMPILE_ERROR,
} CompileErrorCode;

#endif
