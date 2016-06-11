/* ===-- fixunssfdi.c - Implement __fixunssfdi -----------------------------===
 *
 *                     The LLVM Compiler Infrastructure
 *
 * This file is dual licensed under the MIT and the University of Illinois Open
 * Source Licenses. See LICENSE.TXT for details.
 *
 * ===----------------------------------------------------------------------===
 *
 * This file implements __fixunssfdi for the compiler_rt library.
 *
 * ===----------------------------------------------------------------------===
 */

// NOTE: This file is the result of preprocessing with bcc32c.exe the file
// lib/fixunssfdi.c from LLVM's compiler_rt project from official SVN server:
// http://llvm.org/svn/llvm-project/compiler-rt/branches/release_33/lib/fixunssfdi.c
// at revision 242143.

typedef unsigned su_int;

typedef unsigned long long du_int;

typedef union
{
    su_int u;
    float f;
} float_bits;

/* Returns: convert a to a unsigned long long, rounding toward zero.
 *          Negative values all become zero.
 */

/* Assumption: float is a IEEE 32 bit floating point type 
 *             du_int is a 64 bit integral type
 *             value in float is representable in du_int or is negative 
 *                 (no range checking performed)
 */

/* seee eeee emmm mmmm mmmm mmmm mmmm mmmm */

du_int __fixunssfdi(float a)
{
    float_bits fb;
    fb.f = a;
    int e = ((fb.u & 0x7F800000) >> 23) - 127;
    if (e < 0 || (fb.u & 0x80000000))
        return 0;
    du_int r = (fb.u & 0x007FFFFF) | 0x00800000;
    if (e > 23)
        r <<= (e - 23);
    else
        r >>= (23 - e);
    return r;
}
