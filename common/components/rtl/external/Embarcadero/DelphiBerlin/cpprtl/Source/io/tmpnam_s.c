/*-----------------------------------------------------------------------*
 * filename - tmpnam_s.c
 *
 * function(s)
 *        tmpnam_s   - builds a unique file name
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 2009, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 23293 $        */

#include <stdio.h>
#include <_stdio.h>
#include <_tchar.h>
#include <_secure.h>

/*---------------------------------------------------------------------*

Name            _ttmpnam_s used as tmpnam_s and _wtmpnam_s
                tmpnam_s   - builds a unique file name
                _wtmpnam_s - builds a unique wide file name

Usage           errno_t tmpnam_s(char *s, rsize_t maxsize);
                errno_t _wtmpnam(wchar_t *s, rsize_t maxsize);

Prototype in    stdio.h

Return value    zero on success

*---------------------------------------------------------------------*/

errno_t _RTLENTRY _EXPFUNC _ttmpnam_s(_TCHAR *s, rsize_t maxsize)
{
    errno_t err = 0;

    /* Constraints */
    if (s == 0)
	err = EINVAL;
    else if (maxsize > RSIZE_MAX || maxsize < L_tmpnam_s)
	err = ERANGE;

    if (!err)
    {
	/* Body */
	_lock_all_streams();

	if (__ttmpnam(s, &_tmpnum) == 0)
	    err = EINVAL;

	_unlock_all_streams();
    }

    if (err)
    {
	/* The specification seems inconsistent here as most constraints have the additional requirement */
#ifdef _STRICT_LIB_EXT1
	if (s && maxsize)
#else
	if (s && maxsize && maxsize <= RSIZE_MAX)
#endif
	    s[0] = 0;
	__invoke_constraint_handler_s(__func__, 0, err);
    }

    return err;
}
