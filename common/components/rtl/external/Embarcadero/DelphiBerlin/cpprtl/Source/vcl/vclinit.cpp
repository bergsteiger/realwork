/* 
   Module to handle interface with Delphi RTL.  It resides in the RTLDLL 
   and cannot directly reference Delphi symbols (called by crtlvcl.cpp) 
*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 2010, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 28857 $        */

#include <windows.h>
#include <process.h>
#include <_defs.h>
#include <_malloc.h>
#include <typeinfo.h>
#define USE_XX_VARS
#define DELPHI_EXCEPTIONS
#include <xx.h>

#if defined(_WIN64)
#define MALLOC malloc
#define FREE free
#else
#define MALLOC __org_malloc
#define FREE __org_free
#endif

extern exceptVarPtr _RTLENTRY _EXPFUNC __getExceptVarRec(void);

#undef __CPPexceptionList
#define __CPPexceptionList (__getExceptVarRec()->xvrCPPexceptionList)

#define PASCALIMPLEMENTATION __declspec(pascalimplementation, package) // Implemented in Delphi - no code should be generated
#define DELPHICLASS          __declspec(delphiclass, package)          // Implemented in Delphi (C++ does not generate RTTI)

struct TRaiseFrame
{
    void * NextRaise;
    void * ExceptAddr;
    void * ExceptObject;
    void * ExceptionRecord;
};

/*
  This code is drawn primarily from the Delphi system unit for exception
  handling.  The behaviour is intended to parallel that of Delphi.
*/
static unsigned char mapException(EXCEPTION_RECORD *P)
{
    switch  (P->ExceptionCode)
    {
    case    STATUS_INTEGER_DIVIDE_BY_ZERO:  return 3;
    case    STATUS_ARRAY_BOUNDS_EXCEEDED:   return 4;
    case    STATUS_INTEGER_OVERFLOW:        return 5;

    case    STATUS_FLOAT_INEXACT_RESULT:
    case    STATUS_FLOAT_INVALID_OPERATION:
    case    STATUS_FLOAT_STACK_CHECK:       return 6;

    case    STATUS_FLOAT_DIVIDE_BY_ZERO:    return 7;
    case    STATUS_FLOAT_OVERFLOW:          return 8;

    case    STATUS_FLOAT_UNDERFLOW:
    case    STATUS_FLOAT_DENORMAL_OPERAND:  return 9;

    case    STATUS_ACCESS_VIOLATION:        return 11;
    case    STATUS_PRIVILEGED_INSTRUCTION:  return 12;
    case    STATUS_CONTROL_C_EXIT:          return 13;
    case    STATUS_STACK_OVERFLOW:          return 14;
    default:                                return 21;
    }
}

typedef struct  OSExceptionTypeID
{
    tpidPtr OSETid;
    unsigned char OSETexceptionNum;
} OSExceptionTypeID;

namespace System
{
#pragma pack(push,4)
#if !defined(__clang__)
    class DELPHICLASS TObject { void *vmt; };
#else
    class DELPHICLASS TObject { public: virtual ~TObject(){} };
#endif
    __declspec(package) void __fastcall Set8087CW(unsigned);
    __declspec(package) void __fastcall Reset8087CW(void);

    namespace Sysutils
    {
	class DELPHICLASS Exception;
	class PASCALIMPLEMENTATION Exception : public System::TObject 
	{ 
	    void *FMessage;
	    int   FHelpContext;
	    void *FInnerException;
	    void *FStackInfo;
	    bool  FAcquireInnerException;
	};
	class DELPHICLASS EExternal;
	class PASCALIMPLEMENTATION EExternal : public Exception { void *platform; };
	class DELPHICLASS EIntError;
	class PASCALIMPLEMENTATION EIntError : public EExternal { };
	class DELPHICLASS EDivByZero;
	class PASCALIMPLEMENTATION EDivByZero : public EIntError { };
	class DELPHICLASS ERangeError;
	class PASCALIMPLEMENTATION ERangeError : public EIntError { };
	class DELPHICLASS EIntOverflow;
	class PASCALIMPLEMENTATION EIntOverflow : public EIntError { };
	class DELPHICLASS EMathError;
	class PASCALIMPLEMENTATION EMathError : public EExternal { };
	class DELPHICLASS EInvalidOp;
	class PASCALIMPLEMENTATION EInvalidOp: public EMathError { };
	class DELPHICLASS EZeroDivide;
	class PASCALIMPLEMENTATION EZeroDivide: public EMathError { };
	class DELPHICLASS EOverflow;
	class PASCALIMPLEMENTATION EOverflow: public EMathError { };
	class DELPHICLASS EUnderflow;
	class PASCALIMPLEMENTATION EUnderflow: public EMathError { };
	class DELPHICLASS EAccessViolation;
	class PASCALIMPLEMENTATION EAccessViolation : public EExternal { };
	class DELPHICLASS EPrivilege;
	class PASCALIMPLEMENTATION EPrivilege : public EExternal { };
	class DELPHICLASS EStackOverflow;
	class PASCALIMPLEMENTATION EStackOverflow : public EExternal { };
	class DELPHICLASS EControlC;
	class PASCALIMPLEMENTATION EControlC : public EExternal { };
    };
#pragma pack(pop)
}

using namespace System;
using namespace System::Sysutils;

#if !defined(__clang__) // FIXME: no exception support
static  OSExceptionTypeID  OSExceptionTypeIDs[] =
{
    { 0,                                    0 },
    { 0,                                    1 },
    { 0,                                    2 },
    { typeid(EDivByZero       &).tpp,       3 },
    { typeid(ERangeError      &).tpp,       4 },
    { typeid(EIntOverflow     &).tpp,       5 },
    { typeid(EInvalidOp       &).tpp,       6 },
    { typeid(EZeroDivide      &).tpp,       7 },
    { typeid(EOverflow        &).tpp,       8 },
    { typeid(EUnderflow       &).tpp,       9 },
//  { typeid(EInvalidCast     *).tpp,       10 },
    { 0,                                    10 },
    { typeid(EAccessViolation &).tpp,       11 },
    { typeid(EPrivilege       &).tpp,       12 },
    { typeid(EControlC        &).tpp,       13 },
    { typeid(EStackOverflow   &).tpp,       14 },
};
#endif

#if defined(__clang__)
typedef void * __declspec(package) (* __fastcall RaiseListFuncType)(void);
typedef void * __declspec(package) (* __fastcall SetRaiseListFuncType)(void *);
#else
typedef void * (__declspec(package) __fastcall * RaiseListFuncType)(void);
typedef void * (__declspec(package) __fastcall * SetRaiseListFuncType)(void *);
#endif

typedef void * (_RTLENTRY * TGetExceptionObjectProc)(_EXCEPTION_RECORD *, tpidPtr *typeID);
typedef void (__fastcall * TRaiseExceptObjProc)(_EXCEPTION_RECORD *);
typedef void * (__fastcall * TExceptObjProcType)(_EXCEPTION_RECORD *);


static RaiseListFuncType RaiseListFunc;
static SetRaiseListFuncType SetRaiseListFunc;
static TExceptObjProcType ExceptObjProc;
static bool fpu_inited = false;

extern "C" 
{

bool _RTLENTRY _EXPFUNC __VCL_init_fpu()
{
    if (fpu_inited)
	return false;

    fpu_inited = true;
    return true;
}

#if !defined(__clang__) && !defined(_NO_EX) // FIXME: no exception support

// Allocate memory for a Pascal exception and add it to RaiseList.
// This function is called from ___ExceptionHandler() while processing
// a Pascal exception code.

bool _RTLENTRY _EXPFUNC __VCL_init_except(void *RaiseListPtr, void *SetRaiseListPtr, void *TExceptObjProcPtr)
{
    if (!RaiseListFunc)
    {
	RaiseListFunc = (RaiseListFuncType) RaiseListPtr;
	SetRaiseListFunc = (SetRaiseListFuncType) SetRaiseListPtr;
	ExceptObjProc = (TExceptObjProcType) TExceptObjProcPtr;
	return true;
    }
    return false;
}

PEXCEPTION_RECORD _RTLENTRY _EXPFUNC __VCL_add_EH(PEXCEPTION_RECORD excPtr, void * obj)
{
    struct TRaiseFrame *myTRFrame;
    struct TRaiseFrame *curTRFrame = (TRaiseFrame *)RaiseListFunc();
    if (excPtr)
    {
	myTRFrame = (TRaiseFrame *) MALLOC(sizeof(TRaiseFrame));
	myTRFrame->ExceptAddr = excPtr->ExceptionAddress;
	myTRFrame->ExceptionRecord = excPtr;
	myTRFrame->ExceptObject = obj;
	myTRFrame->NextRaise = curTRFrame;
	SetRaiseListFunc(myTRFrame);
    }
    Exception *e = new EOverflow();
    return curTRFrame ? (PEXCEPTION_RECORD)curTRFrame->ExceptionRecord : 0;
}

// Remove the top exception object from RaiseList and deallocate it's memory.
// This function is called from _CatchCleanup() which verifies that this is
// a Pascal exception.

void _RTLENTRY _EXPFUNC __VCL_clear_EH()
{
    struct TRaiseFrame *myTRFrame = (TRaiseFrame *)RaiseListFunc();

    if (myTRFrame)
    {
        SetRaiseListFunc(myTRFrame->NextRaise);
        FREE((void*)myTRFrame);
    }
}


void * _RTLENTRY _EXPFUNC __getExceptionObject(EXCEPTION_RECORD *P, tpidPtr *typeID)
{
    unsigned        ErrorCode;
    TObject *       excObj;

    ErrorCode = mapException(P);

    if (ErrorCode < 3 || ErrorCode > sizeof(OSExceptionTypeIDs) / sizeof(OSExceptionTypeIDs[0]))
	return 0;

    *typeID = OSExceptionTypeIDs[ErrorCode].OSETid;

    if (ExceptObjProc)
	excObj = (TObject*)ExceptObjProc(P);
    else
	excObj = NULL;

    return excObj;
}

void __fastcall _EXPFUNC __exceptionAcquired(TObject *e)
{
    if (e)
    {
	excDscPtr exc = __CPPexceptionList;
	while (exc)
	{
	    if ((exc->xdFlags & (XDF_ISDELPHIEXCEPTION|XDF_OSEXCEPTION)) && (*(TObject **)exc->xdValue == e))
	    {
		*(void **)exc->xdValue = NULL;
	    }
	    exc = exc->xdPrevious;
	}
    }
}

#endif // __clang__

} // extern "C"
