#include "allocator.h"
#include "lib.h"
#include "weak_ptr.h"

#ifndef STRING_H
#define STRING_H

int my_strlen(const char *str);
void my_strcpy(char *dest, const char *src);
int my_strcmp(const char *s1, const char *s2);



typedef struct String {
    char *data;
    int length;
    int capacity;
    MemoryPool *pool;
} String;

String *empty(MemoryPool* pool);
String *from_c_str(MemoryPool *pool, char *str);
String *from_string_view(MemoryPool *pool, string_view_t str);
void append_string_view(String *srting, string_view_t sw);
void string_destroy(String *string);

#endif  // STRING_H
