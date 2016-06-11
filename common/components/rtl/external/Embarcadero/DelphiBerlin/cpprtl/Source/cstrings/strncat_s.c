/*-----------------------------------------------------------------------*
 * filename - strncat_s.c
 *
 * function(s)
 *        strncat_s - appends a copy of src to the end of dest.
 *        wcsncat_s - appends a copy of src to the end of dest.
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

errno_t _RTLENTRY  _EXPFUNC _tcsncat_s(_TCHAR * _RESTRICT dest, rsize_t destmax,
				       const _TCHAR * _RESTRICT src, rsize_t n)
{
    int overlap;
    size_t m, destlen, srclen;
    errno_t err = 0;

    /* Constraints */
    destlen = _tcsnlen_s(dest, destmax);
    m = destmax - destlen;
    overlap = __blocks_overlap(src, n, dest, destmax);
    if (src == 0 || dest == 0 || overlap)
	err = EINVAL;
    else if (destmax > RSIZE_MAX || n > RSIZE_MAX || destmax == 0 || m == 0)
	err = ERANGE;
    else
    {
	srclen = _tcsnlen_s(src, n);
	if (n >= m && m <= srclen)
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
    if (srclen < n)
	_internal_memmove(src, dest+destlen, (srclen+1) * sizeof(_TCHAR));
    else
    {
	_internal_memmove(src, dest+destlen, n * sizeof(_TCHAR));
	dest[destmax-m+n] = 0;
    }

    return 0;
}
