#include "env.h"

#include "pyobject.h"

void env_store(Env* env, string_view_t key, PyObject* object) {
    PyObject* previous_object =
        hash_table_upsert_string(env->context, key, object);
    release_pyobject(env->pool, previous_object);
}

PyObject* env_load(Env* env, string_view_t key) {
    PyObject* object = hash_table_get_string(env->context, key);
    if (object == NULL) {
        if (env->parent == NULL) return NULL;
        return env_load(env->parent, key);
    }
    return copy_pyobject(env->pool, object);
}
