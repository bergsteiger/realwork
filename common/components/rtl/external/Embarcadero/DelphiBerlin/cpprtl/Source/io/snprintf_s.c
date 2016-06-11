/*-----------------------------------------------------------------------*
 * filename - snprntf.c
 *
 * function(s)
 *    strputn   - copies an n element string
 *    snprintf_s  - sends formatted output to a string
 *    vsnprintf_s - sends formatted output to a string
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

Usage           static size_t strputn(char *S, size_t n, char **bufPP,
                                      int eos_flag)

Description     copies n bytes from block pointed to by S to the block
                pointed to by bufPP.  bufPP is incremented by n.

Return value    returns the value n.

*---------------------------------------------------------------------*/

static size_t strputn(_TCHAR *S, size_t n, _TCHAR **bufPP, int eos_flag)
{
    memcpy (*bufPP, S, (n * sizeof (_TCHAR)));
    if (eos_flag)
        *(*bufPP += n) = _TEXT('\0');
    return n;
}


/*---------------------------------------------------------------------*

Name            snprintf - sends formatted output to a string

Usage           int snprintf(char *string, size_t nsize,
                             const char *format[, argument, ...]);

Prototype in    stdio.h

Description     sends formatted output to a string (of specified max length)

Return value    number of bytes output
                if return value < nsize, then all of the chars have been
                written (including the null char: eos).
                if return value == nsize, then nsize chars are written with no
                eos null char.
                if return value > nsize, then only nsize chars are written
                again, with no null eos.
                If nsize is 0, then the string will not be written to (and may
                be NULL)

*---------------------------------------------------------------------*/

int _RTLENTRY _EXPFUNC _sntprintf_s(_TCHAR *bufP, rsize_t nsize,
                                  const _TCHAR *fmt, ...)
{
    va_list ap;
    int ret;
    errno_t err = 0;
    /* Save original since putter will increment */
    _TCHAR *origP = bufP;

    /* Constraints */
    if (nsize == 0 || nsize > RSIZE_MAX)
	err = ERANGE;
    else if (!bufP || !fmt)
	err = EINVAL;

    if (!err)
    {
	*bufP = _TEXT('\0');

	va_start(ap,fmt);
	ret = __vprintert ((putnF *)strputn, &bufP, fmt, use_nsize | secure, nsize, ap);
	va_end(ap);

	if (ret == CONSTRAINT_VIOLATION)
	    err = EINVAL;
    }
    if (err)
    {
	if (origP && nsize > 0 && nsize < RSIZE_MAX)
	    origP[0] = 0;
	__invoke_constraint_handler_s(__func__, 0, err);
	return CONSTRAINT_VIOLATION;
    }

    return (ret);
}

/*---------------------------------------------------------------------*

Name            vsnprintf - sends formatted output to a string

Usage           int vsnprintf(char *string, size_t nsize, const char *format,
                              va_list param);

Prototype in    stdio.h

Description     sends formatted output to a string (of specified max length)

Return value    number of bytes output
                if return value < nsize, then all of the chars have been
                written (including the null char: eos).
                if return value == nsize, then nsize chars are written with no
                eos null char.
                if return value > nsize, then only nsize chars are written
                again, with no null eos.
                If nsize is 0, then the string will not be written to (and may
                be NULL)

*---------------------------------------------------------------------*/

int _RTLENTRY _EXPFUNC _vsntprintf_s(_TCHAR *bufP, rsize_t nsize,
				     const _TCHAR *fmt, va_list ap)
{
    int ret;
    errno_t err = 0;
    /* Save original since putter will increment */
    _TCHAR *origP = bufP;

    /* Constraints */
    if (nsize == 0 || nsize > RSIZE_MAX)
	err = ERANGE;
    else if (!bufP || !fmt)
	err = EINVAL;

    if (!err)
    {
	*bufP = _TEXT('\0');

	ret = __vprintert ((putnF *)strputn, &bufP, fmt, use_nsize | secure, nsize, ap);

	if (ret == CONSTRAINT_VIOLATION)
	    err = EINVAL;
    }
    if (err)
    {
	if (origP && nsize > 0 && nsize < RSIZE_MAX)
	    origP[0] = 0;
	__invoke_constraint_handler_s(__func__, 0, err);
	return CONSTRAINT_VIOLATION;
    }

    return ret;
}
