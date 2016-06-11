/*-----------------------------------------------------------------------*
 * filename - cvscanf.c
 *
 * function(s)
 *        cvscanf - performs formatted input from the console
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
#include <conio.h>
#include <stdio.h>
#include <_stdio.h>
#include <_scanf.h>

/*---------------------------------------------------------------------*

Name            cvscanf - performs formatted input from the console

Usage           int cvscanf(const char *format, va_list arglist);

Prototype in    conio.h

Description     see ...scanf

Return value    cvscanf  returns  the  number  of  input fields successfully
                scanned, converted  and stored. If cvscanf  attempts to read
                an end-of-file, the return value  is EOF. If no fields were
                stored, the return value is 0.

*---------------------------------------------------------------------*/

int _RTLENTRY _EXPFUNC cvscanf(const char *fmt, va_list arglist)
{
    int ret;

    ret = _scanner((GetF *)getche,
		   (UnGetF *)ungetch,
		   NULL,
		   fmt,
		   arglist);
    return ret;
}
