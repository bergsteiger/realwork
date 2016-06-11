/*-----------------------------------------------------------------------*
 * filename - sprintf_s.c
 *
 * function(s)
 *    strputn  - copies an n element string
 *    sprintf  - sends formatted output to a string
 *    vsprintf - sends formatted output to a string
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
#include <mem.h>
#include <string.h>
#include <_printf.h>
#include <_tchar.h>
#include <_secure.h>

/*---------------------------------------------------------------------*

Name            strputn - copies an n element string

Usage           static size_t strputn(char *S, size_t n, char **bufPP)

Description     copies n bytes from block pointed to by S to the block
                pointed to by bufPP.  bufPP is incremented by n.

Return value    0

*---------------------------------------------------------------------*/

static size_t strputn(_TCHAR *S, size_t n, _TCHAR **bufPP)
{
    memcpy (*bufPP, S, (n * sizeof (_TCHAR)));
    *(*bufPP += n) = _TEXT('\0');
    return n;
}


/*---------------------------------------------------------------------*

Name            sprintf_s - sends formatted output to a string

Usage           int sprintf_s(char *string, const char *format[, argument, ...]);

Prototype in    stdio.h

Description     sends formatted output to a string

Return value    number of bytes output

*---------------------------------------------------------------------*/

int _RTLENTRY _EXPFUNC _stprintf_s(_TCHAR * _RESTRICT bufP, rsize_t n,
				   const _TCHAR * _RESTRICT fmt, ...)
{
    va_list ap;
    int ret;
    errno_t err = 0;
    /* Save original since putter will increment */
    _TCHAR *origP = bufP;

    /* Constraints */
    if (n == 0 || n > RSIZE_MAX)
	err = ERANGE;
    else if (!bufP || !fmt)
	err = EINVAL;

    if (!err)
    {
	/* Body */
	*bufP = _TEXT('\0');
	va_start(ap,fmt);
	ret = __vprintert ((putnF *)strputn, &bufP, fmt, secure | use_nsize, n, ap);
	va_end(ap);

	if (ret == CONSTRAINT_VIOLATION)
	    err = EINVAL;
	else if (ret >= (int)n)
	    err = ERANGE;
    }
    if (err)
    {
	if (origP && n > 0 && n < RSIZE_MAX)
	    origP[0] = 0;
	__invoke_constraint_handler_s(__func__, 0, err);
	return 0;
    }
    return (ret);
}

/*---------------------------------------------------------------------*

Name            vsprintf - sends formatted output to a string

Usage           int vsprintf(char *string, const char *format, va_list param);

Prototype in    stdio.h

Description     sends formatted output to a string

Return value    number of bytes output

*---------------------------------------------------------------------*/

int _RTLENTRY _EXPFUNC _vstprintf_s(_TCHAR * _RESTRICT bufP, rsize_t n,
				    const _TCHAR * _RESTRICT fmt, va_list ap)
{
    int ret;
    errno_t err = 0;
    /* Save original since putter will increment */
    _TCHAR *origP = bufP;

    /* Constraints */
    if (n == 0 || n > RSIZE_MAX)
	err = ERANGE;
    else if (!bufP || !fmt)
	err = EINVAL;

    if (!err)
    {
	/* Body */
	*bufP = _TEXT('\0');
	ret = __vprintert ((putnF *)strputn, &bufP, fmt, secure | use_nsize, n, ap);
	if (ret == CONSTRAINT_VIOLATION)
	    err = EINVAL;
	else if (ret >= (int)n)
	    err = ERANGE;
    }
    if (err)
    {
	if (origP && n > 0 && n < RSIZE_MAX)
	    origP[0] = 0;
	__invoke_constraint_handler_s(__func__, 0, err);
	return 0;
    }
    return ret;
}
