#include "ast.h"

#define ensure_next()                                              \
    if (is_end(parser)) {                                          \
        report_parse_error(error_code, "Unexpected end of input"); \
        return NULL;                                               \
    }
#define ensure_next_msg(message)                 \
    if (is_end(parser)) {                        \
        report_parse_error(error_code, message); \
        return NULL;                             \
    }
#define ensure_parsed(node, message)             \
    if (node == NULL) {                          \
        report_parse_error(error_code, message); \
        return NULL;                             \
    }
#define parse_and_return(parse_function, node_name)          \
    ASTNode *node_name = parse_function(parser, error_code); \
    if (node_name) return node_name;                         \
    if (*error_code != PARSE_SUCCESS) return NULL;

void report_parse_error(ParseErrorCode *error_code, const char *message) {
    if (*error_code == PARSE_SUCCESS) {
        *error_code = PARSE_ERROR_INVALID_TOKEN;
        my_printf("Error: %s\n", message);
    }
}

ASTNode *create_ast_node(ASTParser *parser, ASTNodeType type) {
    ASTNode *node = my_alloc(parser->pool, sizeof(ASTNode));
    node->type = type;
    return node;
}

Token ast_peek(ASTParser *parser) { return parser->tokens[parser->current]; }

Token ast_consume(ASTParser *parser) {
    return parser->tokens[parser->current++];
}

bool is_end(ASTParser *parser) { return parser->current >= parser->size; }

ASTNode *parse_string(ASTParser *parser, ParseErrorCode *error_code) {
    if (is_end(parser)) {
        report_parse_error(error_code, "Unexpected end of input");
        return NULL;
    }
    Token token = ast_peek(parser);
    if (token.type != TOK_STRING) {
        return NULL;
    }
    ASTNode *node = create_ast_node(parser, AST_STRING);
    node->data.string_value = string_view(token.lexeme, token.size);
    ast_consume(parser);
    return node;
}

ASTNode *parse_set_or_dict(ASTParser *parser, ParseErrorCode *error_code) {
    parse_and_return(parse_string, string);
    if (is_end(parser)) {
        report_parse_error(error_code, "Unexpected end of input");
        return NULL;
    }
    Token peeked = ast_peek(parser);
    if (peeked.type != TOK_LCURLY) {
        return NULL;
    }
    if (is_end(parser)) {
        report_parse_error(error_code, "Unexpected end of input");
        return NULL;
    }
    linked_list *keys = linked_list_create(parser->pool);
    linked_list *values = linked_list_create(parser->pool);
    int is_set = -1;
    peeked = ast_peek(parser);
    while (peeked.type != TOK_RCURLY) {
        ASTNode *key = parse_expression(parser, error_code);
        if (key == NULL) {
            report_parse_error(
                error_code, "Expected item or closing of sequence delcaration");
            linked_list_free(keys);
            linked_list_free(values);
            return NULL;
        }
        if (is_set == -1) {
            if (is_end(parser)) {
                report_parse_error(error_code, "Unexpected end of input");
                linked_list_free(keys);
                linked_list_free(values);
                return NULL;
            }
            peeked = ast_peek(parser);
            if (peeked.type == TOK_CLR) {
                is_set = 0;
            } else if (peeked.type == TOK_COMMA || peeked.type == TOK_RCURLY) {
                is_set = 1;
            } else {
                report_parse_error(error_code,
                                   "Expected \":\" or \",\" or \"}\" after key "
                                   "in set or dict declaration");
                linked_list_free(keys);
                linked_list_free(values);
                return NULL;
            }
        }
        if (is_set == 1) {
            if (is_end(parser)) {
                report_parse_error(error_code, "Unexpected end of input");
                linked_list_free(keys);
                linked_list_free(values);
                return NULL;
            }
            peeked = ast_peek(parser);
            if (peeked.type != TOK_RCURLY && peeked.type != TOK_COMMA) {
                report_parse_error(
                    error_code,
                    "Expected \",\" or \"}\" after key in set declaration");
                linked_list_free(keys);
                linked_list_free(values);
                return NULL;
            }
            if (peeked.type == TOK_COMMA) {
                ast_consume(parser);
            }
        }
        if (is_set == 0) {
            if (is_end(parser)) {
                report_parse_error(error_code, "Unexpected end of input");
                linked_list_free(keys);
                linked_list_free(values);
                return NULL;
            }
            peeked = ast_peek(parser);
            if (peeked.type != TOK_RCURLY) {
                report_parse_error(
                    error_code, "Expected \":\" after key in dict declaration");
                linked_list_free(keys);
                linked_list_free(values);
                return NULL;
            }
            ast_consume(parser);
            ASTNode *value = parse_expression(parser, error_code);
            if (value == NULL) {
                report_parse_error(
                    error_code,
                    "Expected value after \":\" in set declaration");
                linked_list_free(keys);
                linked_list_free(values);
                return NULL;
            }
            linked_list_push(keys, key);
            if (is_end(parser)) {
                report_parse_error(error_code, "Unexpected end of input");
                linked_list_free(keys);
                linked_list_free(values);
                return NULL;
            }
            peeked = ast_peek(parser);
            if (peeked.type != TOK_RCURLY && peeked.type != TOK_COMMA) {
                report_parse_error(
                    error_code,
                    "Expected \"}\" or \",\" after value in dict declaration");
                linked_list_free(keys);
                linked_list_free(values);
                return NULL;
            }
        }
    }
    ast_consume(parser);
    if (is_set == -1 || is_set == 1) {
        ASTNode *node = create_ast_node(parser, AST_SET);
        node->data.sequence.items = keys;
        linked_list_free(values);
        return node;
    }

    ASTNode *node = create_ast_node(parser, AST_DICT);
    node->data.mapping.keys = keys;
    node->data.mapping.values = values;
    return node;
}

ASTNode *parse_list_or_tuple(ASTParser *parser, ParseErrorCode *error_code) {
    if (is_end(parser)) {
        report_parse_error(error_code, "Unexpected end of input");
        return NULL;
    }
    Token peeked = ast_peek(parser);
    if (peeked.type != TOK_LBRACKET && peeked.type != TOK_LPAR) {
        return parse_set_or_dict(parser, error_code);
    }
    ast_consume(parser);
    if (is_end(parser)) {
        report_parse_error(error_code, "Unexpected end of input");
        return NULL;
    }
    TokenType closing = (peeked.type == TOK_LBRACKET) ? TOK_RBRACKET : TOK_RPAR;
    ASTNode *node = create_ast_node(
        parser, (peeked.type == TOK_LBRACKET) ? AST_LIST : AST_TUPLE);
    node->data.sequence.items = linked_list_create(parser->pool);
    peeked = ast_peek(parser);
    bool trailing_comma = false;
    while (peeked.type != closing) {
        ASTNode *item = parse_expression(parser, error_code);
        if (item == NULL) {
            report_parse_error(
                error_code, "Expected item or closing of sequence delcaration");
            linked_list_free(node->data.sequence.items);
            my_free(parser->pool, node);
            return NULL;
        }
        linked_list_push(node->data.sequence.items, item);
        trailing_comma = false;
        if (is_end(parser)) {
            report_parse_error(error_code, "Unexpected end of input");
            linked_list_free(node->data.sequence.items);
            my_free(parser->pool, node);
            return NULL;
        }
        peeked = ast_peek(parser);
        if (peeked.type != TOK_COMMA && peeked.type != closing) {
            report_parse_error(error_code,
                               "Expected \",\" or \")\" after sequence item");
            linked_list_free(node->data.sequence.items);
            my_free(parser->pool, node);
            return NULL;
        }
        if (peeked.type == TOK_COMMA) {
            trailing_comma = true;
            ast_consume(parser);
        }
    }
    if (!trailing_comma && node->data.sequence.items->size == 1 &&
        closing == TOK_RPAR) {
        ast_consume(parser);
        return node->data.sequence.items->head->item;
    }
    ast_consume(parser);
    return node;
}

ASTNode *parse_argument(ASTParser *parser, ParseErrorCode *error_code) {
    if (is_end(parser)) {
        report_parse_error(error_code, "Unexpected end of input");
        return NULL;
    }
    Token ast_peeked = ast_peek(parser);
    if (ast_peeked.type == TOK_IDENT) {
        ast_consume(parser);
        ASTNode *node = create_ast_node(parser, AST_POS_ARGUMENT);
        node->data.ident_name = string_view(ast_peeked.lexeme, ast_peeked.size);
        return node;
    }
    return NULL;
}

ASTNode *parse_argument_list(ASTParser *parser, ParseErrorCode *error_code) {
    if (is_end(parser)) {
        return NULL;
    }
    ASTNode *node = create_ast_node(parser, AST_ARGUMENT_LIST);
    node->data.argument_list.arguments = linked_list_create(parser->pool);
    while (true) {
        ASTNode *arg = parse_argument(parser, error_code);
        if (arg == NULL) {
            if (*error_code != PARSE_SUCCESS) {
                return NULL;
            }
            break;
        }
        linked_list_push(node->data.argument_list.arguments, arg);
        if (ast_peek(parser).type != TOK_COMMA) {
            break;
        }
        ast_consume(parser);
    }
    return node;
}

ASTNode *parse_lambda(ASTParser *parser, ParseErrorCode *error_code) {
    ASTNode *list_or_tuple = parse_list_or_tuple(parser, error_code);
    if (list_or_tuple) {
        return list_or_tuple;
    }
    if (*error_code != PARSE_SUCCESS) {
        return NULL;
    }
    if (is_end(parser)) {
        report_parse_error(error_code, "Unexpected end of input");
        return NULL;
    }
    Token peeked = ast_peek(parser);
    if (peeked.type != TOK_LAMBDA) {
        return NULL;
    }
    ast_consume(parser);
    ASTNode *lambda_args = parse_argument_list(parser, error_code);
    if (lambda_args == NULL && ast_peek(parser).type != TOK_CLR) {
        report_parse_error(
            error_code, "Expected lambda arguments or \":\" after \"lambda\"");
        return NULL;
    }

    if (is_end(parser)) {
        report_parse_error(error_code, "Unexpected end of input");
        return NULL;
    }
    peeked = ast_peek(parser);
    if (peeked.type != TOK_CLR) {
        report_parse_error(error_code, "Expected \":\" after lambda arguments");
        my_printf("peeked token is: %s\n", ast_peek(parser).lexeme);
        return NULL;
    }
    ast_consume(parser);
    ASTNode *expr = parse_expression(parser, error_code);
    if (expr == NULL) {
        report_parse_error(
            error_code,
            "Expected expression or \"pass\" after lambda arguments");
        return NULL;
    }
    ASTNode *node = create_ast_node(parser, AST_LAMBDA);
    node->data.lambda_def.args = lambda_args;
    node->data.lambda_def.body = expr;
    return node;
}

ASTNode *parse_expression_list(ASTParser *parser, ParseErrorCode *error_code) {
    if (is_end(parser)) {
        return NULL;
    }
    ASTNode *node = create_ast_node(parser, AST_EXPRESSION_LIST);
    node->data.argument_list.arguments = linked_list_create(parser->pool);
    while (true) {
        ASTNode *expr = parse_expression(parser, error_code);
        if (expr == NULL) {
            if (*error_code != PARSE_SUCCESS) {
                return NULL;
            }
            break;
        }
        linked_list_push(node->data.argument_list.arguments, expr);
        if (ast_peek(parser).type != TOK_COMMA) {
            break;
        }
        ast_consume(parser);
    }
    return node;
}

ASTNode *parse_function_call_partial(ASTParser *parser,
                                     ParseErrorCode *error_code) {
    if (is_end(parser)) {
        return NULL;
    }
    if (ast_peek(parser).type != TOK_LPAR) {
        return NULL;
    }
    ast_consume(parser);
    ASTNode *expression_list = parse_expression_list(parser, error_code);
    if (expression_list == NULL && ast_peek(parser).type != TOK_RPAR) {
        report_parse_error(error_code,
                           "Expected expression list or \")\" after \"(\"");
        return NULL;
    }
    if (ast_peek(parser).type != TOK_RPAR) {
        report_parse_error(error_code, "Expected \")\" after expression list");
        return NULL;
    }
    ast_consume(parser);
    ASTNode *node = create_ast_node(parser, AST_FUNCTION_CALL_PARTIAL);
    node->data.function_call_partial.arguments = expression_list;
    return node;
}

ASTNode *parse_index_or_slice_partial(ASTParser *parser,
                                      ParseErrorCode *error_code) {
    if (is_end(parser)) {
        return NULL;
    }
    Token peeked = ast_peek(parser);
    if (peeked.type != TOK_LBRACKET) {
        return NULL;
    }
    ast_consume(parser);
    ASTNode *start = parse_expression(parser, error_code);
    if (start == NULL) {
        report_parse_error(error_code, "Expected expression after \"[\"");
        return NULL;
    }
    if (is_end(parser)) {
        my_free(parser->pool, start);
        report_parse_error(error_code, "Unexpected end of input");
        return NULL;
    }
    peeked = ast_peek(parser);
    if (peeked.type == TOK_RBRACKET) {
        ast_consume(parser);
        ASTNode *node = create_ast_node(parser, AST_INDEX_PARTIAL);
        node->data.index_partial.index = start;
        return node;
    }
    if (peeked.type != TOK_CLR) {
        my_free(parser->pool, start);
        report_parse_error(error_code,
                           "Expected \"]\" or \":\" after index start");
        return NULL;
    }
    ast_consume(parser);
    ASTNode *end = parse_expression(parser, error_code);
    if (end == NULL) {
        if (!is_end(parser) && ast_peek(parser).type == TOK_RBRACKET) {
            ast_consume(parser);
            ASTNode *node = create_ast_node(parser, AST_SLICE_PARTIAL);
            node->data.slice_partial.start = start;
            node->data.slice_partial.end = NULL;
            node->data.slice_partial.step = NULL;
            return node;
        }
        my_free(parser->pool, start);
        report_parse_error(error_code,
                           "Expected expression or \"]\" after \":\"");
        return NULL;
    }
    if (is_end(parser)) {
        my_free(parser->pool, start);
        report_parse_error(error_code, "Unexpected end of input");
        return NULL;
    }
    peeked = ast_peek(parser);
    if (peeked.type == TOK_RBRACKET) {
        ast_consume(parser);
        ASTNode *node = create_ast_node(parser, AST_SLICE_PARTIAL);
        node->data.slice_partial.start = start;
        node->data.slice_partial.end = end;
        node->data.slice_partial.step = NULL;
    }
    if (peeked.type != TOK_CLR) {
        my_free(parser->pool, start);
        report_parse_error(error_code,
                           "Expected \"]\" or \":\" after index start");
        return NULL;
    }
    ASTNode *step = parse_expression(parser, error_code);
    if (step == NULL) {
        if (!is_end(parser) && ast_peek(parser).type == TOK_RBRACKET) {
            ast_consume(parser);
            ASTNode *node = create_ast_node(parser, AST_SLICE_PARTIAL);
            node->data.slice_partial.start = start;
            node->data.slice_partial.end = end;
            node->data.slice_partial.step = NULL;
            return node;
        }
        my_free(parser->pool, start);
        my_free(parser->pool, end);
        report_parse_error(error_code,
                           "Expected expression or \"]\" after \":\"");
        return NULL;
    }
    if (is_end(parser)) {
        my_free(parser->pool, start);
        my_free(parser->pool, end);
        my_free(parser->pool, step);
        report_parse_error(error_code, "Unexpected end of input");
        return NULL;
    }
    if (ast_peek(parser).type != TOK_RBRACKET) {
        my_free(parser->pool, start);
        my_free(parser->pool, end);
        my_free(parser->pool, step);
        report_parse_error(error_code, "Expected \"]\" after slice step");
        return NULL;
    }
    ast_consume(parser);
    ASTNode *node = create_ast_node(parser, AST_SLICE_PARTIAL);
    node->data.slice_partial.start = start;
    node->data.slice_partial.end = end;
    node->data.slice_partial.step = step;
    return node;
}

ASTNode *parse_ident(ASTParser *parser, ParseErrorCode *error_code) {
    parse_and_return(parse_lambda, lambda_def);
    if (is_end(parser)) {
        return NULL;
    }
    Token peeked = ast_peek(parser);
    if (peeked.type != TOK_IDENT) {
        return NULL;
    }
    ast_consume(parser);
    ASTNode *node = create_ast_node(parser, AST_IDENT);
    node->data.ident_name = string_view(peeked.lexeme, peeked.size);
    return node;
}

ASTNode *parse_number(ASTParser *parser, ParseErrorCode *error_code) {
    ASTNode *ident = parse_ident(parser, error_code);
    if (ident) {
        return ident;
    }
    if (*error_code != PARSE_SUCCESS) {
        return NULL;
    }
    Token ast_peeked = ast_peek(parser);
    if (ast_peeked.type == TOK_INT) {
        int value = 0;
        for (int i = 0; i < ast_peeked.size; i++) {
            value = value * 10 + ast_peeked.lexeme[i] - '0';
        }
        ast_consume(parser);
        ASTNode *node = create_ast_node(parser, AST_INT);
        node->data.int_value = value;
        return node;
    }
    if (ast_peeked.type == TOK_FLOAT) {
        float value = 0;
        int before_dot = 0;
        int after_dot = 0;
        int i = 0;
        for (; i < ast_peeked.size; i++) {
            if (ast_peeked.lexeme[i] == '.') {
                ++i;
                break;
            }
            before_dot = before_dot * 10 + ast_peeked.lexeme[i] - '0';
        }
        int power = 1;
        for (; i < ast_peeked.size; i++, power *= 10) {
            after_dot = after_dot * 10 + ast_peeked.lexeme[i] - '0';
        }
        ast_consume(parser);
        value = before_dot + (float)after_dot / power;
        ASTNode *node = create_ast_node(parser, AST_FLOAT);
        node->data.float_value = value;
        return node;
    }
    return NULL;
}

ASTNode *parse_primary(ASTParser *parser, ParseErrorCode *error_code) {
    ASTNode *number = parse_number(parser, error_code);
    // FIXME: number can be primary expression, considering the logic of tuple,
    // maybe return null there
    if (number) {
        return number;
    }
    if (*error_code != PARSE_SUCCESS) {
        return NULL;
    }
    if (is_end(parser)) {
        report_parse_error(error_code, "Unexpected end of input");
        return NULL;
    }
    Token ast_peeked = ast_peek(parser);
    if (ast_peeked.type == TOK_LPAR) {
        ast_consume(parser);
        ASTNode *node = parse_expression(parser, error_code);
        if (*error_code != PARSE_SUCCESS) {
            return NULL;
        }
        if (is_end(parser)) {
            report_parse_error(error_code, "Expected )");
            return NULL;
        }
        ast_peeked = ast_peek(parser);
        if (ast_peeked.type != TOK_RPAR) {
            report_parse_error(error_code, "Expected )");
            return NULL;
        }
        ast_consume(parser);
        return node;
    }
}

ASTNode *parse_expression_stripped(ASTParser *parser,
                                   ParseErrorCode *error_code) {
    return parse_primary(parser, error_code);
}

ASTNode *parse_tail(ASTParser *parser, ParseErrorCode *error_code) {
    ASTNode *node = parse_expression_stripped(parser, error_code);
    if (node == NULL) {
        return NULL;
    }
    while (true) {
        ASTNode *index_or_slice =
            parse_index_or_slice_partial(parser, error_code);
        if (index_or_slice != NULL) {
            if (*error_code != PARSE_SUCCESS) {
                my_free(parser->pool, node);
                return NULL;
            }
            ASTNode *new_node = create_ast_node(
                parser, (index_or_slice->type == AST_SLICE_PARTIAL)
                            ? AST_SLICE
                            : AST_INDEX);
            new_node->data.index_or_slice.index = index_or_slice;
            new_node->data.index_or_slice.subject = node;
            node = new_node;
            continue;
        }
        ASTNode *function_call =
            parse_function_call_partial(parser, error_code);
        if (function_call) {
            if (*error_code != PARSE_SUCCESS) {
                my_free(parser->pool, node);
                return NULL;
            }
            ASTNode *new_node = create_ast_node(parser, AST_FUNCTION_CALL);
            new_node->data.function_call.callee = node;
            new_node->data.function_call.argument_list = function_call;
            node = new_node;
            continue;
        }
        break;
    }
    return node;
}

ASTNode *parse_product(ASTParser *parser, ParseErrorCode *error_code) {
    ASTNode *left = parse_tail(parser, error_code);
    if (*error_code != PARSE_SUCCESS) {
        return NULL;
    }
    if (is_end(parser)) {
        return left;
    }
    Token ast_peeked = ast_peek(parser);
    while (ast_peeked.type == TOK_MUL || ast_peeked.type == TOK_DIV ||
           ast_peeked.type == TOK_FLOORDIV || ast_peeked.type == TOK_MOD) {
        ast_consume(parser);
        ASTNode *right = parse_tail(parser, error_code);
        if (*error_code != PARSE_SUCCESS) {
            return NULL;
        }
        ASTNode *node = create_ast_node(parser, AST_BINARY_OP);
        node->data.binary_op.left = left;
        node->data.binary_op.right = right;
        node->data.binary_op.op = ast_peeked.type;
        left = node;
        ast_peeked = ast_peek(parser);
        if (is_end(parser)) {
            return left;
        }
    }
    return left;
}

ASTNode *parse_sum(ASTParser *parser, ParseErrorCode *error_code) {
    ASTNode *left = parse_product(parser, error_code);
    if (*error_code != PARSE_SUCCESS) {
        return NULL;
    }
    if (is_end(parser)) {
        return left;
    }
    Token ast_peeked = ast_peek(parser);
    while (ast_peeked.type == TOK_PLUS || ast_peeked.type == TOK_MINUS) {
        ast_consume(parser);
        ASTNode *right = parse_product(parser, error_code);
        if (*error_code != PARSE_SUCCESS) {
            return NULL;
        }
        ASTNode *node = create_ast_node(parser, AST_BINARY_OP);
        node->data.binary_op.left = left;
        node->data.binary_op.right = right;
        node->data.binary_op.op = ast_peeked.type;
        left = node;
        ast_peeked = ast_peek(parser);
        if (is_end(parser)) {
            return left;
        }
    }
    return left;
}

ASTNode *parse_comparison(ASTParser *parser, ParseErrorCode *error_code) {
    ASTNode *left = parse_sum(parser, error_code);
    if (*error_code != PARSE_SUCCESS) {
        return NULL;
    }
    if (is_end(parser)) {
        return left;
    }
    Token ast_peeked = ast_peek(parser);
    if (ast_peeked.type == TOK_LT || ast_peeked.type == TOK_LEQ ||
        ast_peeked.type == TOK_GT || ast_peeked.type == TOK_GEQ ||
        ast_peeked.type == TOK_EQ) {
        ast_consume(parser);
        ASTNode *right = parse_sum(parser, error_code);
        if (*error_code != PARSE_SUCCESS) {
            return NULL;
        }
        ASTNode *node = create_ast_node(parser, AST_BINARY_OP);
        node->data.binary_op.left = left;
        node->data.binary_op.right = right;
        node->data.binary_op.op = ast_peeked.type;
        left = node;
    }
    return left;
}

ASTNode *parse_logical(ASTParser *parser, ParseErrorCode *error_code) {
    ASTNode *left = parse_comparison(parser, error_code);
    if (*error_code != PARSE_SUCCESS) {
        return NULL;
    }
    if (is_end(parser)) {
        return left;
    }
    Token ast_peeked = ast_peek(parser);
    while (ast_peeked.type == TOK_AND || ast_peeked.type == TOK_OR) {
        ast_consume(parser);
        ASTNode *right = parse_comparison(parser, error_code);
        if (*error_code != PARSE_SUCCESS) {
            return NULL;
        }
        ASTNode *node = create_ast_node(parser, AST_BINARY_OP);
        node->data.binary_op.left = left;
        node->data.binary_op.right = right;
        node->data.binary_op.op = ast_peeked.type;
        left = node;
        ast_peeked = ast_peek(parser);
        if (is_end(parser)) {
            return left;
        }
    }
    return left;
}

ASTNode *parse_expression(ASTParser *parser, ParseErrorCode *error_code) {
    ASTNode *if_body = parse_logical(parser, error_code);
    if (!if_body) {
        my_printf("if tern expr is null\n");
        return NULL;
    }
    if (is_end(parser)) {
        return if_body;
    }
    Token peeked = ast_peek(parser);
    if (peeked.type != TOK_IF) {
        return if_body;
    }
    ast_consume(parser);
    ASTNode *if_expr = parse_logical(parser, error_code);
    if (!if_expr) {
        report_parse_error(error_code, "Expected expression after ternary if");
        return NULL;
    }
    if (is_end(parser)) {
        report_parse_error(
            error_code,
            "Unexpected end of input, expected \"else\" after ternary if");
        return NULL;
    }
    peeked = ast_peek(parser);
    if (peeked.type != TOK_ELSE) {
        report_parse_error(error_code, "Expected \"else\" after ternary if");
        return NULL;
    }
    ast_consume(parser);
    ASTNode *else_body = parse_logical(parser, error_code);
    if (!else_body) {
        report_parse_error(error_code,
                           "Expected expression after \"else\" in ternary if");
        return NULL;
    }
    ASTNode *node = create_ast_node(parser, AST_TERNARY);
    node->data.ternary_if.if_body = if_body;
    node->data.ternary_if.if_expr = if_expr;
    node->data.ternary_if.else_body = else_body;
    return node;
}

void ast_skip_indentation(ASTParser *parser) {
    while (!is_end(parser) && ast_peek(parser).type == TOK_INDENT ||
           ast_peek(parser).type == TOK_NEWLINE) {
        if (ast_peek(parser).type == TOK_NEWLINE) {
            parser->current_indentation = -1;
        }
        ast_consume(parser);
        parser->current_indentation++;
    }
}

void retract_indentation(ASTParser *parser) { parser->current_indentation--; }

ASTNode *parse_condition_partial(ASTParser *parser, TokenType conditional_type,
                                 bool needs_condition,
                                 ParseErrorCode *error_code) {
    if (is_end(parser)) {
        return NULL;
    }

    Token peeked = ast_peek(parser);
    if (peeked.type != conditional_type) {
        return NULL;
    }
    int current_indentation = parser->current_indentation;
    ast_consume(parser);
    ASTNode *condition = NULL;
    if (needs_condition) {
        condition = parse_expression(parser, error_code);
        if (*error_code != PARSE_SUCCESS) {
            return NULL;
        }
        if (condition == NULL) {
            report_parse_error(error_code, "Expected condition after \"if\"");
            return NULL;
        }
    }
    if (is_end(parser)) {
        report_parse_error(error_code, "Unexpected end of input");
        if (needs_condition) {
            my_free(parser->pool, condition);
        }
        return NULL;
    }
    peeked = ast_peek(parser);
    if (peeked.type != TOK_CLR) {
        report_parse_error(error_code, "Expected \":\" after condition");
        if (needs_condition) {
            my_free(parser->pool, condition);
        }
        return NULL;
    }
    ast_consume(parser);

    ast_skip_indentation(parser);
    if (parser->current_indentation != current_indentation + 1) {
        report_parse_error(error_code, "Unexpected indentation after \":\"");
        if (needs_condition) {
            my_free(parser->pool, condition);
        }
        return NULL;
    }
    if (is_end(parser)) {
        report_parse_error(error_code, "Unexpected end of input");
        if (needs_condition) {
            my_free(parser->pool, condition);
        }
        return NULL;
    }
    ASTNode *statement = parse_statement(parser, error_code);
    if (!statement) {
        if (needs_condition) {
            my_free(parser->pool, condition);
        }
        report_parse_error(error_code, "Expected statement after if");
        return NULL;
    }
    ASTNode *node = create_ast_node(parser, AST_IF_PARTIAL);

    node->data.if_partial.condition = condition;
    node->data.if_partial.body = linked_list_create(parser->pool);
    linked_list_push(node->data.if_partial.body, statement);
    ast_skip_indentation(parser);
    while (!is_end(parser) &&
           parser->current_indentation == current_indentation + 1) {
        ASTNode *statement = parse_statement(parser, error_code);
        if (!statement) {
            my_free(parser->pool, node);
            if (needs_condition) {
                my_free(parser->pool, condition);
            }
            linked_list_free(node->data.if_partial.body);
            return NULL;
        }
        linked_list_push(node->data.if_partial.body, statement);

        ast_skip_indentation(parser);
    }
    if (parser->current_indentation > current_indentation + 1) {
        my_free(parser->pool, node);
        if (needs_condition) {
            my_free(parser->pool, condition);
        }
        linked_list_free(node->data.if_partial.body);
        report_parse_error(error_code, "Unexpected indentation");
        return NULL;
    }
    return node;
}

ASTNode *parse_if_statement(ASTParser *parser, ParseErrorCode *error_code) {
    int current_indentation = parser->current_indentation;
    ASTNode *if_part =
        parse_condition_partial(parser, TOK_IF, true, error_code);
    if (!if_part) {
        return NULL;
    }
    ASTNode *node = create_ast_node(parser, AST_IF_STATEMENT);
    node->data.if_statement.if_part = if_part;
    node->data.if_statement.else_part = NULL;
    node->data.if_statement.elifs = linked_list_create(parser->pool);
    while (!is_end(parser)) {
        ast_skip_indentation(parser);
        if (parser->current_indentation != current_indentation) {
            break;
        }
        ASTNode *elif_part =
            parse_condition_partial(parser, TOK_ELIF, true, error_code);
        if (*error_code != PARSE_SUCCESS) {
            linked_list_free(node->data.if_statement.elifs);
            my_free(parser->pool, node);
            my_free(parser->pool, if_part);
            return NULL;
        }
        if (!elif_part) {
            break;
        }
        linked_list_push(node->data.if_statement.elifs, elif_part);
    }
    if (parser->current_indentation != current_indentation) {
        if (parser->current_indentation > current_indentation) {
            report_parse_error(error_code, "Unexpected indentation");
        }
        my_printf("current indentation: %d, expected indentation: %d",
                  parser->current_indentation, current_indentation);
        return node;
    }
    ASTNode *else_part =
        parse_condition_partial(parser, TOK_ELSE, false, error_code);
    if (*error_code != PARSE_SUCCESS) {
        linked_list_free(node->data.if_statement.elifs);
        my_free(parser->pool, node);
        my_free(parser->pool, if_part);
        return NULL;
    }
    node->data.if_statement.else_part = else_part;
    return node;
}

ASTNode *parse_for_loop(ASTParser *parser, ParseErrorCode *error_code) {
    ensure_next();
    Token peeked = ast_peek(parser);
    if (peeked.type != TOK_FOR) {
        return NULL;
    }
    int current_indentation = parser->current_indentation;
    ast_consume(parser);
    ASTNode *identifier = parse_ident(parser, error_code);
    ensure_parsed(identifier, "Expected identifier after for");
    ensure_next();
    peeked = ast_peek(parser);
    if (peeked.type != TOK_IN) {
        report_parse_error(error_code, "Expected \"in\" after for");
        my_free(parser->pool, identifier);
        return NULL;
    }
    ast_consume(parser);
    ASTNode *iterable = parse_expression(parser, error_code);
    ensure_parsed(iterable, "Expected expression after \"in\"");
    ensure_next();
    if (ast_peek(parser).type != TOK_CLR) {
        report_parse_error(error_code, "Expected \":\" after for");
        my_free(parser->pool, identifier);
        my_free(parser->pool, iterable);
        return NULL;
    }
    ast_consume(parser);
    ast_skip_indentation(parser);
    if (parser->current_indentation != current_indentation + 1) {
        report_parse_error(error_code, "Expected indentation after \":\"");
        my_free(parser->pool, identifier);
        my_free(parser->pool, iterable);
        return NULL;
    }
    ASTNode *first_statement = parse_statement(parser, error_code);
    if (first_statement == NULL) {
        report_parse_error(error_code,
                           "Expected statement or \"pass\" after for");
        my_free(parser->pool, identifier);
        my_free(parser->pool, iterable);
        return NULL;
    }
    ASTNode *node = create_ast_node(parser, AST_FOR_LOOP);
    node->data.for_loop.identifier = identifier;
    node->data.for_loop.iterable = iterable;
    node->data.for_loop.body = linked_list_create(parser->pool);

    ast_skip_indentation(parser);
    while (!is_end(parser) &&
           current_indentation + 1 == parser->current_indentation) {
        ASTNode *statement = parse_statement(parser, error_code);
        if (statement == NULL) {
            my_free(parser->pool, node);
            my_free(parser->pool, identifier);
            my_free(parser->pool, iterable);
            linked_list_free(node->data.for_loop.body);
            report_parse_error(error_code,
                               "Expected statement or \"pass\" after for");
            return NULL;
        }
        linked_list_push(node->data.for_loop.body, statement);

        ast_skip_indentation(parser);
    }
    if (parser->current_indentation > current_indentation + 1) {
        my_free(parser->pool, node);
        my_free(parser->pool, identifier);
        my_free(parser->pool, iterable);
        linked_list_free(node->data.for_loop.body);
        report_parse_error(error_code, "Unexpected indentation after for loop");
        return NULL;
    }
    return node;
}

ASTNode *parse_while(ASTParser *parser, ParseErrorCode *error_code) {
    if (is_end(parser)) {
        return NULL;
    }
    int current_indentation = parser->current_indentation;
    if (ast_peek(parser).type != TOK_WHILE) {
        return NULL;
    }
    ast_consume(parser);
    ASTNode *condition = parse_expression(parser, error_code);
    if (!condition && ast_peek(parser).type != TOK_CLR) {
        report_parse_error(error_code,
                           "Expected condition or \":\" after \"while\"");
        return NULL;
    }
    if (ast_peek(parser).type != TOK_CLR) {
        report_parse_error(error_code, "Expected \":\" after condition");
        my_free(parser->pool, condition);
        return NULL;
    }
    ast_consume(parser);
    ast_skip_indentation(parser);
    if (parser->current_indentation != current_indentation + 1) {
        report_parse_error(error_code, "Unexpected indentation after \":\"");
        my_free(parser->pool, condition);
        return NULL;
    }
    ASTNode *first_statement = parse_statement(parser, error_code);
    if (first_statement == NULL) {
        report_parse_error(error_code,
                           "Expected statement or \"pass\" after while");
        my_free(parser->pool, condition);
        return NULL;
    }
    ASTNode *node = create_ast_node(parser, AST_WHILE_LOOP);
    node->data.while_loop.condition = condition;
    node->data.while_loop.body = linked_list_create(parser->pool);
    linked_list_push(node->data.while_loop.body, first_statement);
    while (true) {
        ast_skip_indentation(parser);
        if (is_end(parser) ||
            parser->current_indentation != current_indentation + 1) {
            break;
        }
        ASTNode *statement = parse_statement(parser, error_code);
        if (statement == NULL) {
            if (*error_code != PARSE_SUCCESS) {
                my_free(parser->pool, node);
                my_free(parser->pool, condition);
                linked_list_free(node->data.while_loop.body);
                return NULL;
            }
            break;
        }
        linked_list_push(node->data.while_loop.body, statement);
    }
    if (parser->current_indentation > current_indentation + 1) {
        my_free(parser->pool, node);
        my_free(parser->pool, condition);
        linked_list_free(node->data.while_loop.body);
        report_parse_error(error_code,
                           "Unexpected indentation after while loop");
        return NULL;
    }
    return node;
}

ASTNode *parse_function_definition(ASTParser *parser,
                                   ParseErrorCode *error_code) {
    if (is_end(parser)) {
        return NULL;
    }
    if (ast_peek(parser).type != TOK_DEF) {
        return NULL;
    }
    int current_indentation = parser->current_indentation;
    ast_consume(parser);
    ASTNode *identifier = parse_ident(parser, error_code);
    if (!identifier) {
        report_parse_error(error_code, "Expected function name after def");
        return NULL;
    }
    if (ast_peek(parser).type != TOK_LPAR) {
        report_parse_error(error_code, "Expected \"(\" after function name");
        my_free(parser->pool, identifier);
        return NULL;
    }
    ast_consume(parser);
    ASTNode *argument_list = parse_argument_list(parser, error_code);
    if (ast_peek(parser).type != TOK_RPAR) {
        report_parse_error(error_code, "Expected \")\" after argument list");
        my_free(parser->pool, identifier);
        my_free(parser->pool, argument_list);
        return NULL;
    }
    ast_consume(parser);
    if (ast_peek(parser).type != TOK_CLR) {
        report_parse_error(error_code,
                           "Expected \":\" after function definition");
        my_free(parser->pool, identifier);
        my_free(parser->pool, argument_list);
        return NULL;
    }
    ast_consume(parser);
    ast_skip_indentation(parser);
    if (parser->current_indentation != current_indentation + 1) {
        report_parse_error(error_code, "Unexpected indentation after \":\"");
        my_free(parser->pool, identifier);
        my_free(parser->pool, argument_list);
        return NULL;
    }
    ASTNode *first_statement = parse_statement(parser, error_code);
    if (first_statement == NULL) {
        report_parse_error(error_code,
                           "Expected statement or \"pass\" after while");
        my_free(parser->pool, identifier);
        my_free(parser->pool, argument_list);
        return NULL;
    }
    ASTNode *node = create_ast_node(parser, AST_FUNCTION_DEF);
    node->data.function_def.name = identifier;
    node->data.function_def.arguments = argument_list;
    ASTNode *subprogram = create_ast_node(parser, AST_SUBPROGRAM);
    subprogram->data.subprogram.statements = linked_list_create(parser->pool);
    node->data.function_def.body = subprogram;
    linked_list_push(subprogram->data.subprogram.statements, first_statement);
    while (true) {
        ast_skip_indentation(parser);
        if (is_end(parser) ||
            parser->current_indentation != current_indentation + 1) {
            break;
        }
        ASTNode *statement = parse_statement(parser, error_code);
        if (statement == NULL) {
            if (*error_code != PARSE_SUCCESS) {
                my_free(parser->pool, node);
                my_free(parser->pool, argument_list);
                my_free(parser->pool, subprogram);
                linked_list_free(subprogram->data.subprogram.statements);
                return NULL;
            }
            break;
        }
        linked_list_push(subprogram->data.subprogram.statements, statement);
    }
    if (parser->current_indentation > current_indentation + 1) {
        my_free(parser->pool, node);
        my_free(parser->pool, argument_list);
        my_free(parser->pool, subprogram);
        linked_list_free(subprogram->data.subprogram.statements);
        report_parse_error(error_code,
                           "Unexpected indentation after function definition");
        return NULL;
    }
    return node;
}

ASTNode *parse_assign(ASTParser *parser, ParseErrorCode *error_code) {
    if (is_end(parser)) {
        return NULL;
    }
    ASTNode *target = parse_expression(parser, error_code);
    if (target == NULL) {
        return NULL;
    }
    while (true) {
        if (is_end(parser)) {
            return target;
        }
        TokenType peeked_type = ast_peek(parser).type;
        if (peeked_type != TOK_ASSIGN && peeked_type != TOK_AUGPLUS &&
            peeked_type != TOK_AUGMINUS && peeked_type != TOK_AUGMUL &&
            peeked_type != TOK_AUGDIV && peeked_type != TOK_AUGMOD &&
            peeked_type != TOK_AUGPOW) {
            return target;
        }
        ast_consume(parser);
        ASTNode *value = parse_expression(parser, error_code);
        if (value == NULL) {
            report_parse_error(error_code, "Expected value after assignment");
            my_free(parser->pool, target);
            return NULL;
        }
        ASTNode *node = create_ast_node(parser, AST_ASSIGN);
        node->data.assign.target = target;
        node->data.assign.value = value;
        node->data.assign.op = peeked_type;
        target = node;
    }
}

ASTNode *parse_unary_statement(ASTParser *parser, TokenType ttype,
                               ASTNodeType atype, ParseErrorCode *error_code) {
    if (is_end(parser)) {
        return NULL;
    }
    if (ast_peek(parser).type != ttype) {
        return NULL;
    }
    ast_consume(parser);
    ASTNode *node = create_ast_node(parser, atype);
    node->data.unary_stmt.target = parse_expression(parser, error_code);
    if (node->data.unary_stmt.target == NULL) {
        my_free(parser->pool, node);
        report_parse_error(error_code,
                           "Expected expression after unary operator");
        return NULL;
    }
    return node;
}

ASTNode *parse_delete(ASTParser *parser, ParseErrorCode *error_code) {
    return parse_unary_statement(parser, TOK_DEL, AST_DEL, error_code);
}

ASTNode *parse_return(ASTParser *parser, ParseErrorCode *error_code) {
    return parse_unary_statement(parser, TOK_RETURN, AST_RETURN, error_code);
}

ASTNode *parse_break(ASTParser *parser, ParseErrorCode *error_code) {
    if (is_end(parser)) {
        return NULL;
    }
    if (ast_peek(parser).type == TOK_BREAK) {
        ast_consume(parser);
        return create_ast_node(parser, AST_BREAK);
    }
    return NULL;
}

ASTNode *parse_statement(ASTParser *parser, ParseErrorCode *error_code) {
    if (is_end(parser)) {
        return NULL;
    }
    parse_and_return(parse_if_statement, if_stmt);
    parse_and_return(parse_for_loop, for_loop);
    parse_and_return(parse_while, while_stmt);
    parse_and_return(parse_function_definition, function_def_stmt);
    parse_and_return(parse_delete, delete_stmt);
    parse_and_return(parse_return, return_stmt);
    parse_and_return(parse_break, break_stmt);
    parse_and_return(parse_assign, assign_stmt);

    return parse_expression(parser, error_code);
}

ASTNode *parse(ASTParser *parser) {
    ParseErrorCode error_code = PARSE_SUCCESS;
    linked_list *statements = linked_list_create(parser->pool);
    ASTNode *stmt;
    parser->current_indentation = 0;
    while ((stmt = parse_statement(parser, &error_code)) != NULL) {
        if (parser->current_indentation != 0) {
            report_parse_error(&error_code, "Unexpected indentation");
            linked_list_free(statements);
            return NULL;
        }
        if (error_code != PARSE_SUCCESS) {
            linked_list_free(statements);
            return NULL;
        }
        linked_list_push(statements, stmt);
        ast_skip_indentation(parser);
    }
    ASTNode *node = create_ast_node(parser, AST_SUBPROGRAM);
    node->data.subprogram.statements = statements;
    return node;
}
