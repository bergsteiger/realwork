/*-----------------------------------------------------------------------*
 * filename - getdrive.c
 *
 * function(s)
 *        _getdrives - MSC compatible function
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1999, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 23293 $        */

#define INCL_USER
#include <ntbc.h>
#include <direct.h>

/* This function is a wrapper around the WinAPI GetLogicalDrives */

unsigned long _RTLENTRY _EXPFUNC _getdrives(void)
{
    return (GetLogicalDrives());
}
