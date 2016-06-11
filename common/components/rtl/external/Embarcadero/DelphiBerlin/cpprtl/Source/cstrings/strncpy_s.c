/*-----------------------------------------------------------------------*
 * filename - strncpy_s.c
 *
 * function(s)
 *        strncpy_s - copy string src to string dest
 *        wcsncpy_s - copy wide-character string src to wide-character string dest
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

errno_t _RTLENTRY  _EXPFUNC _tcsncpy_s(_TCHAR * _RESTRICT dest, rsize_t destmax,
				       const _TCHAR * _RESTRICT src, rsize_t n)
{
    int overlap;
    rsize_t len;
    errno_t err = 0;

    /* Constraints */
    overlap = __blocks_overlap(src, n, dest, destmax);
    if (destmax > RSIZE_MAX || n > RSIZE_MAX || destmax == 0)
	err = ERANGE;
    else if (src == 0 || dest == 0 || overlap)
	err = EINVAL;
    else
    {
	len = _tcsnlen_s(src, destmax);
	if (!(n < destmax) && !(destmax > len))
		err = ERANGE;
    }
    if (err)
    {
	if (dest && destmax > 0 && destmax <= RSIZE_MAX)
	    dest[0] = 0;
	__invoke_constraint_handler_s(__func__, 0, err);
	return err;
    }

    /* Body */
    if (len <= n)
    {
        _internal_memmove(src, dest, (len+1) * sizeof(_TCHAR));
    }
    else
    {
        _internal_memmove(src, dest, n * sizeof(_TCHAR));
        dest[n] = 0;
    }
    return 0;
}
