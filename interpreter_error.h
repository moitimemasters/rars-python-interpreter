#ifndef INTERPRETER_ERROR_H
#define INTERPRETER_ERROR_H

typedef enum {
    TypeError,
    DivisionByZeroError,
    UnrecognizedOperationError,
    NoMatchingImplementationError,
    NotEnoughArgsError,
    VariableNotFoundError,
} InterpreterError;

#endif  // INTERPRETER_ERROR_H
