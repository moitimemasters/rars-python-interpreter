#include "c_functions.h"
#include "compiler.h"
#include "env.h"
#include "interpreter_error.h"
#include "pyobject.h"

#ifndef INTERPERTER_H
#define INTERPERTER_H

typedef struct {
    MemoryPool *pool;
    Env *env;
    stack_t *stack;
    CompilationUnit *program;
    hash_table *c_functions;
} Interpreter;

void interpret(Interpreter *interpreter);

#endif
