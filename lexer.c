#include "lexer.h"
#include "allocator.h"
#include "string.h"
#include "lib.h"

char *create_substring(char *source, int start, int end, MemoryPool *pool)
{
    int n = end - start;
    char *new_str = (char *)my_alloc(pool, sizeof(char) * (n + 1));

    for (int i = 0; i < n; i++)
        new_str[i] = source[start + i];

    new_str[n] = '\0';
    return new_str;
}

char tok_peek(Lexer *lexer)
{
    if (lexer->current < lexer->sourceLength)
    {
        return lexer->source[lexer->current];
    }
    return '\0';
}

void tok_consume(Lexer *lexer)
{
    if (tok_peek(lexer) == '\n')
    {
        lexer->line++;
        lexer->column = -1;
    }
    lexer->column++;
    lexer->current++;
}

bool is_eof(Lexer *lexer)
{
    return lexer->current >= lexer->sourceLength;
}

Token make_token(Lexer *lexer, TokenType type, const char *lexeme, int literal, size_t size)
{
    Token token;
    token.type = type;
    token.lexeme = lexeme;
    token.literal = literal;
    token.line = lexer->line;
    token.size = size;
    return token;
}

Token make_error_token(Lexer *lexer, char *message)
{
    Token token;
    token.type = TOK_INVALID;
    token.lexeme = message;
    token.literal = 0;
    token.line = lexer->line;
    return token;
}

Token try_tokenize_indentation(Lexer *lexer)
{
    int start = lexer->current;
    int spaces = 0;
    while (!is_eof(lexer) && tok_peek(lexer) == ' ')
    {
        spaces++;
        tok_consume(lexer);
        if (spaces == lexer->indentation)
        {
            return make_token(lexer, TOK_INDENT, lexer->source + start, lexer->line, spaces);
        }
    }
    return make_error_token(lexer, "Invalid indentation");
}

void skip_whitespace(Lexer *lexer)
{
    while (!is_eof(lexer) && (tok_peek(lexer) == ' '))
    {
        tok_consume(lexer);
    }
}

void skip_comment(Lexer *lexer)
{
    if (tok_peek(lexer) == '#')
    {
        while (!is_eof(lexer) && tok_peek(lexer) != '\n')
        {
            tok_consume(lexer);
        }
        if (is_eof(lexer))
        {
            return;
        }
        tok_consume(lexer);
    }
}

bool can_continue_name_c(char peeked)
{
    return ('0' <= peeked && peeked <= '9') || ('a' <= peeked && peeked <= 'z') || ('A' <= peeked && peeked <= 'Z') || peeked == '_';
}

bool can_continue_name(Lexer *lexer)
{
    if (is_eof(lexer))
        return false;

    char peeked = tok_peek(lexer);
    return can_continue_name_c(peeked);
}

int matched_at_least(Lexer *lexer, const char *pattern)
{

    int i = 0;
    while (!is_eof(lexer) && lexer->source[lexer->current + i] != '\0' && pattern[i] != '\0')
    {
        if (lexer->source[lexer->current + i] != pattern[i])
        {

            return i;
        }
        i++;
    }

    if (pattern[i] == '\0' && !lexer->source[lexer->current + i] != '\0' && can_continue_name_c(lexer->source[lexer->current + i]))
    {

        return i + 1;
    }

    return i;
}

Token tokenize_name(Lexer *lexer)
{

    Token name;
    name.lexeme = lexer->source + lexer->current;
    name.line = lexer->line;
    name.type = TOK_IDENT;
    name.literal = 0;
    while (can_continue_name(lexer))
    {
        tok_consume(lexer);
    }
    name.size = lexer->source + lexer->current - name.lexeme;
    return name;
}

bool is_digit(Lexer *lexer)
{
    if (is_eof(lexer))
        return false;
    return '0' <= tok_peek(lexer) && tok_peek(lexer) <= '9';
}

Token tokenize_number(Lexer *lexer)
{
    Token number;
    number.lexeme = lexer->source + lexer->current;
    number.line = lexer->line;
    number.literal = 0;
    while (is_digit(lexer))
    {
        tok_consume(lexer);
    }
    if (is_eof(lexer) || tok_peek(lexer) != '.')
    {
        number.type = TOK_INT;
        number.size = lexer->source + lexer->current - number.lexeme;
        return number;
    }
    tok_consume(lexer);
    while (is_digit(lexer))
    {
        tok_consume(lexer);
    }
    number.type = TOK_FLOAT;
    number.size = lexer->source + lexer->current - number.lexeme;
    return number;
}

bool is_mathing_exact(Lexer *lexer, const char *pattern)
{
    int i = 0;
    while (!is_eof(lexer) && lexer->source[lexer->current + i] != '\0' && pattern[i] != '\0')
    {
        if (lexer->source[lexer->current + i] != pattern[i])
        {
            return false;
        }
        i++;
    }
    if (pattern[i] == '\0')
    {
        return true;
    }
    return false;
}

Token try_tokenize_string(Lexer *lexer, char quote_type)
{
    Token string;
    string.lexeme = lexer->source + lexer->current;
    string.line = lexer->line;
    string.type = TOK_STRING;
    string.literal = 0;
    tok_consume(lexer);
    while (!is_eof(lexer) && tok_peek(lexer) != quote_type)
    {
        tok_consume(lexer);
    }
    if (is_eof(lexer))
    {
        return make_error_token(lexer, "Unterminated string");
    }
    tok_consume(lexer);
    string.size = lexer->source - string.lexeme;
    return string;
}

Token try_tokenize_special(Lexer *lexer)
{
    if (tok_peek(lexer) == '"')
    {
        return try_tokenize_string(lexer, '"');
    }
    if (tok_peek(lexer) == '\'')
    {
        return try_tokenize_string(lexer, '\'');
    }
    if (tok_peek(lexer) == '(')
    {
        tok_consume(lexer);
        return make_token(lexer, TOK_LPAR, lexer->source + lexer->current - 1, 0, 1);
    }
    if (tok_peek(lexer) == ')')
    {
        tok_consume(lexer);
        return make_token(lexer, TOK_RPAR, lexer->source + lexer->current - 1, 0, 1);
    }
    if (tok_peek(lexer) == '[')
    {
        tok_consume(lexer);
        return make_token(lexer, TOK_LBRACKET, lexer->source + lexer->current - 1, 0, 1);
    }
    if (tok_peek(lexer) == ']')
    {
        tok_consume(lexer);
        return make_token(lexer, TOK_RBRACKET, lexer->source + lexer->current - 1, 0, 1);
    }
    if (tok_peek(lexer) == '{')
    {
        tok_consume(lexer);
        return make_token(lexer, TOK_LCURLY, lexer->source + lexer->current - 1, 0, 1);
    }
    if (tok_peek(lexer) == '}')
    {
        tok_consume(lexer);
        return make_token(lexer, TOK_RCURLY, lexer->source + lexer->current - 1, 0, 1);
    }
    if (tok_peek(lexer) == ',')
    {
        tok_consume(lexer);
        return make_token(lexer, TOK_COMMA, lexer->source + lexer->current - 1, 0, 1);
    }
    if (tok_peek(lexer) == ':')
    {
        tok_consume(lexer);
        return make_token(lexer, TOK_CLR, lexer->source + lexer->current - 1, 0, 1);
    }
    if (tok_peek(lexer) == '#')
    {
        skip_comment(lexer);
        return next_token(lexer);
    }
    return make_error_token(lexer, "Unexpected character");
}

Token try_tokenize_operator(Lexer *lexer)
{
    if (is_mathing_exact(lexer, "<="))
    {
        tok_consume(lexer);
        tok_consume(lexer);
        return make_token(lexer, TOK_LT, lexer->source + lexer->current - 2, 0, 2);
    }
    if (is_mathing_exact(lexer, "<"))
    {
        tok_consume(lexer);
        return make_token(lexer, TOK_LT, lexer->source + lexer->current - 1, 0, 1);
    }
    if (is_mathing_exact(lexer, "=="))
    {
        tok_consume(lexer);
        tok_consume(lexer);
        return make_token(lexer, TOK_EQ, lexer->source + lexer->current - 2, 0, 2);
    }
    if (is_mathing_exact(lexer, "="))
    {
        tok_consume(lexer);
        return make_token(lexer, TOK_ASSIGN, lexer->source + lexer->current - 1, 0, 1);
    }
    if (is_mathing_exact(lexer, ">="))
    {
        tok_consume(lexer);
        tok_consume(lexer);
        return make_token(lexer, TOK_GT, lexer->source + lexer->current - 2, 0, 2);
    }
    if (is_mathing_exact(lexer, ">"))
    {
        tok_consume(lexer);
        return make_token(lexer, TOK_GT, lexer->source + lexer->current - 1, 0, 1);
    }
    if (is_mathing_exact(lexer, "!="))
    {
        tok_consume(lexer);
        tok_consume(lexer);
        return make_token(lexer, TOK_NEQ, lexer->source + lexer->current - 2, 0, 2);
    }
    if (is_mathing_exact(lexer, "+="))
    {
        tok_consume(lexer);
        tok_consume(lexer);
        return make_token(lexer, TOK_AUGPLUS, lexer->source + lexer->current - 2, 0, 2);
    }
    if (is_mathing_exact(lexer, "-="))
    {
        tok_consume(lexer);
        tok_consume(lexer);
        return make_token(lexer, TOK_AUGMINUS, lexer->source + lexer->current - 2, 0, 2);
    }
    if (is_mathing_exact(lexer, "*="))
    {
        tok_consume(lexer);
        tok_consume(lexer);
        return make_token(lexer, TOK_AUGMUL, lexer->source + lexer->current - 2, 0, 2);
    }
    if (is_mathing_exact(lexer, "/="))
    {
        tok_consume(lexer);
        tok_consume(lexer);
        return make_token(lexer, TOK_AUGDIV, lexer->source + lexer->current - 2, 0, 2);
    }
    if (is_mathing_exact(lexer, "%="))
    {
        tok_consume(lexer);
        tok_consume(lexer);
        return make_token(lexer, TOK_AUGMOD, lexer->source + lexer->current - 2, 0, 2);
    }
    if (is_mathing_exact(lexer, "//="))
    {
        tok_consume(lexer);
        tok_consume(lexer);
        tok_consume(lexer);
        return make_token(lexer, TOK_AUGFLOORDIV, lexer->source + lexer->current - 3, 0, 3);
    }
    if (is_mathing_exact(lexer, "**="))
    {
        tok_consume(lexer);
        tok_consume(lexer);
        tok_consume(lexer);
        return make_token(lexer, TOK_AUGPOW, lexer->source + lexer->current - 3, 0, 3);
    }
    if (is_mathing_exact(lexer, "+"))
    {
        tok_consume(lexer);
        return make_token(lexer, TOK_PLUS, lexer->source + lexer->current - 1, 0, 1);
    }
    if (is_mathing_exact(lexer, "-"))
    {
        tok_consume(lexer);
        return make_token(lexer, TOK_MINUS, lexer->source + lexer->current - 1, 0, 1);
    }
    if (is_mathing_exact(lexer, "//"))
    {
        tok_consume(lexer);
        tok_consume(lexer);
        return make_token(lexer, TOK_FLOORDIV, lexer->source + lexer->current - 2, 0, 1);
    }
    if (is_mathing_exact(lexer, "/"))
    {
        tok_consume(lexer);
        return make_token(lexer, TOK_DIV, lexer->source + lexer->current - 1, 0, 1);
    }
    if (is_mathing_exact(lexer, "**"))
    {
        tok_consume(lexer);
        tok_consume(lexer);
        return make_token(lexer, TOK_POW, lexer->source + lexer->current - 2, 0, 1);
    }
    if (is_mathing_exact(lexer, "*"))
    {
        tok_consume(lexer);
        return make_token(lexer, TOK_MUL, lexer->source + lexer->current - 1, 0, 1);
    }
    if (is_mathing_exact(lexer, "%"))
    {
        tok_consume(lexer);
        return make_token(lexer, TOK_MOD, lexer->source + lexer->current - 1, 0, 1);
    }
    return try_tokenize_special(lexer);
}

Token try_tokenize_keyword_tree(Lexer *lexer)
{
    // Alphabet order of word start, reverse alphabet (and length) order of prefixes
    // A.

    int matched = matched_at_least(lexer, "assert");
    if (matched == 6)
    {
        for (int i = 0; i < 6; ++i)
            tok_consume(lexer);
        return make_token(lexer, TOK_ASSERT, lexer->source + lexer->current - 6, 0, 6);
    }
    else if (matched == 2)
    {
        matched = matched_at_least(lexer, "as");
        if (matched == 2)
        {
            for (int i = 0; i < 2; ++i)
                tok_consume(lexer);
            return make_token(lexer, TOK_AS, lexer->source + lexer->current - 2, 0, 2);
        }
        return tokenize_name(lexer);
    }
    else if (matched == 1)
    {
        matched = matched_at_least(lexer, "and");
        if (matched == 3)
        {
            for (int i = 0; i < 3; ++i)
                tok_consume(lexer);
            return make_token(lexer, TOK_AND, lexer->source + lexer->current - 3, 0, 3);
        }
        return tokenize_name(lexer);
    }
    else if (matched != 0)
    {
        return tokenize_name(lexer);
    }
    // B.
    matched = matched_at_least(lexer, "break");
    if (matched == 5)
    {
        for (int i = 0; i < 5; ++i)
            tok_consume(lexer);
        return make_token(lexer, TOK_BREAK, lexer->source + lexer->current - 5, 0, 5);
    }
    else if (matched != 0)
    {
        return tokenize_name(lexer);
    }
    // C.
    matched = matched_at_least(lexer, "continue");
    if (matched == 8)
    {
        for (int i = 0; i < 8; ++i)
            tok_consume(lexer);
        return make_token(lexer, TOK_CONTINUE, lexer->source + lexer->current - 8, 0, 8);
    }
    else if (matched != 0)
    {
        return tokenize_name(lexer);
    }
    // D.
    matched = matched_at_least(lexer, "def");
    if (matched == 3)
    {
        for (int i = 0; i < 3; ++i)
            tok_consume(lexer);
        return make_token(lexer, TOK_DEF, lexer->source + lexer->current - 3, 0, 3);
    }
    else if (matched == 2)
    {
        matched = matched_at_least(lexer, "del");
        if (matched == 3)
        {
            for (int i = 0; i < 3; ++i)
                tok_consume(lexer);
            return make_token(lexer, TOK_DEL, lexer->source + lexer->current - 3, 0, 3);
        }
        return tokenize_name(lexer);
    }
    else if (matched != 0)
    {
        return tokenize_name(lexer);
    }
    // e.
    matched = matched_at_least(lexer, "else");
    if (matched == 4)
    {
        for (int i = 0; i < 4; ++i)
            tok_consume(lexer);
        return make_token(lexer, TOK_ELSE, lexer->source + lexer->current - 4, 0, 4);
    }
    else if (matched == 2)
    {
        matched = matched_at_least(lexer, "elif");
        if (matched == 4)
        {
            for (int i = 0; i < 4; ++i)
                tok_consume(lexer);
            return make_token(lexer, TOK_ELIF, lexer->source + lexer->current - 4, 0, 4);
        }
        return tokenize_name(lexer);
    }
    else if (matched == 1)
    {
        matched = matched_at_least(lexer, "except");
        if (matched == 6)
        {
            for (int i = 0; i < 6; ++i)
                tok_consume(lexer);
            return make_token(lexer, TOK_EXCEPT, lexer->source + lexer->current - 6, 0, 6);
        }
        return tokenize_name(lexer);
    }
    else if (matched != 0)
    {
        return tokenize_name(lexer);
    }
    // f.
    matched = matched_at_least(lexer, "finally");
    if (matched == 7)
    {
        for (int i = 0; i < 7; ++i)
            tok_consume(lexer);
        return make_token(lexer, TOK_FINALLY, lexer->source + lexer->current - 7, 0, 7);
    }
    else if (matched == 1)
    {
        matched = matched_at_least(lexer, "for");
        if (matched == 3)
        {

            for (int i = 0; i < 3; ++i)
                tok_consume(lexer);
            return make_token(lexer, TOK_FOR, lexer->source + lexer->current - 3, 0, 3);
        }
        if (matched != 1)
        {
            return tokenize_name(lexer);
        }
        matched = matched_at_least(lexer, "from");
        if (matched == 4)
        {
            for (int i = 0; i < 4; ++i)
                tok_consume(lexer);
            return make_token(lexer, TOK_FROM, lexer->source + lexer->current - 4, 0, 4);
        }
        return tokenize_name(lexer);
    }
    else if (matched != 0)
    {
        return tokenize_name(lexer);
    }
    // g.
    matched = matched_at_least(lexer, "global");
    if (matched == 6)
    {
        for (int i = 0; i < 6; ++i)
            tok_consume(lexer);
        return make_token(lexer, TOK_GLOBAL, lexer->source + lexer->current - 6, 0, 6);
    }
    else if (matched != 0)
    {
        return tokenize_name(lexer);
    }
    // i.
    matched = matched_at_least(lexer, "import");
    if (matched == 6)
    {
        for (int i = 0; i < 6; ++i)
            tok_consume(lexer);
        return make_token(lexer, TOK_IMPORT, lexer->source + lexer->current - 6, 0, 6);
    }
    else if (matched == 1)
    {
        matched = matched_at_least(lexer, "if");
        if (matched == 2)
        {
            for (int i = 0; i < 2; ++i)
                tok_consume(lexer);
            return make_token(lexer, TOK_IF, lexer->source + lexer->current - 2, 0, 2);
        }
        if (matched != 1)
        {
            return tokenize_name(lexer);
        }
        matched = matched_at_least(lexer, "in");
        if (matched == 2)
        {
            for (int i = 0; i < 2; ++i)
                tok_consume(lexer);
            return make_token(lexer, TOK_IN, lexer->source + lexer->current - 2, 0, 2);
        }
        if (matched != 1)
        {
            return tokenize_name(lexer);
        }
        matched = matched_at_least(lexer, "is");
        if (matched == 2)
        {
            for (int i = 0; i < 2; ++i)
                tok_consume(lexer);
            return make_token(lexer, TOK_IS, lexer->source + lexer->current - 2, 0, 2);
        }
        return tokenize_name(lexer);
    }
    else if (matched != 0)
    {
        return tokenize_name(lexer);
    }
    // l.
    matched = matched_at_least(lexer, "lambda");
    if (matched == 6)
    {
        for (int i = 0; i < 6; ++i)
            tok_consume(lexer);
        return make_token(lexer, TOK_LAMBDA, lexer->source + lexer->current - 6, 0, 6);
    }
    else if (matched != 0)
    {
        return tokenize_name(lexer);
    }
    // n.
    matched = matched_at_least(lexer, "not");
    if (matched == 3)
    {
        for (int i = 0; i < 3; ++i)
            tok_consume(lexer);
        return make_token(lexer, TOK_NOT, lexer->source + lexer->current - 3, 0, 3);
    }
    else if (matched != 0)
    {
        return tokenize_name(lexer);
    }
    // o.
    matched = matched_at_least(lexer, "or");
    if (matched == 2)
    {
        for (int i = 0; i < 2; ++i)
            tok_consume(lexer);
        return make_token(lexer, TOK_OR, lexer->source + lexer->current - 2, 0, 2);
    }
    else if (matched != 0)
    {
        return tokenize_name(lexer);
    }
    // p.
    matched = matched_at_least(lexer, "pass");
    if (matched == 4)
    {
        for (int i = 0; i < 4; ++i)
            tok_consume(lexer);
        return make_token(lexer, TOK_PASS, lexer->source + lexer->current - 4, 0, 4);
    }
    else if (matched != 0)
    {
        return tokenize_name(lexer);
    }
    // r.
    matched = matched_at_least(lexer, "return");
    if (matched == 6)
    {
        for (int i = 0; i < 6; ++i)
            tok_consume(lexer);
        return make_token(lexer, TOK_RETURN, lexer->source + lexer->current - 6, 0, 6);
    }
    else if (matched == 1)
    {
        matched = matched_at_least(lexer, "raise");
        if (matched == 5)
        {
            for (int i = 0; i < 5; ++i)
                tok_consume(lexer);
            return make_token(lexer, TOK_RAISE, lexer->source + lexer->current - 5, 0, 5);
        }
        return tokenize_name(lexer);
    }
    else if (matched != 0)
    {
        return tokenize_name(lexer);
    }
    // t.
    matched = matched_at_least(lexer, "try");
    if (matched == 3)
    {
        for (int i = 0; i < 3; ++i)
            tok_consume(lexer);
        return make_token(lexer, TOK_TRY, lexer->source + lexer->current - 3, 0, 3);
    }
    else if (matched != 0)
    {
        return tokenize_name(lexer);
    }
    // w.
    matched = matched_at_least(lexer, "while");
    if (matched == 5)
    {
        for (int i = 0; i < 5; ++i)
            tok_consume(lexer);
        return make_token(lexer, TOK_WHILE, lexer->source + lexer->current - 5, 0, 5);
    }
    else if (matched == 1)
    {
        matched = matched_at_least(lexer, "with");
        if (matched == 4)
        {
            for (int i = 0; i < 4; ++i)
                tok_consume(lexer);
            return make_token(lexer, TOK_WITH, lexer->source + lexer->current - 4, 0, 4);
        }
        return tokenize_name(lexer);
    }
    else if (matched != 0)
    {
        return tokenize_name(lexer);
    }
    // y.
    matched = matched_at_least(lexer, "yield");
    if (matched == 5)
    {
        for (int i = 0; i < 5; ++i)
            tok_consume(lexer);
        return make_token(lexer, TOK_YIELD, lexer->source + lexer->current - 5, 0, 5);
    }
    else if (matched != 0)
    {
        return tokenize_name(lexer);
    }
    // T.
    matched = matched_at_least(lexer, "True");
    if (matched == 4)
    {
        for (int i = 0; i < 4; ++i)
            tok_consume(lexer);
        return make_token(lexer, TOK_TRUE, lexer->source + lexer->current - 4, 0, 4);
    }
    else if (matched != 0)
    {
        return tokenize_name(lexer);
    }
    // F.
    matched = matched_at_least(lexer, "False");
    if (matched == 5)
    {
        for (int i = 0; i < 5; ++i)
            tok_consume(lexer);
        return make_token(lexer, TOK_FALSE, lexer->source + lexer->current - 5, 0, 5);
    }
    else if (matched != 0)
    {
        return tokenize_name(lexer);
    }
    if (is_digit(lexer))
    {
        return tokenize_number(lexer);
    }
    if (can_continue_name(lexer))
    {
        return tokenize_name(lexer);
    }
    return try_tokenize_operator(lexer);
}

Token next_token(Lexer *lexer)
{
    if (lexer->column == 0 || lexer->indenting)
    {
        int spaces = 0;
        while (!is_eof(lexer) && tok_peek(lexer) == ' ')
        {
            tok_consume(lexer);
            spaces++;
            if (spaces == lexer->indentation)
            {
                lexer->indenting = !is_eof(lexer) && tok_peek(lexer) == ' ';
                return make_token(lexer, TOK_INDENT, lexer->source + lexer->current - spaces, 0, spaces);
            }
        }
        if (spaces != 0)
        {
            return make_error_token(lexer, "Unexpected indent");
        }
    }
    skip_whitespace(lexer);
    if (is_eof(lexer))
    {
        return make_token(lexer, TOK_END, lexer->source, 0, 0);
    }
    if (tok_peek(lexer) == '\n')
    {
        tok_consume(lexer);
        return make_token(lexer, TOK_NEWLINE, lexer->source + lexer->current - 1, 0, 1);
    }
    return try_tokenize_keyword_tree(lexer);
}
