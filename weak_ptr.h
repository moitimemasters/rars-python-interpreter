#ifndef WEAK_PTR_H
#define WEAK_PTR_H

#include "allocator.h"

typedef struct {
    void* ptr;
    size_t* ref_count;
    size_t* weak_count;
    MemoryPool* pool;
} shared_ptr;

typedef struct {
    void* ptr;
    size_t* ref_count;
    size_t* weak_count;
    MemoryPool* pool;
} weak_ptr;

shared_ptr make_shared(MemoryPool* pool, void* ptr);
shared_ptr copy_shared(shared_ptr sp);

void retain_shared(shared_ptr* sp);

void release_shared(shared_ptr* sp);

weak_ptr make_weak(shared_ptr* sp);

void retain_weak(weak_ptr* wp);

void release_weak(weak_ptr* wp);

shared_ptr lock(weak_ptr* wp);

#endif
