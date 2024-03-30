#include "c_functions.h"
#include "compiler.h"
#include "interpreter_error.h"
#include "pyobject.h"

#ifndef INTERPERTER_H
#define INTERPERTER_H

typedef struct Env {
    struct Env *parent;
    hash_table *context;
} Env;

typedef struct {
    MemoryPool *pool;
    Env *env;
    stack_t *stack;
    linked_list *compilation_units;
    hash_table *c_functions;
} Interpreter;

void interpret(Interpreter *interpreter);

#endif
