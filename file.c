#include "file.h"
#define FILE_BUF_SIZE 256

String* read_whole_file(MemoryPool* pool, const char* filename) {
    int fd = open_file(filename, 0);
    if (fd < 0) {
        my_printf("Error opening the file: %s\n", filename);
        return NULL;
    }
    char buffer[FILE_BUF_SIZE];
    int bytes_read = read_file(fd, buffer, FILE_BUF_SIZE);
    String* result = empty(pool);
    while (bytes_read == FILE_BUF_SIZE) {
        append_string_view(result,
                           (string_view_t){.str = buffer, .len = bytes_read});
        bytes_read = read_file(fd, buffer, FILE_BUF_SIZE);
    }
    if (bytes_read == -1) {
        string_destroy(result);
        my_free(pool, result);
        return NULL;
    }
    append_string_view(result,
                       (string_view_t){.str = buffer, .len = bytes_read});
    close(fd);
    return result;
}
