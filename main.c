#include "allocator.h"
#include "lib.h"
#include "syscall.h"
#include "lexer.h"
#include "string.h"
#include "ast.h"

#define HEAP_START 0x10040000
#define HEAP_END 0x30000000

void print_token_lexeme(Token token)
{
	for (int i = 0; i < token.size; ++i)
	{
		printchar(token.lexeme[i]);
	}
}

int interpret_arithmetic(ASTNode *node)
{
	if (node->type == AST_BINARY_OP)
	{
		int left = interpret_arithmetic(node->data.binary_op.left);
		int right = interpret_arithmetic(node->data.binary_op.right);

		switch (node->data.binary_op.op)
		{
		case TOK_PLUS:
			return left + right;
		case TOK_MINUS:
			return left - right;
		case TOK_MUL:
			return left * right;
		case TOK_DIV:
			return left / right;
		}
	}
	else if (node->type == AST_INT)
	{
		return node->data.int_value;
	}
	return 0;
}

int main()
{
	MemoryPool pool;
	pool.start = (void *)HEAP_START;
	pool.end = (void *)HEAP_END;

	const char *program =
		"def foo(a, b, c):\n"
		"    if a > b:\n"
		"        return a + b";

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
	while ((token = next_token(&lexer)).type != TOK_END && token.type != TOK_INVALID)
	{
		tokens[i++] = token;
	}
	my_printf("ended lexing\n");
	if (token.type == TOK_INVALID)
	{
		my_printf("Invalid token at line %d, column %d\n", token.line, lexer.column);
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
	if (result == NULL)
	{
		my_printf("Error parsing\n");
		Exit();
	}
	// int value = interpret_arithmetic(result);
	// my_printf("Result: %d\n", value);
	Exit();
}
