#include "file.h"

String* read_whole_file(MemoryPool* pool, const char* filename) {
    int fd = open_file(filename, 0);
    if (fd < 0) {
        my_printf("Error opening the file: %s\n", filename);
        return NULL;
    }
    char buffer[256];
    int bytes_read = read_file(fd, buffer, 256);
    String* result = from_string_view(
        pool, (string_view_t){.str = buffer, .len = bytes_read});
    while (bytes_read == 256) {
        append_string_view(result,
                           (string_view_t){.str = buffer, .len = bytes_read});
        bytes_read = read_file(fd, buffer, 256);
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
