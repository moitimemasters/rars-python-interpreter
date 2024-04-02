// syscall.h

#ifndef SYSCALL_H
#define SYSCALL_H

void print_string(const char *str);

void print_char(char val);

void print_int(int val);

int read_int();

void *sbrk(int nbytes);

float read_float();

double read_double();

void print_float(float val);

void print_double(double val);

void read_string(char *str, int n);

int open_file(const char *filename, int flag);

int read_file(int fd, char *buf, int count);

void close(int fd);

void Exit();

#endif  // SYSCALL_H
