/*-----------------------------------------------------------------------*
 * filename - mbstrlen.c
 *
 * function(s)
 *        _mbstrlen - Caluclates the length of a string.
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 2009, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */


#include <mbctype.h>
#include <mbstring.h>

/*-----------------------------------------------------------------------*

Name            _mbstrlen - Calculates the length of a string.

Usage           size_t _mbstrlen(const unsigned char *str);

Prototype in    mbstring.h

Description     Returns the number of characters in string with
                null-terminating character.

Return value    Returns the number of characters or -1 if not valid.

*------------------------------------------------------------------------*/

#include <stdlib.h>
#include <mbctype.h>
#include <windows.h>
#include <_locale.h>

size_t _RTLENTRY _EXPFUNC _mbstrlen(const char *s)
{
    size_t n;

    if (__mb_cur_max == 1)
    {
	return strlen(s);
    }

    /* Test for validity */
    if ( MultiByteToWideChar( __locale->codepage,
			      MB_PRECOMPOSED|MB_ERR_INVALID_CHARS,
			      s, -1, NULL, 0 ) == 0 )
    {
	errno = EILSEQ;
	return -1;
    }

    for (n = 0; *s; s++, n++)
    {
        if (_ismbblead(*s))
        {
            s++;
            if (*s == '\0')
                break;
        }
    }

    return n;
}
