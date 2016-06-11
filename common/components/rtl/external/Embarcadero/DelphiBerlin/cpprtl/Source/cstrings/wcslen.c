/*-----------------------------------------------------------------------*
 * filename - wcslen.c
 *
 * function(s)
 *        wcslen - returns the length of an array of wchar_t's
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 23293 $ */

#include <string.h>

/*---------------------------------------------------------------------*

Name            wcslen - returns the length of an array of wchar_t's

Usage           size_t wcslen(wchar_t *__s);

Prototype in    string.h

Description     wcslen calculates the length of the string by counting
                each element until it finds a 0 value.

Return value    returns the length of the string

*---------------------------------------------------------------------*/

size_t      _RTLENTRY  _EXPFUNC wcslen(const wchar_t *__s)
{
    size_t len = 0;

    while ( __s[len] != 0)
        len++;
    return len;
}
