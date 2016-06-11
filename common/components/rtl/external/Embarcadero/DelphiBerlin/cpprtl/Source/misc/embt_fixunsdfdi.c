/* ===-- fixunsdfdi.c - Implement __fixunsdfdi -----------------------------===
 *
 *                     The LLVM Compiler Infrastructure
 *
 * This file is dual licensed under the MIT and the University of Illinois Open
 * Source Licenses. See LICENSE.TXT for details.
 *
 * ===----------------------------------------------------------------------===
 *
 * This file implements __fixunsdfdi for the compiler_rt library.
 *
 * ===----------------------------------------------------------------------===
 */

// NOTE: This file is the result of preprocessing with bcc32c.exe the file
// lib/fixunsdfdi.c from LLVM's compiler_rt project from official SVN server:
// http://llvm.org/svn/llvm-project/compiler-rt/branches/release_33/lib/fixunsdfdi.c
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

typedef union
{
    udwords u;
    double f;
} double_bits;

/* Returns: convert a to a unsigned long long, rounding toward zero.
 *          Negative values all become zero.
 */

/* Assumption: double is a IEEE 64 bit floating point type 
 *             du_int is a 64 bit integral type
 *             value in double is representable in du_int or is negative 
 *                 (no range checking performed)
 */

/* seee eeee eeee mmmm mmmm mmmm mmmm mmmm | mmmm mmmm mmmm mmmm mmmm mmmm mmmm mmmm */

du_int __fixunsdfdi(double a)
{
    double_bits fb;
    fb.f = a;
    int e = ((fb.u.s.high & 0x7FF00000) >> 20) - 1023;
    if (e < 0 || (fb.u.s.high & 0x80000000))
        return 0;
    udwords r;
    r.s.high = (fb.u.s.high & 0x000FFFFF) | 0x00100000;
    r.s.low = fb.u.s.low;
    if (e > 52)
        r.all <<= (e - 52);
    else
        r.all >>= (52 - e);
    return r.all;
}
