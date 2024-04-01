#include "c_functions.h"

#include "interpreter_error.h"
#include "pyobject.h"

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

PyObject* lt_binop_int_int(MemoryPool* pool, PyObject* lhs, PyObject* rhs,
                           InterpreterError* error) {
    PyObject* result = create_value(pool, PY_BOOL);
    result->data.value.data.bool_value =
        lhs->data.value.data.int_value < rhs->data.value.data.int_value;
    return result;
}

PyObject* lt_binop_float_float(MemoryPool* pool, PyObject* lhs, PyObject* rhs,
                               InterpreterError* error) {
    PyObject* result = create_value(pool, PY_BOOL);
    result->data.value.data.bool_value =
        lhs->data.value.data.float_value < rhs->data.value.data.float_value;
    return result;
}

PyObject* lt_binop_float_int(MemoryPool* pool, PyObject* lhs, PyObject* rhs,
                             InterpreterError* error) {
    PyObject* result = create_value(pool, PY_BOOL);
    result->data.value.data.bool_value =
        lhs->data.value.data.float_value < rhs->data.value.data.int_value;
    return result;
}

PyObject* lt_binop_int_float(MemoryPool* pool, PyObject* lhs, PyObject* rhs,
                             InterpreterError* error) {
    PyObject* result = create_value(pool, PY_BOOL);
    result->data.value.data.bool_value =
        lhs->data.value.data.int_value < rhs->data.value.data.float_value;
    return result;
}

PyObject* lt_binop(MemoryPool* pool, linked_list* objects,
                   InterpreterError* error) {
    if (objects->size != 2) {
        *error = TypeError;
        return NULL;
    }
    PyObject* lhs = linked_list_at(objects, 0);
    PyObject* rhs = linked_list_at(objects, 1);
    PyObject* (*div_binop_funcs[4])(binop_overload_args) = {
        lt_binop_int_int, lt_binop_float_float, lt_binop_float_int,
        lt_binop_int_float};

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

PyObject* leq_binop_int_int(MemoryPool* pool, PyObject* lhs, PyObject* rhs,
                            InterpreterError* error) {
    PyObject* result = create_value(pool, PY_BOOL);
    result->data.value.data.bool_value =
        lhs->data.value.data.int_value <= rhs->data.value.data.int_value;
    return result;
}

PyObject* leq_binop_float_float(MemoryPool* pool, PyObject* lhs, PyObject* rhs,
                                InterpreterError* error) {
    PyObject* result = create_value(pool, PY_BOOL);
    result->data.value.data.bool_value =
        lhs->data.value.data.float_value <= rhs->data.value.data.float_value;
    return result;
}

PyObject* leq_binop_float_int(MemoryPool* pool, PyObject* lhs, PyObject* rhs,
                              InterpreterError* error) {
    PyObject* result = create_value(pool, PY_BOOL);
    result->data.value.data.bool_value =
        lhs->data.value.data.float_value <= rhs->data.value.data.int_value;
    return result;
}

PyObject* leq_binop_int_float(MemoryPool* pool, PyObject* lhs, PyObject* rhs,
                              InterpreterError* error) {
    PyObject* result = create_value(pool, PY_BOOL);
    result->data.value.data.bool_value =
        lhs->data.value.data.int_value <= rhs->data.value.data.float_value;
    return result;
}

PyObject* leq_binop(MemoryPool* pool, linked_list* objects,
                    InterpreterError* error) {
    if (objects->size != 2) {
        *error = TypeError;
        return NULL;
    }
    PyObject* lhs = linked_list_at(objects, 0);
    PyObject* rhs = linked_list_at(objects, 1);
    PyObject* (*leq_binop_funcs[4])(binop_overload_args) = {
        leq_binop_int_int, leq_binop_float_float, leq_binop_float_int,
        leq_binop_int_float};

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
        return leq_binop_funcs[0](pool, lhs, rhs, error);
    } else if (lhs_type == PY_FLOAT && rhs_type == PY_FLOAT) {
        return leq_binop_funcs[1](pool, lhs, rhs, error);
    } else if (lhs_type == PY_FLOAT && rhs_type == PY_INT) {
        return leq_binop_funcs[2](pool, lhs, rhs, error);
    } else if (lhs_type == PY_INT && rhs_type == PY_FLOAT) {
        return leq_binop_funcs[3](pool, lhs, rhs, error);
    }
    *error = TypeError;
    return NULL;
}

PyObject* gt_binop(MemoryPool* pool, linked_list* objects,
                   InterpreterError* error) {
    PyObject* leq_result = leq_binop(pool, objects, error);
    if (!leq_result) {
        return NULL;
    }
    leq_result->data.value.data.bool_value =
        !leq_result->data.value.data.bool_value;
    return leq_result;
}

PyObject* geq_binop(MemoryPool* pool, linked_list* objects,
                    InterpreterError* error) {
    PyObject* lt_result = lt_binop(pool, objects, error);
    if (!lt_result) {
        return NULL;
    }
    lt_result->data.value.data.bool_value =
        !lt_result->data.value.data.bool_value;
    return lt_result;
}

PyObject* eq_binop_int_int(MemoryPool* pool, PyObject* lhs, PyObject* rhs,
                           InterpreterError* error) {
    PyObject* result = create_value(pool, PY_BOOL);
    result->data.value.data.bool_value =
        lhs->data.value.data.int_value == rhs->data.value.data.int_value;
    return result;
}

PyObject* eq_binop_float_float(MemoryPool* pool, PyObject* lhs, PyObject* rhs,
                               InterpreterError* error) {
    PyObject* result = create_value(pool, PY_BOOL);
    result->data.value.data.bool_value =
        lhs->data.value.data.float_value == rhs->data.value.data.float_value;
    return result;
}

PyObject* eq_binop_float_int(MemoryPool* pool, PyObject* lhs, PyObject* rhs,
                             InterpreterError* error) {
    PyObject* result = create_value(pool, PY_BOOL);
    result->data.value.data.bool_value =
        lhs->data.value.data.float_value == rhs->data.value.data.int_value;
    return result;
}

PyObject* eq_binop_int_float(MemoryPool* pool, PyObject* lhs, PyObject* rhs,
                             InterpreterError* error) {
    PyObject* result = create_value(pool, PY_BOOL);
    result->data.value.data.bool_value =
        lhs->data.value.data.int_value == rhs->data.value.data.float_value;
    return result;
}

PyObject* eq_binop(MemoryPool* pool, linked_list* objects,
                   InterpreterError* error) {
    if (objects->size != 2) {
        *error = TypeError;
        return NULL;
    }
    PyObject* lhs = linked_list_at(objects, 0);
    PyObject* rhs = linked_list_at(objects, 1);
    if (lhs->object_type != rhs->object_type) {
        *error = NoMatchingImplementationError;
        return NULL;
    }
    if (lhs->object_type == OBJ_T_REFERENCE) {
        return create_bool(
            pool, lhs->data.reference.data.ptr == rhs->data.reference.data.ptr);
    }
    PyObject* (*eq_binop_funcs[4])(binop_overload_args) = {
        eq_binop_int_int, eq_binop_float_float, eq_binop_float_int,
        eq_binop_int_float};
    PyType lhs_type = lhs->data.value.type;
    PyType rhs_type = rhs->data.value.type;
    if (lhs_type == PY_INT && rhs_type == PY_INT) {
        return eq_binop_funcs[0](pool, lhs, rhs, error);
    } else if (lhs_type == PY_FLOAT && rhs_type == PY_FLOAT) {
        return eq_binop_funcs[1](pool, lhs, rhs, error);
    } else if (lhs_type == PY_FLOAT && rhs_type == PY_INT) {
        return eq_binop_funcs[2](pool, lhs, rhs, error);
    } else if (lhs_type == PY_INT && rhs_type == PY_FLOAT) {
        return eq_binop_funcs[3](pool, lhs, rhs, error);
    }
    *error = TypeError;
    return NULL;
}

PyObject* neq_binop(MemoryPool* pool, linked_list* objects,
                    InterpreterError* error) {
    PyObject* eq_result = eq_binop(pool, objects, error);
    if (!eq_result) {
        return NULL;
    }
    eq_result->data.value.data.bool_value =
        !eq_result->data.value.data.bool_value;
    return eq_result;
}
