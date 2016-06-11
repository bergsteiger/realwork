/*-----------------------------------------------------------------------*
 * filename - sscanf_s.c
 *
 * function(s)
 *        Get       - gets a character from a string
 *        UnGet     - ungets a character from a string
 *        sscanf_s  - gets formatted input from a string
 *        vsscanf_s - gets formatted input from a string
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
#include <_scanf.h>
#include <_tchar.h>
#include <_secure.h>

/*---------------------------------------------------------------------*

Name            Get - gets a character from a string

Usage           static  int    Get(char **strPP)

Description     gets a character from a string

Return value    the character read or -1 of the null character

*---------------------------------------------------------------------*/

static _TINT Get(_TCHAR **strPP)
{
    register    _TUCHAR  c;

    return  ((c = *((*strPP) ++)) == _TEXT('\0')) ? _TEOF : c;
}


/*---------------------------------------------------------------------*

Name            UnGet - ungets a character from a string

Usage           static  void    UnGet(char c, char **strPP)

Description     decrements a character pointer

*---------------------------------------------------------------------*/

#pragma warn -par

static void UnGet(_TCHAR c, _TCHAR **strPP)
{
    --(*strPP);         /* ignore c, we don't allow the string to change */
}

#pragma warn .par

/*---------------------------------------------------------------------*

Name            sscanf - gets formatted input from a string

Usage           int sscanf(const char *string,
                    const char *format[, argument ...])

Prototype in    stdio.h

Description     gets formatted input from a string

Return value    number of fields scanned and stored.  sscanf returns EOF
        if an attempt is made to read at end-of-string

*---------------------------------------------------------------------*/

int _RTLENTRY _EXPFUNC _stscanf_s(const _TCHAR * _RESTRICT buf, const _TCHAR * _RESTRICT fmt, ...)
{
    va_list ap;
    int ret;
    errno_t err = 0;

    /* Constraints */
    if (!buf || !fmt)
	err = EINVAL;

    /* Body */
    if (!err)
    {
	va_start(ap,fmt);
	ret =  _scannert_s (
	    (GetF *)Get,
	    (UnGetF *)UnGet,
	    &buf,
	    fmt,
	    ap
	    );
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


/*---------------------------------------------------------------------*

Name        vsscanf - gets formatted input from a string

Usage       int vsscanf(const char *string,const char *format,
                va_list argp)

Prototype in    stdio.h

Description gets formatted input from a string

Return value    number of fields scanned and stored.  vsscanf returns EOF
        if an attempt is made to read at end-of-string

*---------------------------------------------------------------------*/

int _RTLENTRY _EXPFUNC _vstscanf_s(const _TCHAR *buf, const _TCHAR *fmt, va_list ap)
{
    int ret;
    errno_t err = 0;

    /* Constraints */
    if (!buf || !fmt)
	err = EINVAL;

    /* Body */
    if (!err)
    {
        ret = _scannert_s(
        (GetF *)Get,
        (UnGetF *)UnGet,
        &buf,
        fmt,
        ap
        );
	if (ret == CONSTRAINT_VIOLATION)
	    err = EINVAL;
    }

    if (err)
    {
	__invoke_constraint_handler_s(__func__, 0, err);
	return EOF;
    }
    return ret;
}
