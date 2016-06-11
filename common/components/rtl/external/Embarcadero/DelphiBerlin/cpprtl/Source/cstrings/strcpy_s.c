/*-----------------------------------------------------------------------*
 * filename - strcpy_s.c
 *
 * function(s)
 *        strcpy_s - copy string src to string dest
 *        wcscpy_s - copy wide-character string src to wide-character string dest
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

errno_t _RTLENTRY  _EXPFUNC _tcscpy_s(_TCHAR * _RESTRICT dest, rsize_t destmax,
				      const _TCHAR * _RESTRICT src)
{
    rsize_t len;
    errno_t err = 0;

    /* Constraints */
    if (src == 0 || dest == 0)
	err = EINVAL;
    else if (destmax > RSIZE_MAX || destmax == 0)
	err = ERANGE;
    else
    {
	/* We need to know the length for these tests and the copy */
	len = _tcsnlen_s(src, destmax);
	if (!(destmax > len))
	    err = ERANGE;
	else if (__blocks_overlap(src, len, dest, destmax))
	    err = EINVAL;
    }
    if (err)
    {
	if (dest && destmax > 0 && destmax <= RSIZE_MAX)
	    dest[0] = 0;
	__invoke_constraint_handler_s(__func__, 0, err);
	return err;
    }

    /* Body */
    _internal_memmove(src, dest, (len+1) * sizeof(_TCHAR));

    return 0;
}
