#include "allocator.h"
#include "lib.h"
#include "pyobject.h"

#ifndef ENV_H
#define ENV_H

typedef struct Env {
    struct Env* parent;
    hash_table* context;
    MemoryPool* pool;
} Env;

void env_store(Env* env, string_view_t key, PyObject* object);
PyObject* env_load(Env* env, string_view_t key);

#endif  // ENV_Hs
