/*-----------------------------------------------------------------------*
 * filename - vfscanf_s.c
 *
 * function(s)
 *        vfscanf_s - performs formatted input from a stream
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 2009, 2016 by Embarcadero Technologies, Inc.
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

Name            vfscanf - performs formatted input from a stream

Usage           #include <stdio.h>
                int vfscanf(FILE *stream, char *format, va_list param);

Prototype in    stdio.h

Description     see ...scanf

*---------------------------------------------------------------------*/

int _RTLENTRY _EXPFUNC _vftscanf_s( FILE * _RESTRICT fp, const _TCHAR * _RESTRICT fmt, va_list ap )
{
    int ret;
    errno_t err = 0;

    /* Constraints */
    if (!fp || !fmt)
	err = EINVAL;

    /* Body */
    if (!err)
    {
	_lock_stream(fp);
	ret =  _scannert_s( (GetF *)_fgettc,
			    (UnGetF *)_ungettc,
			    fp,
			    fmt,
			    ap );
	_unlock_stream(fp);
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
