#ifndef C_FUNCTIONS_H
#define C_FUNCTIONS_H

#include "allocator.h"
#include "interpreter_error.h"
#include "lib.h"
#include "pyobject.h"

typedef PyObject* (*CFunctionPointer)(MemoryPool*, linked_list*,
                                      InterpreterError* error);

PyObject* add_binop_int_int(MemoryPool* pool, PyObject* lhs, PyObject* rhs,
                            InterpreterError* error);

PyObject* add_binop_float_float(MemoryPool* pool, PyObject* lhs, PyObject* rhs,
                                InterpreterError* error);

PyObject* add_binop_float_int(MemoryPool* pool, PyObject* lhs, PyObject* rhs,
                              InterpreterError* error);

PyObject* add_binop_int_float(MemoryPool* pool, PyObject* lhs, PyObject* rhs,
                              InterpreterError* error);

PyObject* add_binop(MemoryPool* pool, linked_list* objects,
                    InterpreterError* error);

PyObject* sub_binop_int_int(MemoryPool* pool, PyObject* lhs, PyObject* rhs,
                            InterpreterError* error);

PyObject* sub_binop_float_float(MemoryPool* pool, PyObject* lhs, PyObject* rhs,
                                InterpreterError* error);

PyObject* sub_binop_float_int(MemoryPool* pool, PyObject* lhs, PyObject* rhs,
                              InterpreterError* error);

PyObject* sub_binop_int_float(MemoryPool* pool, PyObject* lhs, PyObject* rhs,
                              InterpreterError* error);

PyObject* sub_binop(MemoryPool* pool, linked_list* objects,
                    InterpreterError* error);

PyObject* mul_binop_int_int(MemoryPool* pool, PyObject* lhs, PyObject* rhs,
                            InterpreterError* error);

PyObject* mul_binop_float_float(MemoryPool* pool, PyObject* lhs, PyObject* rhs,
                                InterpreterError* error);

PyObject* mul_binop_float_int(MemoryPool* pool, PyObject* lhs, PyObject* rhs,
                              InterpreterError* error);

PyObject* mul_binop_int_float(MemoryPool* pool, PyObject* lhs, PyObject* rhs,
                              InterpreterError* error);

PyObject* mul_binop(MemoryPool* pool, linked_list* objects,
                    InterpreterError* error);

PyObject* div_binop_int_int(MemoryPool* pool, PyObject* lhs, PyObject* rhs,
                            InterpreterError* error);

PyObject* div_binop_float_float(MemoryPool* pool, PyObject* lhs, PyObject* rhs,
                                InterpreterError* error);

PyObject* div_binop_float_int(MemoryPool* pool, PyObject* lhs, PyObject* rhs,
                              InterpreterError* error);

PyObject* div_binop_int_float(MemoryPool* pool, PyObject* lhs, PyObject* rhs,
                              InterpreterError* error);

PyObject* div_binop(MemoryPool* pool, linked_list* objects,
                    InterpreterError* error);

PyObject* lt_binop(MemoryPool* pool, linked_list* objects,
                   InterpreterError* error);

PyObject* leq_binop(MemoryPool* pool, linked_list* objects,
                    InterpreterError* error);

PyObject* gt_binop(MemoryPool* pool, linked_list* objects,
                   InterpreterError* error);

PyObject* geq_binop(MemoryPool* pool, linked_list* objects,
                    InterpreterError* error);

PyObject* eq_binop(MemoryPool* pool, linked_list* objects,
                   InterpreterError* error);

PyObject* neq_binop(MemoryPool* pool, linked_list* objects,
                    InterpreterError* error);

#endif  // C_FUNCTIONS_H
