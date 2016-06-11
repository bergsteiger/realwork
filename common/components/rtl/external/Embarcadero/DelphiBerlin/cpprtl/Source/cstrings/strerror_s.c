/*-----------------------------------------------------------------------*
 * filename - strerror_s.c
 *
 * function(s)
 *    strerror_s    - copies error message string to buffer
 *    strerrorlen_s - returns the length of the error message for a code
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 2009, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision$        */

#include <_tchar.h>
#include <string.h>
#include <errno.h>
#include <stdlib.h>
#include <_secure.h>

errno_t _RTLENTRY _EXPFUNC _tcserror_s(_TCHAR *s, rsize_t maxsize, errno_t errnum)
{
    _TCHAR *p;
    size_t len;
    errno_t err = 0;

    /* Constraints */
    if (s == 0)
	err = EINVAL;
    else if ( maxsize == 0 || maxsize > RSIZE_MAX)
	err = ERANGE;
    if (err)
    {
	__invoke_constraint_handler_s(__func__, 0, err);
	return err;
    }

    /* Body */
    p = _tcserror(errnum);
    len = _tcslen(p);
    if (len < maxsize)
	memcpy(s, p, (len+1)*sizeof(_TCHAR));
    else
    {
	memcpy(s, p, (maxsize-1)*sizeof(_TCHAR));
	s[maxsize-1] = 0;
	if (maxsize > 3)
	{
	    s[maxsize-2] = s[maxsize-3] = s[maxsize-4] = _T('.');
	}
    }
    return err;
}

#if !defined(_UNICODE)
/* The error messages are stored as narrow strings so we don't need a wide version */
size_t _RTLENTRY _EXPFUNC strerrorlen_s(errno_t errnum)
{
    char *p = _tcserror(errnum);
    return strlen(p);
}
#endif
