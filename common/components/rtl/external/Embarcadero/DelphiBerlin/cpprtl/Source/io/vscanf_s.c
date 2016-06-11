/*-----------------------------------------------------------------------*
 * filename - vscanf.c
 *
 * function(s)
 *        vscanf - performs formatted input from stdin
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1987, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 25143 $        */

#include <stdarg.h>
#include <stdio.h>
#include <_stdio.h>
#include <_scanf.h>
#include <_tchar.h>
#include <_secure.h>

#undef   ungetc     /* remove the macro version */

/*---------------------------------------------------------------------*

Name            vscanf - performs formatted input from stdin

Usage           int vscanf(const char *format, va_list param);

Prototype in    stdio.h

Description     see ...scanf

*---------------------------------------------------------------------*/

int _RTLENTRY _EXPFUNC _vtscanf_s (const _TCHAR * _RESTRICT fmt, va_list ap)
{
    int ret;
    errno_t err = 0;

    /* Constraints */
    if (!fmt)
	err = EINVAL;

    /* Body */
    if (!err)
    {
	_lock_stream(stdin);
	ret = _scannert_s((GetF *)_fgettc,
			  (UnGetF *)_ungettc,
			  stdin,
			  fmt,
			  ap );
	_unlock_stream(stdin);
	if (ret == CONSTRAINT_VIOLATION)
	    err = EINVAL;
    }
    if (err)
    {
	__invoke_constraint_handler_s(__func__, 0, err);
	return EOF;
    }
    return (ret);
}
