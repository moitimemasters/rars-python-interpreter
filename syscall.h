// syscall.h

#ifndef SYSCALL_H
#define SYSCALL_H

#include <stddef.h>

void printstr(const char *str);
void printint(int val);
void printchar(char val);
int readint();
void *sbrk(int nbytes);
float readFloat();
double readDouble();
void printFloat(float val);
void printDouble(double val);
void readString(char *str, int n);
void Exit();

#endif  // SYSCALL_H
