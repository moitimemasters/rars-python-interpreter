#ifndef ALLOCATOR_H
#define ALLOCATOR_H

#include <stdbool.h>
#include <stdlib.h>

typedef struct MemoryPool {
    void *start;
    void *end;
} MemoryPool;

typedef struct MBlock {
    size_t size;
    bool free;
    struct MBlock *next;
} MBlock;

MBlock *find_free_block(MemoryPool *pool, size_t size);
void *my_alloc(MemoryPool *pool, size_t size);
void *my_realloc(MemoryPool *pool, void *ptr, size_t size);
void my_free(MemoryPool *pool, void *ptr);

void my_memcpy(void *dst, const void *src, size_t size);

#endif
