/*-----------------------------------------------------------------------*
 * filename - printf_s.c
 *
 * function(s)
 *        printf_s - send formatted output to stdout
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
#include <_printf.h>
#include <_stdio.h>
#include <_tchar.h>
#include <_secure.h>

/*---------------------------------------------------------------------*

Name            printf_s - send formatted output to stdout

Usage           int printf_s(const char *format, ...);

Prototype in    stdio.h

Description     sends formatted output to stdout

Return value    the number of bytes output.  In the event of an
                error, printf returns EOF.

*---------------------------------------------------------------------*/

int _RTLENTRY _EXPFUNC _tprintf_s(const _TCHAR * _RESTRICT fmt, ...)
{
    va_list ap;
    int ret;

    /* Constraints */
    if (!fmt)
    {
	__invoke_constraint_handler_s(__func__, 0, EINVAL);
	return CONSTRAINT_VIOLATION;
    }

    /* Body */
    va_start(ap,fmt);
    _lock_stream(stdout);
    ret = __vprintert ((putnF *)__fputnt, stdout, fmt, secure, 0, ap);
    _unlock_stream(stdout);
    va_end(ap);

    if (ret == CONSTRAINT_VIOLATION)
	__invoke_constraint_handler_s(__func__, 0, EINVAL);
    return (ret);
}
