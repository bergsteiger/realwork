/*-----------------------------------------------------------------------*
 * filename - ltowupper.c
 *
 * function(s)
 *        _ltowupper - translates wice-characters to upper-case according to the
 *                    current locale
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1996, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 23391 $        */

#define _UNICODE
#include <stdio.h>
#include <ctype.h>
#include <_locale.h>

/*---------------------------------------------------------------------*

Name            _ltowupper - translates wide-characters to upper-case

Usage           wchar_t _ltowupper(wchar_t c);

Prototype in    _ltowupper is a function that converts a wide-character c
                to its upper-case value according to the current locale

Return value    returns the converted value of c, on success, and
                nothing on failure.

*---------------------------------------------------------------------*/

wchar_t _RTLENTRYF _EXPFUNC _ltowupper( wchar_t ch )
{
    LPWIN32LOCALE locale = __locale;
    wchar_t result;

    /* check for EOF */
    if( ch == WEOF )
        return( WEOF );

    if (locale->isCLocale)
    {
        if (ch < 256)
            return _upper[ ch & 0x00ff];
        else
            return ch;
    }

    LCMapString(locale->handle, LCMAP_UPPERCASE, (LPCSTR) &ch, 1, (LPTSTR)&result, sizeof(result));
    return result;
}
