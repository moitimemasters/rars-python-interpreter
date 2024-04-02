/* Define syscall service codes */
#define PRINT_INT 1
#define PRINT_STR 4
#define PRINT_CHAR 11
#define PRINT_FLOAT 2
#define PRINT_DOUBLE 3
#define READ_INT 5
#define READ_STR 8
#define READ_FLOAT 6
#define READ_DOUBLE 7
#define EXIT 10
#define SBRK 9
#define OPEN_FILE 1024
#define CLOSE 57
#define RO 0
#define WO 1
#define WA 9
#define READ 63
#define WRITE 64

/* Defining wrapper functions */
void print_string(const char *str) {
    asm volatile(
        "mv a0, %0\n\t"
        "li a7, %1\n\t"
        "ecall\n\t"
        :
        : "r"(str), "I"(PRINT_STR)
        : "a0", "a7");
}

void print_char(char val) {
    asm volatile(
        "mv a0, %0\n\t"
        "li a7, %1\n\t"
        "ecall\n\t"
        :
        : "r"(val), "I"(PRINT_CHAR)
        : "a0", "a7");
}

void print_int(int val) {
    asm volatile(
        "mv a0, %0\n\t"
        "li a7, %1\n\t"
        "ecall\n\t"
        :
        : "r"(val), "I"(PRINT_INT)
        : "a0", "a7");
}

int read_int() {
    int val;
    asm volatile(
        "li a7, %1\n\t"
        "ecall\n\t"
        "mv %0, a0\n\t"
        : "=r"(val)
        : "I"(READ_INT)
        : "a0", "a7");
    return val;
}

void *sbrk(int nbytes) {
    void *ptr;
    asm volatile(
        "mv a0, %1\n\t"
        "li a7, %2\n\t"
        "ecall\n\t"
        "mv %0, a0\n\t"
        : "=r"(ptr)
        : "r"(nbytes), "I"(SBRK)
        : "a0", "a7");
    return ptr;
}

float read_float() {
    float val;
    asm volatile(
        "li a7, %1\n\t"
        "ecall\n\t"
        "fmv.s %0, fa0\n\t"
        : "=f"(val)
        : "I"(READ_FLOAT)
        : "a7", "fa0");
    return val;
}

double read_double() {
    double val;
    asm volatile(
        "li a7, %1\n\t"
        "ecall\n\t"
        "fmv.d %0, fa0\n\t"
        : "=f"(val)
        : "I"(READ_DOUBLE)
        : "a7", "fa0");
    return val;
}

void print_float(float val) {
    asm volatile(
        "fmv.s fa0, %0\n\t"
        "li a7, %1\n\t"
        "ecall\n\t"
        :
        : "f"(val), "I"(PRINT_FLOAT)
        : "fa0", "a7");
}

void print_double(double val) {
    asm volatile(
        "fmv.d fa0, %0\n\t"
        "li a7, %1\n\t"
        "ecall\n\t"
        :
        : "f"(val), "I"(PRINT_DOUBLE)
        : "fa0", "a7");
}

void read_string(char *str, int n) {
    asm volatile(
        "mv a0, %0\n\t"
        "mv a1, %1\n\t"
        "li a7, %2\n\t"
        "ecall\n\t"
        :
        : "r"(str), "r"(n), "I"(READ_STR)
        : "a0", "a1", "a7");
}

int open_file(const char *filename, int flag) {
    int fd;
    asm volatile(
        "mv a0, %1\n\t"
        "mv a1, %2\n\t"
        "li a7, 1024\n\t"
        "ecall\n\t"
        "mv %0, a0\n\t"
        : "=r"(fd)
        : "r"(filename), "r"(flag)
        : "a0", "a1", "a7");
    return fd;
}

int read_file(int fd, char *buf, int count) {
    int bytes_read;
    asm volatile(
        "mv a0, %1\n\t"
        "mv a1, %2\n\t"
        "mv a2, %3\n\t"
        "li a7, 63\n\t"
        "ecall\n\t"
        "mv %0, a0\n\t"
        : "=r"(bytes_read)
        : "r"(fd), "r"(buf), "r"(count)
        : "a0", "a1", "a2", "a7");
    return bytes_read;
}

void close(int fd) {
    asm volatile(
        "mv a0, %0\n\t"
        "li a7, %1\n\t"
        "ecall\n\t"
        :
        : "r"(fd), "I"(CLOSE)
        : "a0", "a7");
}

void Exit() {
    asm volatile(
        "li a7, %0\n\t"
        "ecall\n\t"
        :
        : "I"(EXIT));
}
