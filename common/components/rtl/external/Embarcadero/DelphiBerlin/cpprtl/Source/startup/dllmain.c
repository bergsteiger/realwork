/*-----------------------------------------------------------------------*
 * filename - DllMain.c
 *
 * function(s)
 *      DllMain     - default DLL user initialization
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1992, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */


#include <ntbc.h>

/*---------------------------------------------------------------------*

Name            DLLMain - default DLL user initialization

Usage           BOOL  WINAPI DllMain(HINSTANCE hInst,
                           DWORD ul_reason_being_called,
                           LPVOID lpReserved)

Prototype in    none

Description     DllMain is called by the default DllEntrypoint when a DLL
                is initialized, after all other RTL initialization is
                performed.  This is the default version, which is
                linked if the user does not provide one.

Return value    If it is successful, DllMain returns 1; if an error
                occurs, it returns 0.

*---------------------------------------------------------------------*/

#pragma argsused

extern int _libmain(unsigned long ul_reason_being_called);

BOOL  WINAPI DllMain(HINSTANCE hInst,
                           DWORD ul_reason_being_called,
                           LPVOID lpReserved)
{
    return _libmain(ul_reason_being_called);
}






