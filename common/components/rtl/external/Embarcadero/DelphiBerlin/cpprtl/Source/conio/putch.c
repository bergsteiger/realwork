/*-----------------------------------------------------------------------*
 * filename - putch.c
 *
 * function(s)
 *        putch - puts character on console
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1987, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 23293 $        */

#include <conio.h>
#include <_video.h>

/*---------------------------------------------------------------------*

Name            putch - puts character on console

Usage           int putch(int ch);

Prototype in    conio.h

Description     putch outputs the character ch to the console.

Return value    putch returns the character printed.

*---------------------------------------------------------------------*/

int _RTLENTRY _EXPFUNC putch(int c)
{
    char c1 = c;

    return __cputn((const void *)&c1,1,0);
}
