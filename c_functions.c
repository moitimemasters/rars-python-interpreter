#include "c_functions.h"

#define binop_overload_args \
    MemoryPool *pool, PyObject *lhs, PyObject *rhs, InterpreterError *error

PyObject* add_binop_int_int(MemoryPool* pool, PyObject* lhs, PyObject* rhs,
                            InterpreterError* error) {
    PyObject* result = create_value(pool, PY_INT);
    result->data.value.data.int_value =
        lhs->data.value.data.int_value + rhs->data.value.data.int_value;
    return result;
}

PyObject* add_binop_float_float(MemoryPool* pool, PyObject* lhs, PyObject* rhs,
                                InterpreterError* error) {
    PyObject* result = create_value(pool, PY_FLOAT);
    result->data.value.data.float_value =
        lhs->data.value.data.float_value + rhs->data.value.data.float_value;
    return result;
}

PyObject* add_binop_float_int(MemoryPool* pool, PyObject* lhs, PyObject* rhs,
                              InterpreterError* error) {
    PyObject* result = create_value(pool, PY_FLOAT);
    result->data.value.data.float_value =
        lhs->data.value.data.float_value + rhs->data.value.data.int_value;
    return result;
}

PyObject* add_binop_int_float(MemoryPool* pool, PyObject* lhs, PyObject* rhs,
                              InterpreterError* error) {
    PyObject* result = create_value(pool, PY_FLOAT);
    result->data.value.data.float_value =
        lhs->data.value.data.int_value + rhs->data.value.data.float_value;
    return result;
}

PyObject* add_binop(MemoryPool* pool, linked_list* objects,
                    InterpreterError* error) {
    PyObject* lhs = linked_list_at(objects, 0);
    PyObject* rhs = linked_list_at(objects, 1);
    PyObject* (*add_binop_funcs[4])(binop_overload_args) = {
        add_binop_int_int, add_binop_float_float, add_binop_float_int,
        add_binop_int_float};

    if (lhs->object_type != OBJ_T_VALUE) {
        *error = TypeError;
        return NULL;
    }
    if (rhs->object_type != OBJ_T_VALUE) {
        *error = TypeError;
        return NULL;
    }
    PyType lhs_type = lhs->data.value.type;
    PyType rhs_type = rhs->data.value.type;
    if (lhs_type == PY_INT && rhs_type == PY_INT) {
        return add_binop_funcs[0](pool, lhs, rhs, error);
    } else if (lhs_type == PY_FLOAT && rhs_type == PY_FLOAT) {
        return add_binop_funcs[1](pool, lhs, rhs, error);
    } else if (lhs_type == PY_FLOAT && rhs_type == PY_INT) {
        return add_binop_funcs[2](pool, lhs, rhs, error);
    } else if (lhs_type == PY_INT && rhs_type == PY_FLOAT) {
        return add_binop_funcs[3](pool, lhs, rhs, error);
    }
    *error = TypeError;
    return NULL;
}

PyObject* sub_binop_int_int(MemoryPool* pool, PyObject* lhs, PyObject* rhs,
                            InterpreterError* error) {
    PyObject* result = create_value(pool, PY_INT);
    result->data.value.data.int_value =
        lhs->data.value.data.int_value - rhs->data.value.data.int_value;
    return result;
}

PyObject* sub_binop_float_float(MemoryPool* pool, PyObject* lhs, PyObject* rhs,
                                InterpreterError* error) {
    PyObject* result = create_value(pool, PY_FLOAT);
    result->data.value.data.float_value =
        lhs->data.value.data.float_value - rhs->data.value.data.float_value;
    return result;
}

PyObject* sub_binop_float_int(MemoryPool* pool, PyObject* lhs, PyObject* rhs,
                              InterpreterError* error) {
    PyObject* result = create_value(pool, PY_FLOAT);
    result->data.value.data.float_value =
        lhs->data.value.data.float_value - rhs->data.value.data.int_value;
    return result;
}

PyObject* sub_binop_int_float(MemoryPool* pool, PyObject* lhs, PyObject* rhs,
                              InterpreterError* error) {
    PyObject* result = create_value(pool, PY_FLOAT);
    result->data.value.data.float_value =
        lhs->data.value.data.int_value - rhs->data.value.data.float_value;
    return result;
}

PyObject* sub_binop(MemoryPool* pool, linked_list* objects,
                    InterpreterError* error) {
    PyObject* lhs = linked_list_at(objects, 0);
    PyObject* rhs = linked_list_at(objects, 1);
    PyObject* (*sub_binop_funcs[4])(binop_overload_args) = {
        sub_binop_int_int, sub_binop_float_float, sub_binop_float_int,
        sub_binop_int_float};

    if (lhs->object_type != OBJ_T_VALUE) {
        *error = TypeError;
        return NULL;
    }
    if (rhs->object_type != OBJ_T_VALUE) {
        *error = TypeError;
        return NULL;
    }
    PyType lhs_type = lhs->data.value.type;
    PyType rhs_type = rhs->data.value.type;
    if (lhs_type == PY_INT && rhs_type == PY_INT) {
        return sub_binop_funcs[0](pool, lhs, rhs, error);
    } else if (lhs_type == PY_FLOAT && rhs_type == PY_FLOAT) {
        return sub_binop_funcs[1](pool, lhs, rhs, error);
    } else if (lhs_type == PY_FLOAT && rhs_type == PY_INT) {
        return sub_binop_funcs[2](pool, lhs, rhs, error);
    } else if (lhs_type == PY_INT && rhs_type == PY_FLOAT) {
        return sub_binop_funcs[3](pool, lhs, rhs, error);
    }
    *error = TypeError;
    return NULL;
}

PyObject* mul_binop_int_int(MemoryPool* pool, PyObject* lhs, PyObject* rhs,
                            InterpreterError* error) {
    PyObject* result = create_value(pool, PY_INT);
    result->data.value.data.int_value =
        lhs->data.value.data.int_value * rhs->data.value.data.int_value;
    return result;
}

PyObject* mul_binop_float_float(MemoryPool* pool, PyObject* lhs, PyObject* rhs,
                                InterpreterError* error) {
    PyObject* result = create_value(pool, PY_FLOAT);
    result->data.value.data.float_value =
        lhs->data.value.data.float_value * rhs->data.value.data.float_value;
    return result;
}

PyObject* mul_binop_float_int(MemoryPool* pool, PyObject* lhs, PyObject* rhs,
                              InterpreterError* error) {
    PyObject* result = create_value(pool, PY_FLOAT);
    result->data.value.data.float_value =
        lhs->data.value.data.float_value * rhs->data.value.data.int_value;
    return result;
}

PyObject* mul_binop_int_float(MemoryPool* pool, PyObject* lhs, PyObject* rhs,
                              InterpreterError* error) {
    PyObject* result = create_value(pool, PY_FLOAT);
    result->data.value.data.float_value =
        lhs->data.value.data.int_value * rhs->data.value.data.float_value;
    return result;
}

PyObject* mul_binop(MemoryPool* pool, linked_list* objects,
                    InterpreterError* error) {
    PyObject* lhs = linked_list_at(objects, 0);
    PyObject* rhs = linked_list_at(objects, 1);
    PyObject* (*mul_binop_funcs[4])(binop_overload_args) = {
        mul_binop_int_int, mul_binop_float_float, mul_binop_float_int,
        mul_binop_int_float};

    if (lhs->object_type != OBJ_T_VALUE) {
        *error = TypeError;
        return NULL;
    }
    if (rhs->object_type != OBJ_T_VALUE) {
        *error = TypeError;
        return NULL;
    }
    PyType lhs_type = lhs->data.value.type;
    PyType rhs_type = rhs->data.value.type;
    if (lhs_type == PY_INT && rhs_type == PY_INT) {
        return mul_binop_funcs[0](pool, lhs, rhs, error);
    } else if (lhs_type == PY_FLOAT && rhs_type == PY_FLOAT) {
        return mul_binop_funcs[1](pool, lhs, rhs, error);
    } else if (lhs_type == PY_FLOAT && rhs_type == PY_INT) {
        return mul_binop_funcs[2](pool, lhs, rhs, error);
    } else if (lhs_type == PY_INT && rhs_type == PY_FLOAT) {
        return mul_binop_funcs[3](pool, lhs, rhs, error);
    }
    *error = TypeError;
    return NULL;
}

PyObject* div_binop_int_int(MemoryPool* pool, PyObject* lhs, PyObject* rhs,
                            InterpreterError* error) {
    PyObject* result = create_value(pool, PY_FLOAT);
    result->data.value.data.float_value =
        (float)lhs->data.value.data.int_value / rhs->data.value.data.int_value;
    return result;
}

PyObject* div_binop_float_float(MemoryPool* pool, PyObject* lhs, PyObject* rhs,
                                InterpreterError* error) {
    PyObject* result = create_value(pool, PY_FLOAT);
    result->data.value.data.float_value =
        lhs->data.value.data.float_value / rhs->data.value.data.float_value;
    return result;
}

PyObject* div_binop_float_int(MemoryPool* pool, PyObject* lhs, PyObject* rhs,
                              InterpreterError* error) {
    PyObject* result = create_value(pool, PY_FLOAT);
    result->data.value.data.float_value =
        lhs->data.value.data.float_value / rhs->data.value.data.int_value;
    return result;
}

PyObject* div_binop_int_float(MemoryPool* pool, PyObject* lhs, PyObject* rhs,
                              InterpreterError* error) {
    PyObject* result = create_value(pool, PY_FLOAT);
    result->data.value.data.float_value =
        lhs->data.value.data.int_value / rhs->data.value.data.float_value;
    return result;
}

PyObject* div_binop(MemoryPool* pool, linked_list* objects,
                    InterpreterError* error) {
    if (objects->size != 2) {
        *error = TypeError;
        return NULL;
    }
    PyObject* lhs = linked_list_at(objects, 0);
    PyObject* rhs = linked_list_at(objects, 1);
    PyObject* (*div_binop_funcs[4])(binop_overload_args) = {
        div_binop_int_int, div_binop_float_float, div_binop_float_int,
        div_binop_int_float};

    if (lhs->object_type != OBJ_T_VALUE) {
        *error = TypeError;
        return NULL;
    }
    if (rhs->object_type != OBJ_T_VALUE) {
        *error = TypeError;
        return NULL;
    }
    PyType lhs_type = lhs->data.value.type;
    PyType rhs_type = rhs->data.value.type;
    if (lhs_type == PY_INT && rhs_type == PY_INT) {
        return div_binop_funcs[0](pool, lhs, rhs, error);
    } else if (lhs_type == PY_FLOAT && rhs_type == PY_FLOAT) {
        return div_binop_funcs[1](pool, lhs, rhs, error);
    } else if (lhs_type == PY_FLOAT && rhs_type == PY_INT) {
        return div_binop_funcs[2](pool, lhs, rhs, error);
    } else if (lhs_type == PY_INT && rhs_type == PY_FLOAT) {
        return div_binop_funcs[3](pool, lhs, rhs, error);
    }
    *error = TypeError;
    return NULL;
}
