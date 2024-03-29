#include <stdio.h>
#include <stdbool.h>

typedef struct MemoryPool
{
    void *start;
    void *end;
} MemoryPool;

typedef struct MBlock
{
    size_t size;
    bool free;
    struct MBlock *next;
} MBlock;

#define OVERHEAD sizeof(MBlock)

MBlock *find_free_block(MemoryPool *pool, size_t size)
{
    MBlock *curr = (MBlock *)pool->start;
    while (curr && !(curr->free && curr->size >= size))
    {
        curr = curr->next;
    }
    return curr;
}

void *my_alloc(MemoryPool *pool, size_t size)
{
    size_t extra = size % 8;
    if (extra != 0)
    {
        size += 8 - extra;
    }

    MBlock *block;
    if ((block = find_free_block(pool, size)) == NULL)
    {
        if ((void *)((size_t *)pool->start + size + OVERHEAD) > pool->end)
            return NULL;
        block = (MBlock *)pool->start;
        block->size = size;
        block->free = false;
        block->next = NULL;
        pool->start = (void *)((size_t *)pool->start + size + OVERHEAD);
    }
    else
    {
        block->free = false;
    }
    return (block + 1);
}

void my_free(MemoryPool *pool, void *ptr)
{
    if (!ptr)
        return;
    MBlock *block = ptr - OVERHEAD;
    block->free = true;
}
