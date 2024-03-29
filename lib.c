#include "lib.h"
#include "syscall.h"
#include "string.h"
#include "lib.h"
#include "allocator.h"

linked_list *linked_list_create(MemoryPool *pool)
{
    linked_list *list = my_alloc(pool, sizeof(linked_list));
    list->head = NULL;
    list->pool = pool;
}

void linked_list_push(linked_list *list, void *item)
{
    if (list->head == NULL)
    {
        list->head = my_alloc(list->pool, sizeof(linked_list_node));
        list->head->item = item;
        list->head->next = NULL;
    }
    else
    {
        linked_list_node *current = list->head;
        while (current->next != NULL)
        {
            current = current->next;
        }
        linked_list_node *node = my_alloc(list->pool, sizeof(linked_list_node));
        node->item = item;
        node->next = NULL;
        current->next = node;
    }
}

void free_list_node(MemoryPool *pool, linked_list_node *node)
{
    if (node == NULL)
    {
        return;
    }
    free_list_node(pool, node->next);
    my_free(pool, node);
    node->next = NULL;
    node->item = NULL;
}

void linked_list_free(linked_list *list)
{
    free_list_node(list->pool, list->head);
}

linked_list_node *linked_list_at(linked_list *list, size_t item)
{
    linked_list_node *node = list->head;
    if (node == NULL)
    {
        return NULL;
    }
    while (item--)
    {
        if (node->next)
            node = node->next;
        else
            return NULL;
    }
    return node;
}

string_view_t string_view(const char *str, size_t len)
{
    return (string_view_t){.str = str, .len = len};
}

string_view_t c_string_view(const char *c_str)
{
    return (string_view_t){.str = c_str, .len = my_strlen(c_str)};
}

string_view_t const_string_view(const char *comptime_c_str)
{
    return (string_view_t){.str = comptime_c_str, .len = my_strlen(comptime_c_str)};
}

void reverse(char s[])
{
    int i, j;
    char c;

    for (i = 0, j = my_strlen(s) - 1; i < j; i++, j--)
    {
        c = s[i];
        s[i] = s[j];
        s[j] = c;
    }
}

void my_itoa(int n, char s[])
{
    int i, sign;

    if ((sign = n) < 0)
        n = -n;
    i = 0;
    do
    {
        s[i++] = n % 10 + '0';
    } while ((n /= 10) > 0);
    if (sign < 0)
        s[i++] = '-';
    s[i] = '\0';
    reverse(s);
}

void my_vsprintf(char *buf, const char *format, va_list args)
{
    for (int i = 0; format[i] != '\0'; i++)
    {
        if (format[i] != '%')
        {
            *buf++ = format[i];
            continue;
        }

        i++;
        switch (format[i])
        {
        case 'd':
        {
            int num = va_arg(args, int);
            char str[15];
            my_itoa(num, str);
            my_strcpy(buf, str);
            buf += my_strlen(str);
            break;
        }
        case 's':
        {
            char *str = va_arg(args, char *);
            my_strcpy(buf, str);
            buf += my_strlen(str);
            break;
        }
            // Add more cases as per the need
        }
    }

    *buf = '\0';
}

void my_sprintf(char *buf, const char *format, ...)
{
    va_list args;
    va_start(args, format);
    my_vsprintf(buf, format, args);
    va_end(args);
}

void my_printf(const char *format, ...)
{
    char buf[256];
    va_list args;

    va_start(args, format);
    my_vsprintf(buf, format, args);
    printstr(buf);
    va_end(args);
}
