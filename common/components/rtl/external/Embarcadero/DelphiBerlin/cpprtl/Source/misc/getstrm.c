/*-----------------------------------------------------------------------*
 * filename - getstrm.c
 *
 * function(s)
 *        __getStream -
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 23293 $        */

#include <_io.h>
#include <stdio.h>

/* This function is provided for CodeGuard(tm) support only */

FILE * _RTLENTRY _EXPFUNC __getStream( int strm )
{
    return &(_streams[strm]);
}

