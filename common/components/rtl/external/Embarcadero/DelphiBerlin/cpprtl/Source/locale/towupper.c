/*-----------------------------------------------------------------------*
 * filename - towupper.c
 *
 * function(s)
 *        towupper - translates wide-characters to upper-case
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1996, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 23293 $        */

#undef __USELOCALES__
#define __SIMPLE_LOCALES__
#define _UNICODE
#include <windows.h>
#include <ctype.h>

/*---------------------------------------------------------------------*

Name            towupper - translates wide-characters to upper-case

Usage           wchar_t towupper(wchar_t c);

Prototype in    ctype.h

Description     towupper is a function that converts a wide-character c
		to its upper-case value (if it was lower-case): all
                others are left unchanged.

Return value    returns the converted/unchanged value of c.

*---------------------------------------------------------------------*/

wchar_t _RTLENTRY _EXPFUNC towupper( wchar_t ch )
{
    unsigned int c;

    if( ch == 0xffff )
	return( 0xffff );

    c = ch;
    return ((wchar_t) CharUpper((LPTSTR)c));
}
