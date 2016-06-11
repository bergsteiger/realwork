/***
*iswctype.c - support isw* wctype functions/macros for wide characters
*
*       Copyright (c) 1991-1993, Microsoft Corporation. All rights reserved.
*
*Purpose:
*       Defines iswctype - support isw* wctype functions/macros for
*       wide characters (esp. > 255).
*
*******************************************************************************/
/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1996, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 34094 $        */

#define _UNICODE
#include <ntbc.h>
#include <ctype.h>
#include <stdio.h>
#include <locale.h>
#include <_locale.h>
#include <tchar.h>
#include <winbase.h>
#include <winnls.h>
#include <winnt.h>


/*
 *  iswctype - support isw* wctype functions/macros.
 *
 *  Purpose:
 *
 *  Entry:
 *       wchar_t c    - the wide character whose type is to be tested
 *       wchar_t mask - the mask used by the isw* functions/macros
 *                       corresponding to each character class property
 *
 *  Exit:
 *       Returns non-zero if c is of the character class.
 *       Returns 0 if c is not of the character class.
 *
 *  Exceptions:
 *       Returns 0 on any error.
 *
 ********************************************************************************/

extern unsigned short _RTLENTRY _chartype[ 257 ];

static int __fastcall __inline getwctypeflags(int c)
{
    wchar_t d;
    int clocale;

    if (c == WEOF)
        return 0;

    _lock_locale();
    if ((__locale->isCLocale) && (c < 256))
        clocale = 1;
    else
        clocale = 0;
    _unlock_locale();

    if (clocale)
        d = (_chartype[(short) c + 1]);
    else
	GetStringTypeW(CT_CTYPE1, (LPCWSTR)&c, 1, &d);
    return (int)d;
}

int _RTLENTRY _EXPFUNC __iswctype( int c, int type )
{
    return getwctypeflags(c) & type;
}

int _RTLENTRY _EXPFUNC __iswctypeEx( int c, int type, int disallow )
{
    int flags = getwctypeflags(c);
    if (!(flags & disallow))
        return flags & type;
    return 0;
}
