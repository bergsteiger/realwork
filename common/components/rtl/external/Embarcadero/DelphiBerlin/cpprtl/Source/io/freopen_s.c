/*-----------------------------------------------------------------------*
 * filename - freopen_s.c
 *
 * function(s)
 *        freopen_s     - replaces a stream
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 2009, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision$        */

#include <stdio.h>
#include <_stdio.h>
#include <_tchar.h>
#include <_secure.h>

errno_t _RTLENTRY _EXPFUNC _tfreopen_s(FILE * _RESTRICT * _RESTRICT newstreamptr,
				       const _TCHAR * _RESTRICT filename,
				       const _TCHAR * _RESTRICT type,
				       FILE * _RESTRICT fp)
{
    /* Constraints */
    if (newstreamptr == 0 || type == 0 || fp == 0)
    {
	if (newstreamptr)
	    *newstreamptr = 0;
	__invoke_constraint_handler_s(__func__, 0, EINVAL);
	return EINVAL;
    }

    /* Body */
    *newstreamptr = _tfreopen(filename, type, fp);
    if (*newstreamptr == 0)
	return errno;
    return 0;
}
