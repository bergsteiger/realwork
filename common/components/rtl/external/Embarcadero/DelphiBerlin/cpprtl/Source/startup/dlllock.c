/*-----------------------------------------------------------------------*
 * filename - dlllock.c
 *
 * function(s)
 *
 *   __CRTL_DLL_Lock
 *   __CRTL_DLL_Unlock
 *
 *
 *   Both functions are called from the startup code.  Lock happens
 *   very early and Unlock happens very late.
 *
 *
 *   __CRTL_DLL_Lock()
 *
 *     locks the RTL (with a LoadLibrary) when the DLL being built
 *     (which is using this startup code) is linked to the RTLDLL's
 *     import library.  Else, the static RTL stubs out this call in
 *     dllstub.c.
 *
 *     This is needed for Windows95 since Win95 has problems
 *     unloading DLLs which have references to other DLLs that may
 *     be both implicitly and explicitly loaded.  WinNT handles
 *     this properly, and this extra locking shouldn't affect it.
 *
 *   __CRTL_DLL_Unlock()
 *
 *     Unlocks the RTL (with FreeLibrary)
 *
 *
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1998, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 35477 $        */

#include <windows.h>
#include <_defs.h>
#include <_io.h>

#ifndef __RTLDLLNAME
#error __RTLDLLNAME must be defined
#endif

#define quote(x) #x
#define str(x) quote(x)

static HINSTANCE hDLL;
static char    sRTLDLL [] = str(__RTLDLLNAME);

void _RTLENTRY __CRTL_DLL_Lock (void)
{
  hDLL = LoadLibrary (sRTLDLL);
  if ((int)hDLL == NULL)
    _ErrorExit("RTLDLL cannot find itself!");
}

void _RTLENTRY __CRTL_DLL_Unlock (void)
{
  if (hDLL)
  {
    FreeLibrary (hDLL);
    hDLL = (HINSTANCE) 0;
  }
}
