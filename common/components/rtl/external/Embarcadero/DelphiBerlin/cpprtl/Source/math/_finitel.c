/*------------------------------------------------------------------------
 * filename - _finitel.c
 *
 * function(s)
 *
 *   _finitel   - long double version
 *
 * These functions return 1 if the value passed in is finite, and 0 if not
 *
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1996, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 24470 $        */

#include <float.h>
#include <_float.h>

int _RTLENTRY _EXPFUNC _finitel (long double ld)
{
    if ((((_rtl_ldouble_t *)&ld)->i16.value & 0x7FFFU) == 0x7FFFU)
	return 0;

    return 1;
}
