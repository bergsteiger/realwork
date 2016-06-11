/*-----------------------------------------------------------------------*
 * filename - fiber.c
 *
 * function(s)
 *      GetFiberData
 *      GetCurrentFiber
 *
 * These functions were originally defined as inline in WINNT.H.  Since
 * we don't support inline functions in "C" (yet), we have moved them here
 *
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1996, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 28533 $        */

#include <ntbc.h>

PVOID _EXPFUNC GetFiberData( void )
{

    __emit__ (0x64, 0xA1, 0x10, 0, 0, 0); /* mov eax,fs:[0x10] */
    _EAX = *((DWORD *)_EAX);
    return (PVOID)_EAX;
}

PVOID _EXPFUNC GetCurrentFiber( void )
{
    __emit__ (0x64, 0xA1, 0x10, 0, 0, 0); /* mov eax,fs:[0x10] */
    return (PVOID)_EAX;
}
