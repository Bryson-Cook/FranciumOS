#pragma once

#include <stdint.h>
#include <stdbool.h>

#define low_16(address) (uint16_t)((address) & 0xFFFF)
#define high_16(address) (uint16_t)(((address) >> 16) & 0xFFFF)

#define IGNORE(x) (void)(x)

int strlen(char s[]);

void reverse(char s[]);

void int_to_ascii(int n, char str[]);

bool backspace(char s[]);

void append(char s[], char n);

int strcmp(char s1[], char s2[]);

