/*-----------------------------------------------------------------------*
 * filename - lstrlwr.c
 *
 * function(s)
 *        _lwcslwr - converts a wide-character string to lower-case according
 *                   to the current locale
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1996, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 23293 $        */

#define _UNICODE
#include <string.h>
#include <ctype.h>
#include <_locale.h>
#include <tchar.h>

/*---------------------------------------------------------------------*

Name            _lwcslwr - converts a wide-character string to lower-case

Usage           wchar_t *_lstrlwr(wchar_t *str);

Prototype in    string.h

Description     _lwcslwr converts upper-case letters in a wide-character
                         string str to lower-case.  No other changes occur.

Return value    pointer to the converted string

*---------------------------------------------------------------------*/

wchar_t * _RTLENTRYF _EXPFUNC _lwcslwr(wchar_t *str)
{
    wchar_t *p = (wchar_t *) str;

    while ( (*p = (wchar_t) _ltowlower( *p ) ) != L'\0')
         p++;

    return str;
}


