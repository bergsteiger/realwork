/* ===-- fixunsxfdi.c - Implement __fixunsxfdi -----------------------------===
 *
 *                     The LLVM Compiler Infrastructure
 *
 * This file is dual licensed under the MIT and the University of Illinois Open
 * Source Licenses. See LICENSE.TXT for details.
 *
 * ===----------------------------------------------------------------------===
 *
 * This file implements __fixunsxfdi for the compiler_rt library.
 *
 * ===----------------------------------------------------------------------===
 */

// NOTE: This file is the result of preprocessing with bcc32c.exe the file
// lib/fixunsxfdi.c from LLVM's compiler_rt project from official SVN server:
// http://llvm.org/svn/llvm-project/compiler-rt/branches/release_33/lib/fixunsxfdi.c
// at revision 242143.

typedef unsigned su_int;

typedef unsigned long long du_int;

typedef union
{
    du_int all;
    struct
    {
        su_int low;
        su_int high;
    }s;
} udwords;

typedef struct
{
    udwords low;
    udwords high;
} uqwords;

typedef union
{
    uqwords u;
    long double f;
} long_double_bits;

/* Returns: convert a to a unsigned long long, rounding toward zero.
 *          Negative values all become zero.
 */

/* Assumption: long double is an intel 80 bit floating point type padded with 6 bytes
 *             du_int is a 64 bit integral type
 *             value in long double is representable in du_int or is negative 
 *                 (no range checking performed)
 */

/* gggg gggg gggg gggg gggg gggg gggg gggg | gggg gggg gggg gggg seee eeee eeee eeee |
 * 1mmm mmmm mmmm mmmm mmmm mmmm mmmm mmmm | mmmm mmmm mmmm mmmm mmmm mmmm mmmm mmmm
 */
 
du_int __fixunsxfdi(long double a)
{
    long_double_bits fb;
    fb.f = a;
    int e = (fb.u.high.s.low & 0x00007FFF) - 16383;
    if (e < 0 || (fb.u.high.s.low & 0x00008000))
        return 0;
    return fb.u.low.all >> (63 - e);
}
