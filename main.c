#include "allocator.h"
#include "ast.h"
#include "c_functions.h"
#include "compiler.h"
#include "file.h"
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
    hash_table_insert_string(ht, const_string_view("lt_binop"), &lt_binop);
    hash_table_insert_string(ht, const_string_view("leq_binop"), &leq_binop);
    hash_table_insert_string(ht, const_string_view("gt_binop"), &gt_binop);
    hash_table_insert_string(ht, const_string_view("geq_binop"), &geq_binop);
    hash_table_insert_string(ht, const_string_view("eq_binop"), &eq_binop);
    hash_table_insert_string(ht, const_string_view("neq_binop"), &neq_binop);
}

int main(int argc, char** argv) {
    if (argc < 1) {
        my_printf("Usage: ... main.s pa <filename>\n");
        Exit();
    }
    char* filename = argv[0];
    my_printf("file: %s\n", filename);
    MemoryPool pool;
    pool.start = (void *)HEAP_START;
    pool.end = (void *)HEAP_END;
    String *program = read_whole_file(&pool, filename);
    Lexer lexer;
    lexer.pool = &pool;
    lexer.source = program->data;
    lexer.sourceLength = program->length;
    lexer.current = 0;
    lexer.line = 1;
    lexer.column = 0;
    lexer.indentation = 4;
    lexer.indenting = false;

    Token *tokens = my_alloc(&pool, sizeof(Token *) * 1000);
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
    CompilationUnit *compilation_result = compile(compiler);
    if (compilation_result == NULL) {
        my_printf("Error compiling\n");
        Exit();
    }
    my_printf("ended compiling\n");
    my_printf("compiled instructions:\n");
    linked_list_node *current_node = compilation_result->instructions->head;
    while (current_node != NULL) {
        my_printf("\t Instruction: %d\n",
                  ((Instruction *)current_node->item)->type);
        current_node = current_node->next;
    }
    Env *env = my_alloc(&pool, sizeof(Env));
    env->context = hash_table_create(&pool);
    env->parent = NULL;
    env->pool = &pool;
    Interpreter *interpreter = my_alloc(&pool, sizeof(Interpreter));
    interpreter->program = compilation_result;
    interpreter->pool = &pool;
    interpreter->env = env;
    interpreter->stack = stack_create(&pool);
    interpreter->c_functions = hash_table_create(&pool);
    populate_c_functions(interpreter->c_functions);
    my_printf("started interpreting\n");
    interpret(interpreter);
    my_printf("ended interpreting\n");
    PyObject *interpretation_result = interpreter->stack->head->item;
    if (interpretation_result->object_type == OBJ_T_VALUE) {
        if (interpretation_result->data.value.type == PY_INT) {
            my_printf("Interpretation result: %d\n",
                      interpretation_result->data.value.data.int_value);
        } else if (interpretation_result->data.value.type == PY_FLOAT) {
            my_printf("Interpretation result: %f\n",
                      interpretation_result->data.value.data.float_value);
        } else {
            my_printf("Unsupported type: %d\n",
                      interpretation_result->data.value.type);
        }
    } else {
        my_printf("Unsupported type\n");
    }
    Exit();
}
