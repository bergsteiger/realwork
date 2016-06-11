/*-----------------------------------------------------------------------*
 * filename - tmpfile_s.c
 *
 * function(s)
 *        tmpfile_s - creates a unique temporary file
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 2009, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision$        */

#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <sys/stat.h>
#include <_stdio.h>
#include <_io.h>
#include <_secure.h>

/*---------------------------------------------------------------------*

Name            tmpfile_s - creates a unique temporary file

Usage           #include <stdio.h>
                errno_t tmpfile_s(FILE **ptr);

Prototype in    stdio.h

Return value    On successful completion, zero
                In the event of error, non-zero

*---------------------------------------------------------------------*/

errno_t _RTLENTRY _EXPFUNC tmpfile_s(FILE * _RESTRICT * _RESTRICT streamptr)
{
    /* Constraints */
    if (streamptr == 0)
    {
	__invoke_constraint_handler_s(__func__, 0, EINVAL);
	return EINVAL;
    }

    /* Body */
    *streamptr = tmpfile();
    if (*streamptr == 0)
	return errno;
    return 0;
}
