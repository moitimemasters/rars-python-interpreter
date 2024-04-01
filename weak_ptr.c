#include "weak_ptr.h"

shared_ptr lock(weak_ptr* wp) {
    if (*(wp->ref_count) > 0) {
        shared_ptr sp;
        sp.ptr = wp->ptr;
        sp.ref_count = wp->ref_count;
        sp.weak_count = wp->weak_count;
        (*(sp.ref_count))++;
        return sp;
    } else {
        shared_ptr null_sp = {NULL, NULL, NULL, wp->pool};
        return null_sp;
    }
}

void release_weak(weak_ptr* wp) {
    (*(wp->weak_count))--;
    if (*(wp->ref_count) == 0 && *(wp->weak_count) == 0) {
        my_free(wp->pool, wp->weak_count);
    }
}

void retain_weak(weak_ptr* wp) { (*(wp->weak_count))++; }

weak_ptr make_weak(shared_ptr* sp) {
    weak_ptr wp;
    wp.ptr = sp->ptr;
    wp.ref_count = sp->ref_count;
    wp.weak_count = sp->weak_count;
    wp.pool = sp->pool;
    (*(wp.weak_count))++;
    return wp;
}

void release_shared(shared_ptr* sp) {
    (*(sp->ref_count))--;
    if (*(sp->ref_count) == 0) {
        my_free(sp->pool, sp->ptr);
        my_free(sp->pool, sp->ref_count);
        if (*(sp->weak_count) == 0) {
            my_free(sp->pool, sp->weak_count);
        }
    }
}

void retain_shared(shared_ptr* sp) { (*(sp->ref_count))++; }

shared_ptr make_shared(MemoryPool* pool, void* ptr) {
    shared_ptr sp;
    sp.ptr = ptr;
    sp.ref_count = (size_t*)my_alloc(pool, sizeof(size_t));
    sp.weak_count = (size_t*)my_alloc(pool, sizeof(size_t));
    *(sp.ref_count) = 1;
    *(sp.weak_count) = 0;
    return sp;
}

shared_ptr copy_shared(shared_ptr sp) {
    retain_shared(&sp);
    return sp;
}
