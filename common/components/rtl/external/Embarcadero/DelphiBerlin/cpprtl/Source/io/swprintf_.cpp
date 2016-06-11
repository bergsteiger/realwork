/*-----------------------------------------------------------------------*
 * filename - swprintf.cpp
 *
 * function(s)
 *	  swprintf - This version has the correct signature.
 *-----------------------------------------------------------------------*/
/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1987, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 23293 $        */

#define _UNICODE

#include <stdio.h>
#include <mem.h>
#include <string.h>
#include <_printf.h>
#include <_tchar.h>

/*---------------------------------------------------------------------*

Name            strputn - copies an n element string

Usage           static size_t strputn(char *S, size_t n, char **bufPP,
                                      int eos_flag)

Description     copies n bytes from block pointed to by S to the block
                pointed to by bufPP.  bufPP is incremented by n.

Return value    returns the value n.

*---------------------------------------------------------------------*/

static size_t strputn(_TCHAR *S, size_t n, _TCHAR **bufPP, int eos_flag)
{
    memcpy (*bufPP, S, (n * sizeof (_TCHAR)));
    if (eos_flag)
        *(*bufPP += n) = _TEXT('\0');
    return n;
}

#ifdef __cplusplus
namespace std {
#endif /* __cplusplus */

int _RTLENTRY _EXPFUNC swprintf(wchar_t *bufP, _SIZE_T nsize, const wchar_t * fmt, ...)
{
    va_list ap;
    int ret;

    if (nsize >= 1)
        *bufP = _TEXT('\0');

    va_start(ap,fmt);
    ret = __vprintert ((putnF *)strputn, &bufP, fmt, 1, nsize, ap);
    va_end(ap);

    if ((size_t)ret > nsize)
      ret = -1;

    return (ret);
}

#ifdef __cplusplus
}
#endif