#include "allocator.h"
#include "ast.h"
#include "c_functions.h"
#include "compiler.h"
#include "interpreter.h"
#include "lexer.h"
#include "lib.h"
#include "string.h"
#include "syscall.h"

#define HEAP_START 0x10040000
#define HEAP_END 0x30000000

void populate_c_functions(hash_table *ht) {
    hash_table_insert_string(ht, const_string_view("add_binop"), &add_binop);
    hash_table_insert_string(ht, const_string_view("sub_binop"), &sub_binop);
    hash_table_insert_string(ht, const_string_view("mul_binop"), &mul_binop);
    hash_table_insert_string(ht, const_string_view("div_binop"), &div_binop);
}

int main() {
    MemoryPool pool;
    pool.start = (void *)HEAP_START;
    pool.end = (void *)HEAP_END;

    const char *program = "4 if 0 else 5 + 3";

    Lexer lexer;
    lexer.pool = &pool;
    lexer.source = program;
    lexer.sourceLength = my_strlen(program);
    lexer.current = 0;
    lexer.line = 1;
    lexer.column = 0;
    lexer.indentation = 4;
    lexer.indenting = false;

    Token *tokens = my_alloc(&pool, sizeof(Token *) * 500);
    Token token;
    int i = 0;
    my_printf("started lexing\n");
    while ((token = next_token(&lexer)).type != TOK_END &&
           token.type != TOK_INVALID) {
        tokens[i++] = token;
    }
    my_printf("ended lexing\n");
    if (token.type == TOK_INVALID) {
        my_printf("Invalid token at line %d, column %d\n", token.line,
                  lexer.column);
        Exit();
    }
    ASTParser parser;
    parser.current = 0;
    parser.pool = &pool;
    parser.size = i;
    parser.tokens = tokens;
    parser.current_indentation = 0;
    my_printf("started parsing ast\n");
    ASTNode *result = parse(&parser);
    my_printf("ended parsing ast\n");
    if (result == NULL) {
        my_printf("Error parsing\n");
        Exit();
    }
    my_printf("started compiling\n");
    Compiler *compiler = my_alloc(&pool, sizeof(Compiler));
    compiler->pool = &pool;
    compiler->root = result;
    compiler->compilation_units = linked_list_create(&pool);
    linked_list *compilation_result = compile(compiler);
    my_printf("compiled size: %d\n", compilation_result->size);
    if (compilation_result == NULL) {
        my_printf("Error compiling\n");
        Exit();
    }
    my_printf("ended compiling\n");
    Env *env = my_alloc(&pool, sizeof(Env));
    env->context = hash_table_create(&pool);
    env->parent = NULL;
    Interpreter *interpreter = my_alloc(&pool, sizeof(Interpreter));
    interpreter->pool = &pool;
    interpreter->compilation_units = compilation_result;
    interpreter->env = env;
    interpreter->stack = stack_create(&pool);
    interpreter->c_functions = hash_table_create(&pool);
    populate_c_functions(interpreter->c_functions);
    interpret(interpreter);
    Exit();
}
