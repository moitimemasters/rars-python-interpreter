#include "allocator.h"

#ifndef LEXER_H
#define LEXER_H

typedef enum
{
    TOK_INT,         /* integer */
    TOK_FLOAT,       /* float */
    TOK_STRING,      /* string */
    TOK_FALSE,       /* boolean type, "True" or "False" */
    TOK_TRUE,        /* boolean type, "True" or "False" */
    TOK_NONE,        /* "None" */
    TOK_IDENT,       /* identifier */
    TOK_ASSIGN,      /* assignment (=) */
    TOK_AS,          /* as ("as") */
    TOK_ASSERT,      /* assert ("assert") */
    TOK_PLUS,        /* addition (+) */
    TOK_AUGPLUS,     /* augmented addition ( += ) */
    TOK_PASS,        /* "pass" */
    TOK_MINUS,       /* subtraction (-) */
    TOK_AUGMINUS,    /* augmented subtraction (-) */
    TOK_MUL,         /* multiplication (*) */
    TOK_AUGMUL,      /* augemented multiplication (*=) */
    TOK_DIV,         /* division (/) */
    TOK_AUGDIV,      /* augmented division (/=) */
    TOK_FLOORDIV,    /* floor division (//) */
    TOK_AUGFLOORDIV, /* augmented floor division (//=) */
    TOK_MOD,         /* modulus (%) */
    TOK_AUGMOD,      /* augmented modulus (%=) */
    TOK_POW,         /* power (**) */
    TOK_AUGPOW,      /* augmented power (**=) */
    TOK_NOT,         /* logical NOT (not) */
    TOK_NONLOCAL,    /* logical NOT (not) */
    TOK_AND,         /* logical AND (and) */
    TOK_OR,          /* logical OR (or) */
    TOK_EQ,          /* equal (==) */
    TOK_NEQ,         /* not equal (!=) */
    TOK_LT,          /* less than (<) */
    TOK_LEQ,         /* less than or equal (<=) */
    TOK_GT,          /* greater than (>) */
    TOK_GEQ,         /* greater than or equal (>=) */
    TOK_GLOBAL,      /* global ("global") */
    TOK_IF,          /* "if" */
    TOK_IMPORT,      /* "import" */
    TOK_IN,          /* "in" */
    TOK_IS,          /* "is" */
    TOK_ELIF,        /* "elif" */
    TOK_ELSE,        /* "else" */
    TOK_WHILE,       /* "while" */
    TOK_WITH,        /* "with" */
    TOK_FOR,         /* "for" */
    TOK_FROM,        /* "from" */
    TOK_BREAK,       /* "break" */
    TOK_CONTINUE,    /* "continue" */
    TOK_DEF,         /* function definition "def" */
    TOK_DEL,         /* delete ("del") */
    TOK_RETURN,      /* "return" */
    TOK_RAISE,       /* "raise" */
    TOK_TRY,         /* "try" */
    TOK_EXCEPT,      /* "except" */
    TOK_FINALLY,     /* "finally" */
    TOK_CLR,         /* colon (:) new block start */
    TOK_LPAR,        /* left parenthesis ( */
    TOK_RPAR,        /* right parenthesis ) */
    TOK_LBRACKET,    /* left bracket [ */
    TOK_RBRACKET,    /* right bracket ] */
    TOK_LCURLY,      /* left curly brace { */
    TOK_LAMBDA,      /* "lambda" */
    TOK_RCURLY,      /* right curly brace } */
    TOK_COMMA,       /* comma (,) */
    TOK_DOT,         /* dot (.) */
    TOK_YIELD,       /* "yield" */
    TOK_END,         /* end of input */
    TOK_INVALID,     /* invalid token */
    TOK_INDENT,      /* token that indicated one indentation unit (by default 4 spaces) */
    TOK_NEWLINE,     /* token that indicated a new line */
} TokenType;

typedef struct
{
    TokenType type;     /* token type */
    const char *lexeme; /* token lexeme */
    int literal;        /* token literal (int or float) */
    int line;           /* token line number */
    size_t size;        /* token size */
} Token;

typedef struct
{
    const char *source;  /* source code */
    int current;         /* current position in the source code */
    int line;            /* current line number */
    int indentation;     /* indentation level */
    int column;          /* current column */
    size_t sourceLength; /* source length */
    bool indenting;
    MemoryPool *pool; /* memory pool */
} Lexer;

Lexer *make_lexer(char *source, MemoryPool *pool);

Token next_token(Lexer *lexer);

#endif
