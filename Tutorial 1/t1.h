#pragma once
#include <cstdint>

extern "C" int _cdecl factorial(int N);
extern "C" int _cdecl poly(int arg);
extern "C" void multiple_k_asm(uint16_t M, uint16_t N, uint16_t K, uint16_t * array);