/*-----------------------------------------------------------------------*
 * filename - crtlvcl.cpp
 *
 * function(s)
 *
 *   __CRTL_VCL_Init
 *   __CRTL_VCL_Exit
 *
 *
 *   Both functions are called from the startup code.  Init happens
 *   very early and Exit happens very late.
 *
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1997, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 35333 $        */

#if defined (_BUILDRTLDLL)
#undef _BUILDRTLDLL
#define _RTLDLL
#define _STATIC_IMPORT
#endif

#include <windows.h>
#include <process.h>
#include <_defs.h>
#include <_malloc.h>
#include <typeinfo.h>
#include <delayimp.h>
#define USE_XX_VARS
#define DELPHI_EXCEPTIONS
#include <xx.h>

#if defined(_STATIC_IMPORT)
#undef _STATIC_IMPORT
#undef _RTLDLL
#define _BUILDRTLDLL
#endif

#undef __CPPexceptionList
#define __CPPexceptionList (__getExceptVarRec()->xvrCPPexceptionList)

///////////////////////////////////////////////////////////////////////////

struct TRaiseFrame
{
    void * NextRaise;
    void * ExceptAddr;
    void * ExceptObject;
    void * ExceptionRecord;
};

#define PASCALIMPLEMENTATION __declspec(pascalimplementation, package) // Implemented in Delphi - no code should be generated
#define DELPHICLASS          __declspec(delphiclass, package)          // Implemented in Delphi (C++ does not generate RTTI)

namespace System
{
    extern __declspec(package) HINSTANCE MainInstance;
    extern __declspec(package) bool      IsMultiThread;
    typedef void * (__fastcall * TSystemThreadFuncProc)(void *, void *);
    extern __declspec(package) TSystemThreadFuncProc SystemThreadFuncProc;
    typedef void (__fastcall * TSystemThreadEndProc)(int);
    extern __declspec(package) TSystemThreadEndProc SystemThreadEndProc;
    extern __declspec(package) void * __fastcall RaiseList(void);
    extern __declspec(package) void * __fastcall SetRaiseList(void * NewPtr);
    extern __declspec(package) void * (__fastcall *ExceptObjProc)(_EXCEPTION_RECORD *);
    extern __declspec(package) void * RaiseExceptObjProc;
    extern __declspec(package) void * ExceptionAcquired;
    extern __declspec(package) void __fastcall Set8087CW(unsigned short);
    extern __declspec(package) void __fastcall Reset8087CW(void);
    extern __declspec(package) void __fastcall initialization (void);
    class DELPHICLASS TObject { };
};
namespace Sysinit
{
    extern __declspec(package) void * UnloadDelayLoadedDLLPtr;
    extern __declspec(package) void * DelayLoadHelper;
    extern __declspec(package) void * pfnDliNotifyHook;
    extern __declspec(package) void * pfnDliFailureHook;
	extern __declspec(package) void * HrLoadAllImportsForDll;
}
using namespace System;
using namespace Sysinit;

///////////////////////////////////////////////////////////////////////////

typedef void * (_RTLENTRY * TGetExceptionObjectProc)(_EXCEPTION_RECORD *, tpidPtr *typeID);
typedef void (__fastcall * TRaiseExceptObjProc)(_EXCEPTION_RECORD *);

extern int _RTLENTRY _EXPFUNC setRaiseListFuncAddr(void *setAddr, void *clearAddr);
extern int _RTLENTRY _EXPFUNC setExceptionFuncAddr(TGetExceptionObjectProc getExceptionObject, TRaiseExceptObjProc *raiseExceptObjProc);
extern exceptVarPtr _RTLENTRY _EXPFUNC __getExceptVarRec(void);

extern "C"
{

///////////////////////////////////////////////////////////////////////////

// These live in crtl_thd.c:

void _RTLENTRY _EXPFUNC __CRTL_VCL_Thread_Hook(void *pfunc, void *pend);
void _RTLENTRY _EXPFUNC __CRTL_VCL_Thread_Unhook(void *pfunc, void *pend);

///////////////////////////////////////////////////////////////////////////

void _RTLENTRY __CRTL_VCL_Sharemem (void);
extern unsigned char __isDLL;
extern unsigned char __isVCLPackage;

PEXCEPTION_RECORD _RTLENTRY __VCL_add_EH(PEXCEPTION_RECORD excPtr, void *);
void _RTLENTRY __VCL_clear_EH();
extern FARPROC WINAPI _EXPFUNC __delayLoadHelper2(ImgDelayDescr *pidd, FARPROC *ppfnIATEntry);
extern bool _RTLENTRY __VCL_init_except(void *RaiseListFunc, void *SetRaiseListFunc, void *ExceptObjProc);
extern void * _RTLENTRY __getExceptionObject(EXCEPTION_RECORD *P, tpidPtr *typeID);
extern void __fastcall __exceptionAcquired(TObject *e);

typedef void (__fastcall *Set8087)(unsigned short);
typedef void (__fastcall *Reset8087)(void);
extern void _RTLENTRY __CRTL_VCL_FPU_Hook(Set8087, Reset8087);
extern bool _RTLENTRY _EXPFUNC __VCL_init_fpu();

///////////////////////////////////////////////////////////////////////////
// VCL Initializtion / Finalization Functions                            //
///////////////////////////////////////////////////////////////////////////
static void * __fastcall GetExceptObj(_EXCEPTION_RECORD *p)
{
    if (System::ExceptObjProc)
	return System::ExceptObjProc(p);
    return 0;
}

extern void *_hInstance;
void _RTLENTRY __CRTL_VCL_Init (void)
{
    // We must set the VCL copy of hInstance (called MainInstance).
    // The startup code has placed this value into the EDX register for us.

    // Always set MainInstance in an EXE, and only set it in a DLL if it
    // hasn't been set.  Also, never set it in a PACKAGE.

    if (!__isVCLPackage)
        if ((!__isDLL) || (__isDLL && !System::MainInstance))
	    System::MainInstance = (HINSTANCE) _hInstance;


    // We must tell the Pascal RTL to enforce multithread issues in its
    // memory allocation routines, since we are in the multi-threaded RTL
    // on the C/C++ side.

    System::IsMultiThread = true;


#if 0 /* This won't be used in this update */
    // Callout to a function for Pascal thread hooking
    __CRTL_VCL_Thread_Hook(&System::SystemThreadFuncProc, &System::SystemThreadEndProc);
#endif

    // Now initialize the Pascal RTL
    System::initialization();

    // Redirect delay load routines
    Sysinit::DelayLoadHelper = (void *)&__delayLoadHelper2;
    Sysinit::UnloadDelayLoadedDLLPtr = (void *)&__FUnloadDelayLoadedDLL2;
	Sysinit::pfnDliNotifyHook = &__pfnDliNotifyHook2;
	Sysinit::pfnDliFailureHook = &__pfnDliFailureHook2;
	Sysinit::HrLoadAllImportsForDll = (void *)&__HrLoadAllImportsForDll;

#if !defined(__clang__) // FIXME
    // Exception handling hooks
    if (__VCL_init_except(System::RaiseList, System::SetRaiseList, GetExceptObj))
    {
	setRaiseListFuncAddr(__VCL_add_EH, __VCL_clear_EH);
	setExceptionFuncAddr(__getExceptionObject, (TRaiseExceptObjProc*)&System::RaiseExceptObjProc);
	System::ExceptionAcquired = &__exceptionAcquired;
    }
#endif

#if !defined(_WIN64)
    // Floating point control hooks
    if (__VCL_init_fpu())
    {
        __CRTL_VCL_FPU_Hook(System::Set8087CW, System::Reset8087CW);
    }
#endif

#if defined(_BUILDRTLDLL)
    __CRTL_VCL_Sharemem();
#endif
}

///////////////////////////////////////////////////////////////////////////

void _RTLENTRY __CRTL_VCL_Exit (void)
{
// This cannot be performed now, since it prematurely unloads the memory
// manager DLL.  If the RTLDLL is being used, the RTL cannot free its memory
// without jumping into the non-existant memory manager DLL.  Therefore SYSTEM
// is initialized but never finalized.

//  #if defined(_BUILDRTLDLL)
//    System::Finalization();
//  #endif

#if 0 /* This won't be used in this update */
    // Callout to a function for Pascal thread unhooking
    __CRTL_VCL_Thread_Unhook(&System::SystemThreadFuncProc, &System::SystemThreadEndProc);
#endif
}

//
// These functions start up and shut down VCL at the appropriate times.
//

void __stdcall __InitVCL(void);
void __stdcall __ExitVCL(void);

#pragma startup __InitVCL 28     // Initialization of early VCL routines.
                                 // Priority 28 is two eariler than what DCC32
                                 // uses for .PAS Units' Initialization
                                 // sections (which defaults to 30)

                                 // User's can now make a #29 priority startup
                                 // routine that will set IsLibrary = false
                                 // for statically linked DLLs that use VCL
                                 // Packages.

#pragma exit  __ExitVCL 31       // Finalization of VCL routines.
                                 // Priority 31 is one eariler than what DCC32
                                 // uses for .PAS Units' Finalization sections
                                 // (which defaults to 30)


///////////////////////////////////////////////////////////////////////////

} // extern "C"

///////////////////////////////////////////////////////////////////////////
