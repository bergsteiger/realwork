/*-----------------------------------------------------------------------*
 * filename - vclshmem.cpp
 *
 * function(s)
 *
 *   __CRTL_VCL_Sharemem - redirect's the Pascal memory routines to point
 *                         to the routines in BORLNDMM.DLL.  This does the
 *                         same thing as sharemem.pas.  This function is
 *                         called from crtlvcl.cpp which is called very
 *                         early in the process from the startup code.
 *
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1997, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 34099 $        */

#include <_defs.h>
#include "delphimm.h"
#include "_hrdir.h"
#include "_io.h"

#if defined(_WIN64)
#pragma link "memmgr.a"  // Force BORLNDMM.DLL to get linked in
#else
#pragma link "memmgr.lib"  // Force BORLNDMM.DLL to get linked in
#endif

// The following is purposely mis-prototyped.  This is so that we can match
// the goofy naming convention of this Pascal compiled function.

extern "C" int __stdcall GetAllocMemCount(void);

extern "C" void _RTLENTRY __CRTL_VCL_Sharemem (void)
{
    void *gMem = 0, *fMem = 0, *rMem =0;
    void *aMem = 0, *regMem = 0, *unregMem =0;

    // Get the address of the 3 memory handler functions from BORLNDMM

    if (__CRTL_MEM_GetBorMemPtrs(&gMem, &fMem, &rMem,
				 &aMem, &regMem, &unregMem) == 0)
    {
        _ErrorExit (__FILE__ ": GetBorMemPtrs failed");
    }

    // Here we force the copy of System that is linked in (and this happens
    // in both the RTLDLL and the user's EXE), to redirect it's memory
    // requests into Borlndmm.dll

    __CRTL_VCL_HookSystem(gMem, fMem, rMem, aMem, regMem, unregMem);

    // The following function lives in BORLNDMM.DLL and calling it ensures that
    // the reference to its import library (memmgr.lib) is not smart linked
    // out by our illustrious linker.

    GetAllocMemCount();
}

