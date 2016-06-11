/*-----------------------------------------------------------------------*
 * filename - fprintf_s.c
 *
 * function(s)
 *    fprintf_s - sends formatted output to a stream
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 2009, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision$        */

#include <stdio.h>
#include <_stdio.h>
#include <_printf.h>
#include <_tchar.h>
#include <_secure.h>

int _RTLENTRY _EXPFUNC _ftprintf_s(FILE * _RESTRICT F, const _TCHAR * _RESTRICT fmt, ...)
{
    va_list ap;
    int ret;

    /* Constraints */
    if (!F || !fmt)
    {
	__invoke_constraint_handler_s(__func__, 0, EINVAL);
	return CONSTRAINT_VIOLATION;
    }

    /* Body */
    va_start(ap,fmt);
    _lock_stream(F);
    ret =  __vprintert ((putnF *)__fputnt, F, fmt, secure, 0, ap);
    _unlock_stream(F);
    va_end(ap);

    if (ret == CONSTRAINT_VIOLATION)
	__invoke_constraint_handler_s(__func__, 0, EINVAL);
    return (ret);
}
