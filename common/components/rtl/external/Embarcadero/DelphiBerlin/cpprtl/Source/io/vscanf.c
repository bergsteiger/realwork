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

/* $Revision: 25311 $        */

#include <stdarg.h>
#include <stdio.h>
#include <_stdio.h>
#include <_scanf.h>
#include <_tchar.h>

#undef   ungetc     /* remove the macro version */

/*---------------------------------------------------------------------*

Name            vscanf - performs formatted input from stdin

Usage           int vscanf(const char *format, va_list param);

Prototype in    stdio.h

Description     see ...scanf

*---------------------------------------------------------------------*/

int _RTLENTRY _EXPFUNC _vtscanf (const _TCHAR *fmt, va_list ap)
{
    int ret;

    _lock_stream(stdin);
    ret = _scannert((GetF *)_fgettc,
                    (UnGetF *)_ungettc,
                    stdin,
                    fmt,
                    ap );
    _unlock_stream(stdin);
    return (ret);
}
