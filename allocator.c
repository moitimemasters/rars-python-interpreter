#include <stdbool.h>
#include <stdio.h>

#include "syscall.h"

typedef struct MemoryPool {
    void *start;
    void *end;
} MemoryPool;

typedef struct MBlock {
    size_t size;
    bool free;
    struct MBlock *next;
} MBlock;

#define OVERHEAD sizeof(MBlock)

MBlock *find_free_block(MemoryPool *pool, size_t size) {
    MBlock *curr = (MBlock *)pool->start;
    while (curr && !(curr->free && curr->size >= size)) {
        curr = curr->next;
    }
    return curr;
}

void my_free(MemoryPool *pool, void *ptr) {
    if (!ptr) return;
    MBlock *block = ptr - OVERHEAD;
    block->free = true;
}

void my_memcpy(void *dst, const void *src, size_t size) {
    for (size_t i = 0; i < size; i++) {
        ((char *)dst)[i] = ((char *)src)[i];
    }
}

void *my_alloc(MemoryPool *pool, size_t size) {
    size_t extra = size % 8;
    if (extra != 0) {
        size += 8 - extra;
    }

    MBlock *block;
    if ((block = find_free_block(pool, size)) == NULL) {
        if ((void *)((size_t *)pool->start + size + OVERHEAD) > pool->end)
            return NULL;
        block = (MBlock *)pool->start;
        block->size = size;
        block->free = false;
        block->next = NULL;
        pool->start = (void *)((size_t *)pool->start + size + OVERHEAD);
    } else {
        block->free = false;
    }
    return (block + 1);
}

void *my_realloc(MemoryPool *pool, void *ptr, size_t size) {
    MBlock *block = ptr - OVERHEAD;
    if (block->size >= size) {
        return ptr;
    }
    int size_can_stretch = block->size;
    while (block->next != NULL && block->next->free) {
        size_can_stretch += block->next->size;
        if (size_can_stretch >= size) {
            block->size = size_can_stretch;
            block->next = block->next->next;
            return ptr;
        }
        block = block->next;
    }
    if (block->next == NULL) {
        return ptr;
    }
    void *new_ptr = my_alloc(pool, size);
    my_memcpy(new_ptr, ptr, block->size);
    my_free(pool, ptr);
    return new_ptr;
}
