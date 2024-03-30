#ifndef PYOBJECT_H
#define PYOBJECT_H

#include "allocator.h"
#include "lib.h"

typedef enum {
    PY_INT,
    PY_FLOAT,
    PY_BOOL,
} PyType;

typedef enum {
    OBJ_T_VALUE,
    OBJ_T_REFERENCE,
} ObjectType;

typedef struct {
    PyType type;
    union {
        int int_value;
        float float_value;
        bool bool_value;
        // TODO: Add more types
    } data;
} Value;  //< always copy the value

typedef struct {
    PyType type;
    void* data;
} Reference;  //< always pass by reference

typedef struct {
    ObjectType object_type;
    union {
        Value value;
        Reference reference;
    } data;
} PyObject;

PyObject* create_pyobject(MemoryPool* pool, ObjectType object_type);
PyObject* create_value(MemoryPool* pool, PyType pytype);
PyObject* create_int(MemoryPool* pool, int value);
PyObject* create_float(MemoryPool* pool, float value);
PyObject* create_bool(MemoryPool* pool, bool value);

#endif  // PYOBJECT_H
