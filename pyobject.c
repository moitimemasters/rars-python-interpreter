#include "pyobject.h"

#include "allocator.h"

PyObject* create_pyobject(MemoryPool* pool, ObjectType object_type) {
    PyObject* object = my_alloc(pool, sizeof(PyObject));
    object->object_type = object_type;
    return object;
}

PyObject* create_value(MemoryPool* pool, PyType pytype) {
    PyObject* object = create_pyobject(pool, OBJ_T_VALUE);
    object->data.value.type = pytype;
    return object;
}

PyObject* create_int(MemoryPool* pool, int value) {
    PyObject* object = create_value(pool, PY_INT);
    object->data.value.data.int_value = value;
    return object;
}

PyObject* create_float(MemoryPool* pool, float value) {
    PyObject* object = create_value(pool, PY_FLOAT);
    object->data.value.data.float_value = value;
    return object;
}

PyObject* create_bool(MemoryPool* pool, bool value) {
    PyObject* object = create_value(pool, PY_BOOL);
    object->data.value.data.bool_value = value;
    return object;
}
