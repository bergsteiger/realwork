/*-----------------------------------------------------------------------*
 * filename - memmove_s.c
 *
 * function(s)
 *        memmove_s - copies a block of n bytes from src to dest
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
#include <_secure.h>

#if !defined(_UNICODE)
errno_t _RTLENTRY  _EXPFUNC memmove_s(void * _RESTRICT dest, rsize_t destmax,
				      const void * _RESTRICT src, rsize_t n)
#else
errno_t _RTLENTRY  _EXPFUNC wmemmove_s(wchar_t * _RESTRICT dest, rsize_t destmax,
				       const wchar_t * _RESTRICT src, rsize_t n)
#endif
{
    errno_t err = 0;

    /* Constraints */
    if (destmax > RSIZE_MAX || n > RSIZE_MAX || n > destmax)
	err = ERANGE;
    else if (!src || !dest)
	err = EINVAL;
    if (err)
    {
	if (dest && destmax && destmax <= RSIZE_MAX)
	    _tmemset(dest, 0, destmax);
	__invoke_constraint_handler_s(__func__, 0, err);
	return err;
    }

    /* Body */
    _internal_memmove(src, dest, n * sizeof(_TCHAR));  /* safe for overlapping blocks */

    return 0;
}
