/*-----------------------------------------------------------------------*
 * filename - cvprintf.c
 *
 * function(s)
 *    cvprintf - send formatted output to the console
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1987, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 23293 $        */

#include <_printf.h>
#include <_video.h>
#include <conio.h>

/*---------------------------------------------------------------------*

Name            cvprintf - send formatted output to the console

Usage           int cvprintf(const char *format, va_list arglist);

Prototype in    conio.h

Description     see cprintf and printf

*---------------------------------------------------------------------*/

int _RTLENTRY _EXPFUNC cvprintf(const char *fmt, va_list arglist)
{
    return __vprinter((putnF *)__cputn, 0, fmt, 0, 0, arglist);
}
