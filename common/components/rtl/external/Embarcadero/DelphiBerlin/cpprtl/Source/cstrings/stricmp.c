/*-----------------------------------------------------------------------*
 * filename - stricmp.c
 *
 * function(s)
 *        stricmp - compare one ASCII string to another without case sensitivity
 *        wcsicmp - compare one wide-character string to another without case
 *                  sensitivity
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1987, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 28609 $        */

#include <string.h>
#include <tchar.h>
#include <_locale.h>

#ifndef MINIRTL
#include <ctype.h>
#else
#define _totupper toupper
int     _RTLENTRY _EXPFUNC toupper(int __ch);
#endif

/*-----------------------------------------------------------------------*

Name            stricmp, wcsicmp - compare one ASCII/wide-character string
                to another without case sensitivity

Usage           int stricmp(const char *str1, const char *str2);
                int wcsicmp(const wchar_t *str1, const wchar_t *str2);

Prototype in    string.h

Description     Case-independent  comparison of  *str1 with  *str2. Compare
                the strings, but act as if upper and lower case characters
                were always upper-case, returning a negative, zero, or
                positive integer according to whether *str1 is less than,
                equal, or greater than *str2, respectively.

                The strings *str1 and *str2 are not changed.

                When comparing to punctuation characters alphabetics are
                always treated as upper-case.

Return value    stricmp and wcsicmp return an integer value that is:
                        < 0     if str1 is less than str2
                        = 0     if str1 is the same as str2
                        > 0     if str2 is greater than str2

*------------------------------------------------------------------------*/

int _RTLENTRY _EXPFUNC _tcsicmp(const _TCHAR *str1, const _TCHAR *str2)
{
    int clocale;

    _lock_locale();
    clocale = __locale->isCLocale;
    _unlock_locale();

    // inline the _totupper() function for __locale->isCLocale == true
    if (clocale)
    {
        _TUCHAR c1, c2; // better CPU register usage
         while ((c1 = (_TCHAR)_upper[*str1 & 0x00ff]) == (c2 = (_TCHAR)_upper[*str2 & 0x00ff]) && c1 != _TEXT('\0'))
        {
            str1++;
            str2++;
        }
        return (c1 - c2);
    }
    else
    {
        _TUCHAR c1, c2;
        while ((c1 = (_TCHAR)_totupper(*str1)) == (c2 = (_TCHAR)_totupper(*str2)) && c1 != _TEXT('\0'))
        {
            str1++;
            str2++;
        }
        return (c1 - c2);
    }
}
