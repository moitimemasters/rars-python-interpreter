#ifndef AST_H
#define AST_H

#include "allocator.h"
#include "lexer.h"
#include "lib.h"

typedef struct {
    MemoryPool *pool;
    Token *tokens;
    int current;
    int size;
    int current_indentation;
} ASTParser;

typedef enum {
    AST_INT,
    AST_FLOAT,
    AST_STRING,
    AST_BOOL,
    AST_NONE,
    AST_IDENT,
    AST_BINARY_OP,
    AST_UNARY_OP,
    AST_ASSIGN,
    AST_TERNARY,
    AST_POS_ARGUMENT,
    AST_ARGUMENT_LIST,
    AST_EXPRESSION_LIST,
    AST_LAMBDA,
    AST_FUNCTION_CALL,
    AST_FUNCTION_CALL_PARTIAL,
    AST_TUPLE,
    AST_LIST,
    AST_SET,
    AST_DICT,
    AST_INDEX,
    AST_INDEX_PARTIAL,
    AST_SLICE,
    AST_SLICE_PARTIAL,
    AST_IF_PARTIAL,
    AST_IF_STATEMENT,
    AST_FOR_LOOP,
    AST_WHILE_LOOP,
    AST_FUNCTION_DEF,
    AST_DEL,
    AST_BREAK,
    AST_RETURN,
    AST_SUBPROGRAM,
} ASTNodeType;

// AST node structure
typedef struct ASTNode {
    ASTNodeType type;
    union {
        int int_value;
        float float_value;
        string_view_t string_value;
        bool bool_value;
        string_view_t ident_name;
        struct {
            struct ASTNode *left;
            struct ASTNode *right;
            TokenType op;
        } binary_op;
        struct {
            struct ASTNode *operand;
            TokenType op;
        } unary_op;
        struct {
            struct ASTNode *target;
            struct ASTNode *value;
            TokenType op;
        } assign;
        struct {
            struct ASTNode *if_body;
            struct ASTNode *if_expr;
            struct ASTNode *else_body;
        } ternary_if;
        struct {
            linked_list *arguments;
        } argument_list;
        struct {
            struct ASTNode *args;
            struct ASTNode *body;
        } lambda_def;
        struct {
            struct ASTNode *arguments;
        } function_call_partial;
        struct {
            struct ASTNode *callee;
            struct ASTNode *argument_list;
        } function_call;
        struct {
            linked_list *items;
        } sequence;
        struct {
            linked_list *keys;
            linked_list *values;
        } mapping;
        struct {
            struct ASTNode *subject;
            struct ASTNode *index;
        } index_or_slice;
        struct {
            struct ASTNode *start;
            struct ASTNode *end;
            struct ASTNode *step;
        } slice_partial;
        struct {
            struct ASTNode *index;
        } index_partial;
        struct {
            struct ASTNode *condition;
            linked_list *body;
        } if_partial;
        struct {
            struct ASTNode *if_part;
            linked_list *elifs;
            struct ASTNode *else_part;
        } if_statement;
        struct {
            struct ASTNode *identifier;
            struct ASTNode *iterable;
            linked_list *body;
        } for_loop;
        struct {
            struct ASTNode *condition;
            linked_list *body;
        } while_loop;
        struct {
            struct ASTNode *name;
            struct ASTNode *arguments;
            struct ASTNode *body;
        } function_def;
        struct {
            struct ASTNode *target;
        } unary_stmt;
        struct {
            linked_list *statements;
        } subprogram;
    } data;
} ASTNode;

// Error codes
typedef enum {
    PARSE_SUCCESS,
    PARSE_ERROR_INVALID_TOKEN,
    PARSE_ERROR_UNEXPECTED_TOKEN,
    // Add more error codes as needed
} ParseErrorCode;

ASTNode *create_ast_node(ASTParser *parser, ASTNodeType type);

ASTNode *parse_expression(ASTParser *parser, ParseErrorCode *error_code);

ASTNode *parse_statement(ASTParser *parser, ParseErrorCode *error_code);

ASTNode *parse_program(ASTParser *parser, ParseErrorCode *error_code);

ASTNode *parse(ASTParser *ast_parser);

#endif
