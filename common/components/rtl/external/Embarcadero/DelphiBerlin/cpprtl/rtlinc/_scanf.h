/*------------------------------------------------------------------------
 * filename - _scanf.h
 *
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1987, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */


/* $Revision: 28548 $ */

#ifndef __SCANF_H
#define __SCANF_H

#if !defined(__STDARG_H)
#include <stdarg.h>
#endif

#if !defined(__STDDEF_H)
#include <stddef.h>
#endif

#include <tchar.h>

typedef _TINT GetF(void *);
typedef void UnGetF(_TCHAR, void *);

typedef enum
{
    isSuppressed = 1,
    isHalf       = 2,
    isLong       = 4,
    isLongDouble = 8,
    isExclusive  = 16,
    isFarPtr     = 32
} flagBits;

#define CONSTRAINT_VIOLATION (EOF-1)

#ifdef __cplusplus
extern "C" {
#endif
int _scanner     ( GetF        __Get,
                   UnGetF      __UnGet,
                   void       *__srceP,
                   const char *__formP,
                   va_list     __varPP );

int _scannerw    ( GetF        __Getw,
                   UnGetF      __UnGetw,
                   void       *__srceP,
                   const wchar_t *__formP,
                   va_list     __varPP );

int _scanner_s   ( GetF        __Get,
		   UnGetF      __UnGet,
                   void       *__srceP,
                   const char *__formP,
                   va_list     __varPP );

int _scannerw_s  ( GetF        __Getw,
		   UnGetF      __UnGetw,
                   void       *__srceP,
                   const wchar_t *__formP,
                   va_list     __varPP );

void _RTLENTRY _scantod (
                   void    *__valueP,   /* actually long double *   */
                   GetF     __Get,
                   UnGetF   __UnGet,
                   void    *__srceP,
                   int      __width,
                   int     *__countP,
                   int     *__statusP );

void _RTLENTRY _scanwtod (
                   void    *__valueP,   /* actually long double *   */
                   GetF     __Get,
                   UnGetF   __UnGet,
                   void    *__srceP,
                   int      __width,
                   int     *__countP,
                   int     *__statusP );

long _scantol    (
                   GetF     __Get,
                   UnGetF   __UnGet,
                   void    *__srceP,
                   int      __radix,
                   int      __width,
                   int     *__countP,
                   int     *__statusP,
                   unsigned __flags);

long _scanwtol    (
                   GetF     __Get,
                   UnGetF   __UnGet,
                   void    *__srceP,
                   int      __radix,
                   int      __width,
                   int     *__countP,
                   int     *__statusP,
                   unsigned __flags);


__int64 __scantoint64(
                   GetF     __Get,
                   UnGetF   __UnGet,
                   void    *__srceP,
                   int      __radix,
                   int      __width,
                   int     *__countP,
                   int     *__statusP,
                   unsigned __flags);

__int64 __scanwtoint64(
                   GetF     __Get,
                   UnGetF   __UnGet,
                   void    *__srceP,
                   int      __radix,
                   int      __width,
                   int     *__countP,
                   int     *__statusP,
                   unsigned __flags);

void _RTLENTRY _scanrslt (
                   void *__valueP,
                   void *__rsltP,
                   int   __rsltType);

/*
  Internal RTL function to perform double/float truncations.
*/
#define FLT 0
#define DBL 1
double __ldtrunc(int __flag, long double __x, double __xhuge);

#ifdef __cplusplus
}
#endif

#endif
