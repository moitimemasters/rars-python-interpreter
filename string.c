#include "string.h"

#include "allocator.h"

int my_strlen(const char *str) {
    int length = 0;
    while (*str++) length++;
    return length;
}

void my_strcpy(char *dest, const char *src) {
    while (*src) {
        *dest = *src;
        dest++;
        src++;
    }
    *dest = '\0';
}

int my_strcmp(const char *s1, const char *s2) {
    while (*s1 && (*s1 == *s2)) {
        s1++;
        s2++;
    }
    return *(const unsigned char *)s1 - *(const unsigned char *)s2;
}

String *empty(MemoryPool *pool) {
    String *string = my_alloc(pool, sizeof(String));
    string->data = NULL;
    string->pool = pool;
    string->capacity = 0;
    string->length = 0;
}

String *from_c_str(MemoryPool *pool, char *str) {
    String *string = my_alloc(pool, sizeof(String));
    string->data = my_alloc(pool, my_strlen(str) + 1);
    string->length = my_strlen(str);
    string->pool = pool;
    string->capacity = string->length + 1;
    return string;
}

String *from_string_view(MemoryPool *pool, string_view_t str) {
    String *string = my_alloc(pool, sizeof(String));
    string->data = my_alloc(pool, str.len);
    my_memcpy(string->data, str.str, str.len);
    string->pool = pool;
    string->length = str.len;
    string->capacity = string->length + 1;
    return string;
}

void append_string_view(String *string, string_view_t sw) {
    if (string->length + sw.len >= string->capacity) {
        string->capacity = string->length + sw.len + 1;
        if (string->data == NULL) {
            string->data = my_alloc(string->pool, sw.len);
        } else if (string->data != NULL) {
            string->data =
                my_realloc(string->pool, string->data, string->capacity);
        }
    }
    my_memcpy(string->data + string->length, sw.str, sw.len);
    string->length += sw.len;
}

void string_destroy(String *string) {
    my_free(string->pool, string->data);
    string->data = NULL;
    string->capacity = 0;
    string->length = 0;
}
