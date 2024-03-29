#include "stdarg.h"
#include "allocator.h"
#include <stddef.h>

#ifndef LIB_H
#define LIB_H

typedef struct
{
    const char *str;
    size_t len;
} string_view_t;

typedef struct
{
    void *item;
    struct linked_list_node *next;
} linked_list_node;

typedef struct linked_list
{
    linked_list_node *head;
    MemoryPool *pool;
} linked_list;

linked_list *linked_list_create(MemoryPool *pool);
void linked_list_push(linked_list *list, void *item);
void linked_list_free(linked_list *list);
linked_list_node *linked_list_at(linked_list *list, size_t item);

string_view_t string_view(const char *source, size_t len);
string_view_t c_string_view(const char *c_str);
string_view_t const_string_view(const char *comptime_c_str);

void my_printf(const char *fmt, ...);
void my_sprintf(char *buf, const char *fmt, ...);
void my_vsprintf(char *buf, const char *format, va_list args);
void my_itoa(int n, char s[]);

#endif // LIB_H
