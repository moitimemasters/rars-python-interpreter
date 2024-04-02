#ifndef FILE_H
#define FILE_H

#include "allocator.h"
#include "string.h"
#include "syscall.h"

String* read_whole_file(MemoryPool* pool, const char* filename);

#endif  // FILE_H
