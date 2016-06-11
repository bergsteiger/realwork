/*-----------------------------------------------------------------------*
 * filename - llabs.c
 *
 * function(s)
 *        llabs - gives long long absolute value
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 2007, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 23293 $        */

#include <stdlib.h>

/*---------------------------------------------------------------------*

Name            llabs - gives long absolute value

Usage           long long labs(long long n);

Prototype in    stdlib.h

Description     calculates the absolute value of n, a long long integer.

Return value    the absolute value of n.

*---------------------------------------------------------------------*/

long long _RTLENTRY _EXPFUNC llabs(long long n)
{
    return(n < 0 ? -n : n);
}
