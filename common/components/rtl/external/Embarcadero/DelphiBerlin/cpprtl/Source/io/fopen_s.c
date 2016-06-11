/*-----------------------------------------------------------------------*
 * filename - fopen_s.c
 *
 * function(s)
 *        fopen_s       - opens a stream
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
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <_io.h>
#include <_stdio.h>
#include <_tchar.h>
#include <_secure.h>

errno_t _RTLENTRY _EXPFUNC _tfopen_s(FILE * _RESTRICT * _RESTRICT streamptr,
				     const _TCHAR *filename, const _TCHAR *type)
{
    /* Constraints */
    if (streamptr == 0 || filename == 0 || type == 0)
    {
	if (streamptr)
	    *streamptr = 0;
	__invoke_constraint_handler_s(__func__, 0, EINVAL);
	return EINVAL;
    }

    /* Body */
    *streamptr = __tfopen_helper(filename, type, _O_SECURE);
    if (*streamptr == 0)
	return errno;
    return 0;
}
