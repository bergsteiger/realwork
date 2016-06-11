/*-----------------------------------------------------------------------*
 * filename - usebormm.c (which makes usebormm.lib)
 *
 *   Include this lib file into your project to force the RTL
 *   (either static or dynamic) to use the "Borland" memory manager DLL.
 *   The hooking and usage of the memory DLL is done inside the RTL when
 *   the memory DLL is detected to be in memory already.
 *
 *   This lib will force the loader to load the DLL when the app starts
 *
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1998, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 34730 $        */

#include <_hrdir.h>

/* This function is a stub and will satisfy an external call
 * from the startup code.
 */

#pragma comment(lib, "memmgr")    /* Bring in the import lib for the DLL */

void _RTLENTRY _EXPFUNC __CRTL_MEM_UseBorMM (void)
{
    void __stdcall GetAllocMemCount (void); /* Proto for a function in the DLL */
    static void *p = GetAllocMemCount;  /* Force the linker to use it */
}

void _RTLENTRY _EXPFUNC __CRTL_MEM_PullInUseBorMMLib (void) /* Gets touched by usebormm.h */
{
}
