/*-----------------------------------------------------------------------*
 * filename - fscanf_s.c
 *
 * function(s)
 *        fscanf_s - performs formatted input from a stream
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

#undef   ungetc         /* remove the macro version */

/*---------------------------------------------------------------------*

Name            fscanf_s - performs formatted input from a stream

Usage           #include <stdio.h>
                int fscanf(FILE *stream, const char *format[, argument,...]);

Prototype in    stdio.h

Description     reads data from the named input stream into the locations
                given by the address arguments

Return value    the number of input fields successfully scanned, converted
                and stored; the return value does not include scanned
                fields that were not stored.

                If an attempt is made to read at end-of-file, the return
                value is EOF.

                If no fields were stored, the return value is 0

*---------------------------------------------------------------------*/

int _RTLENTRY _EXPFUNC _ftscanf_s (FILE * _RESTRICT fp, const _TCHAR * _RESTRICT fmt, ...)
{
    va_list ap;
    int ret;

    errno_t err = 0;

    /* Constraints */
    if (!fp || !fmt)
	err = EINVAL;

    /* Body */
    if (!err)
    {
	va_start(ap,fmt);
	_lock_stream(fp);
	ret =  _scannert_s((GetF *)_fgettc,
			   (UnGetF *)_ungettc,
			   fp,
			   fmt,
			   ap);
	_unlock_stream(fp);
	va_end(ap);
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
