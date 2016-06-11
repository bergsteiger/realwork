/*-----------------------------------------------------------------------*
 * filename - strnlen_s.c
 *
 * function(s)
 *        strnlen_s - computes length of string
 *        strnlen_s - computes lenght wide-character string
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 2009, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision$        */

#include <string.h>
#include <tchar.h>

//#pragma option -k-

size_t _RTLENTRYF /*__fastcall*/  _EXPFUNC _tcsnlen_s(const _TCHAR * s, size_t maxsize)
{
    size_t i;

    if (!s)
	return 0;
    for (i=0; i<maxsize && s[i]; i++)
	;
    return i;
}
