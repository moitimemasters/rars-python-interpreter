#include "pyobject.h"

#include "allocator.h"
#include "weak_ptr.h"

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

void release_pyobject(MemoryPool* pool, PyObject* obj) {
    if (obj == NULL) {
        return;
    }
    if (obj->object_type == OBJ_T_VALUE) {
        my_free(pool, obj);
    }
    if (obj->object_type == OBJ_T_REFERENCE) {
        release_shared(&obj->data.reference.data);
        my_free(pool, obj);
    }
}

PyObject* copy_pyobject(MemoryPool* pool, PyObject* obj) {
    if (obj == NULL) {
        return NULL;
    }
    if (obj->object_type == OBJ_T_VALUE) {
        PyObject* new_obj = create_value(pool, obj->data.value.type);
        new_obj->data = obj->data;
        return new_obj;
    } else {
        PyObject* new_obj = create_pyobject(pool, OBJ_T_REFERENCE);
        new_obj->data.reference.data = copy_shared(obj->data.reference.data);
        new_obj->data.reference.type = obj->data.reference.type;
        return new_obj;
    }
}
