#include "lib.h"

#include "allocator.h"
#include "lib.h"
#include "string.h"
#include "syscall.h"

void stack_pop(stack_t *stack) {
    stack_node *node = stack->head;
    if (stack->head == NULL) {
        return;
    }
    stack->size--;
    stack->head = node->previous;
}

void stack_push(stack_t *stack, void *item) {
    stack->size++;
    stack_node *node = my_alloc(stack->pool, sizeof(stack_node));
    node->item = item;
    node->previous = stack->head;
    stack->head = node;
}

void stack_free(stack_t *stack) {
    while (stack->head != NULL) {
        stack_pop(stack);
    }
}

stack_t *stack_create(MemoryPool *pool) {
    stack_t *stack = my_alloc(pool, sizeof(stack_t));
    stack->head = NULL;
    stack->pool = pool;
    stack->size = 0;
    return stack;
}

linked_list *linked_list_create(MemoryPool *pool) {
    linked_list *list = my_alloc(pool, sizeof(linked_list));
    list->head = NULL;
    list->pool = pool;
    list->size = 0;
}

void linked_list_push(linked_list *list, void *item) {
    list->size++;
    if (list->head == NULL) {
        list->head = my_alloc(list->pool, sizeof(linked_list_node));
        list->head->item = item;
        list->head->next = NULL;
        list->head->previous = NULL;
    } else {
        linked_list_node *current = list->head;
        while (current->next != NULL) {
            current = current->next;
        }
        linked_list_node *node = my_alloc(list->pool, sizeof(linked_list_node));
        node->item = item;
        node->next = NULL;
        node->previous = current;
        current->next = node;
    }
}

void free_list_node(MemoryPool *pool, linked_list_node *node) {
    if (node == NULL) {
        return;
    }
    free_list_node(pool, node->next);
    my_free(pool, node);
    node->next = NULL;
    node->item = NULL;
}

void linked_list_free(linked_list *list) {
    free_list_node(list->pool, list->head);
}

string_view_t string_view(const char *str, size_t len) {
    return (string_view_t){.str = str, .len = len};
}

string_view_t c_string_view(const char *c_str) {
    return (string_view_t){.str = c_str, .len = my_strlen(c_str)};
}

string_view_t const_string_view(const char *comptime_c_str) {
    return (string_view_t){.str = comptime_c_str,
                           .len = my_strlen(comptime_c_str)};
}

void reverse(char s[]) {
    int i, j;
    char c;

    for (i = 0, j = my_strlen(s) - 1; i < j; i++, j--) {
        c = s[i];
        s[i] = s[j];
        s[j] = c;
    }
}

void my_itoa(int n, char s[]) {
    int i, sign;

    if ((sign = n) < 0) n = -n;
    i = 0;
    do {
        s[i++] = n % 10 + '0';
    } while ((n /= 10) > 0);
    if (sign < 0) s[i++] = '-';
    s[i] = '\0';
    reverse(s);
}

void my_vsprintf(char *buf, const char *format, va_list args) {
    for (int i = 0; format[i] != '\0'; i++) {
        if (format[i] != '%') {
            *buf++ = format[i];
            continue;
        }

        i++;
        switch (format[i]) {
            case 'd': {
                int num = va_arg(args, int);
                char str[15];
                my_itoa(num, str);
                my_strcpy(buf, str);
                buf += my_strlen(str);
                break;
            }
            case 's': {
                char *str = va_arg(args, char *);
                my_strcpy(buf, str);
                buf += my_strlen(str);
                break;
            }
            case 'f': {
                double num = va_arg(args, double);
                int int_part = (int)num;
                double float_part = num - int_part;
                my_itoa(int_part, buf);
                buf += my_strlen(buf);
                *buf++ = '.';
                my_itoa((int)(float_part * 1000), buf);
                buf += my_strlen(buf);
                break;
            }
        }
    }

    *buf = '\0';
}

void my_sprintf(char *buf, const char *format, ...) {
    va_list args;
    va_start(args, format);
    my_vsprintf(buf, format, args);
    va_end(args);
}

void my_printf(const char *format, ...) {
    char buf[256];
    va_list args;

    va_start(args, format);
    my_vsprintf(buf, format, args);
    print_string(buf);
    va_end(args);
}

int strhash(string_view_t string) {
    int hash = 0;
    for (int i = 0; i < string.len; i++) {
        hash = 31 * hash + string.str[i];
    }
    return hash;
}

hash_table *hash_table_create(MemoryPool *pool) {
    hash_table *ht = my_alloc(pool, sizeof(hash_table));
    ht->pool = pool;
    ht->entries = linked_list_create(pool);
}
void hash_table_free(hash_table *table) { linked_list_free(table->entries); }

void hash_table_insert(hash_table *table, int key_hash, void *value) {
    hash_table_entry *entry = my_alloc(table->pool, sizeof(hash_table_entry));
    entry->key_hash = key_hash;
    entry->value = value;
    linked_list_push(table->entries, entry);
}

void hash_table_insert_string(hash_table *table, string_view_t string_key,
                              void *value) {
    hash_table_insert(table, strhash(string_key), value);
    return;
}

void *hash_table_get(hash_table *table, int key_hash) {
    linked_list_node *node = table->entries->head;
    while (node != NULL) {
        hash_table_entry *entry = node->item;
        if (entry->key_hash == key_hash) {
            return entry->value;
        }
        node = node->next;
    }
    return NULL;
}

void *linked_list_at(linked_list *list, size_t item) {
    linked_list_node *node = list->head;
    for (size_t i = 0; i < item; i++) {
        if (node == NULL) {
            return NULL;
        }
        node = node->next;
    }
    if (node == NULL) {
        return NULL;
    }
    return node->item;
}

void *hash_table_get_string(hash_table *table, string_view_t string_key) {
    return hash_table_get(table, strhash(string_key));
}

void *hash_table_upsert(hash_table *table, int key_hash, void *value) {
    linked_list_node *node = table->entries->head;
    while (node != NULL) {
        hash_table_entry *entry = node->item;
        if (entry->key_hash == key_hash) {
            void *old_value = entry->value;
            entry->value = value;
            return old_value;
        }
        node = node->next;
    }
    hash_table_insert(table, key_hash, value);
    return NULL;
}

void *hash_table_upsert_string(hash_table *table, string_view_t string_key,
                               void *value) {
    return hash_table_upsert(table, strhash(string_key), value);
}

void linked_list_reverse(linked_list *list) {
    linked_list_node *node = list->head;
    while (node != NULL) {
        linked_list_node *next = node->next;
        linked_list_node *previous = node->previous;
        node->next = previous;
        node->previous = next;
        if (next == NULL) {
            list->head = node;
        }
        node = next;
    }
}
