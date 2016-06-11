/*-----------------------------------------------------------------------*
 * filename - vfprintf.c
 *
 * function(s)
 *    vfprintf - sends formatted output to a stream
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1987, 2016 by Embarcadero Technologies, Inc.
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

Name            vfprintf - sends formatted output to a stream

Usage           #include <stdio.h>
                #include <stdarg.h>
                int vfprintf(FILE *stream, const char *format, va_list param);

Prototype in    stdio.h
                stdarg.h

Description     see printf

*---------------------------------------------------------------------*/

int _RTLENTRY _EXPFUNC _vftprintf_s( FILE *F, const _TCHAR *fmt, va_list ap )
{
    int ret;

     /* Constraints */
    if (!F || !fmt)
    {
	__invoke_constraint_handler_s(__func__, 0, EINVAL);
	return CONSTRAINT_VIOLATION;
    }

    /* Body */
   _lock_stream(F);
    ret = __vprintert( (putnF *)__fputnt, F, fmt, secure, 0, ap );
    _unlock_stream(F);

    if (ret == CONSTRAINT_VIOLATION)
	__invoke_constraint_handler_s(__func__, 0, EINVAL);
    return (ret);
}
