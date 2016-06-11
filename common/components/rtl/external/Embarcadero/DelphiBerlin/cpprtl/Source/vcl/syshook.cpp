/*-----------------------------------------------------------------------*
 * filename - syshook.cpp
 *
 * function(s)
 *
 *   __CRTL_VCL_HookSystem
 *
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1998, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 33411 $        */

#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <_defs.h>
#include "_io.h"
#include "delphimm.h"
#include "_hrdir.h"

typedef System::Pointer __fastcall (*GetMemPtr)(System::NativeInt);
typedef             int __fastcall (*FreeMemPtr)(System::Pointer);
typedef System::Pointer __fastcall (*ReallocMemPtr)(System::Pointer, System::NativeInt);
typedef System::Pointer __fastcall (*AllocMemPtr)(System::NativeInt);
typedef bool __fastcall (*RegisterExpectedMemoryLeakPtr)(System::Pointer);
typedef bool __fastcall (*UnregisterExpectedMemoryLeakPtr)(System::Pointer);

extern "C" {

void _RTLENTRY __CRTL_VCL_HookSystem (void *gMem, void *fMem, void *rMem,
				      void *aMem, void *regMem, void *unregMem)
{
    if (!System::IsMemoryManagerSet())
    {
        System::TMemoryManagerEx mngr;
        mngr.GetMem = (GetMemPtr)         gMem;
        mngr.FreeMem = (FreeMemPtr)       fMem;
        mngr.ReallocMem = (ReallocMemPtr) rMem;
	mngr.AllocMem = (AllocMemPtr)	  aMem;
	mngr.RegisterExpectedMemoryLeak = (RegisterExpectedMemoryLeakPtr) regMem;
	mngr.UnregisterExpectedMemoryLeak = (UnregisterExpectedMemoryLeakPtr) unregMem;

        System::SetMemoryManager(mngr);
    }
}

} // "C"

