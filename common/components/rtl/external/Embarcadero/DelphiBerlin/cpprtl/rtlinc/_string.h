/*------------------------------------------------------------------------
 * filename - _string.h
 *
 *      Definitions for memory and string functions.
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1992, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */


/* $Revision: 34094 $ */

#ifndef __STRING_H
#include <string.h>
#endif

#if !defined(___DEFS_H)
#include <_defs.h>
#endif

#ifndef NULL
#include <_null.h>
#endif

#ifndef _SIZE_T
#define _SIZE_T
typedef unsigned size_t;
#endif

#ifdef __cplusplus
extern "C" {
#endif

char _FAR * _RTLENTRY _EXPFUNC  cstrlwr(char _FAR *__s);
char _FAR * _RTLENTRY _EXPFUNC  cstrupr(char _FAR *__s);

int    _RTLENTRY _EXPFUNC _strcoll(const char _FAR *__s1, const char _FAR *__s2);
size_t _RTLENTRY _EXPFUNC _strxfrm(char _FAR *__s1, const char _FAR *__s2,
               size_t __n );

void _RTLENTRY _vstrcat(char *buf, int maxlen, ...);

#ifdef __cplusplus
}
#endif
