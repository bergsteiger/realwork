/*-----------------------------------------------------------------------*
 * filename - lstrxfrm.c
 *
 * function(s)
 *        _lstrxfrm - transforms a string according to the current locale's
 *                    collation rules.
 *        _lwcsxfrm - transforms a wide-character string according to the
 *                    current locale's collation rules.
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1987, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 23293 $        */


#include <string.h>
#include <_locale.h>
#include <tchar.h>

/*---------------------------------------------------------------------*

Name            _lstrxfrm - transforms a portion of a string

Usage           size_t _lstrxfrm( char *dest, const char *src, size_t n )
                size_t _lstrxfrm( wchar_t *dest, const wchar_t *src, size_t n )

Prototype in    string.h

Description     _lstrxfrm transforms the string pointed to by src into the
                string dest for no more than n characters.

Return value    Number of characters copied

*---------------------------------------------------------------------*/

size_t _RTLENTRY _EXPFUNC _ltcsxfrm( _TCHAR *s1, const _TCHAR *s2, size_t n )
{
    LPWIN32LOCALE locale = __locale;

    if (locale->isCLocale)
    {
        _tcsncpy(s1, s2, n);
        return _tcslen(s2);
    }

    return LCMapString(locale->handle, LCMAP_SORTKEY, s2, -1, s1, n);
}
