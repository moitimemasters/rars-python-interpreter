#include <stddef.h>

#include "allocator.h"
#include "stdarg.h"

#ifndef LIB_H
#define LIB_H

typedef struct {
    const char *str;
    size_t len;
} string_view_t;

typedef struct linked_list_node {
    void *item;
    struct linked_list_node *next, *previous;
} linked_list_node;

typedef struct {
    linked_list_node *head;
    MemoryPool *pool;
    size_t size;
} linked_list;

typedef struct stack_node {
    void *item;
    struct stack_node *previous;
} stack_node;

typedef struct stack_t {
    stack_node *head;
    MemoryPool *pool;
    size_t size;
} stack_t;

typedef struct hash_table_entry {
    int key_hash;
    void *value;
} hash_table_entry;

typedef struct hash_table {
    MemoryPool *pool;
    linked_list *entries;
} hash_table;

hash_table *hash_table_create(MemoryPool *pool);
void hash_table_free(hash_table *table);
void hash_table_insert(hash_table *table, int key_hash, void *value);
void hash_table_insert_string(hash_table *table, string_view_t string_key,
                              void *value);
void *hash_table_get(hash_table *table, int key_hash);
void *hash_table_get_string(hash_table *table, string_view_t string_key);
void *hash_table_upsert(hash_table *table, int key_hash, void* value);
void *hash_table_upsert_string(hash_table *table, string_view_t string_key, void* value);

void stack_pop(stack_t *stack);
void stack_push(stack_t *stack, void *item);
void stack_free(stack_t *stack);
stack_t *stack_create(MemoryPool *pool);

linked_list *linked_list_create(MemoryPool *pool);
void linked_list_push(linked_list *list, void *item);
void linked_list_free(linked_list *list);
void *linked_list_at(linked_list *list, size_t item);
void linked_list_reverse(linked_list *list);


string_view_t string_view(const char *source, size_t len);
string_view_t c_string_view(const char *c_str);
string_view_t const_string_view(const char *comptime_c_str);

void my_printf(const char *fmt, ...);
void my_sprintf(char *buf, const char *fmt, ...);
void my_vsprintf(char *buf, const char *format, va_list args);
void my_itoa(int n, char s[]);

int strhash(string_view_t string);

#endif  // LIB_H
