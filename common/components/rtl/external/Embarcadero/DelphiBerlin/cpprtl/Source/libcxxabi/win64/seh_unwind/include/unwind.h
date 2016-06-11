/*=============================================================================
 Level I Unwind API (Base ABI)
 http://www.codesourcery.com/public/cxx-abi/abi-eh.html
=============================================================================*/
#if !defined(CXXRUNTIME_UNWIND_H)
#define CXXRUNTIME_UNWIND_H

#include <_defs.h>

#if defined(__cplusplus)
extern "C" {
#endif

/*-----------------------------------------------------------------------------
  _Unwind_Reason_Code [1.2]

  The unwind interface uses reason codes in several contexts to identify
  the reasons for failures or other actions, defined as follows
-----------------------------------------------------------------------------*/
typedef enum
{
  _URC_NO_REASON                = 0,
  _URC_FOREIGN_EXCEPTION_CAUGHT = 1,
  _URC_FATAL_PHASE2_ERROR       = 2,
  _URC_FATAL_PHASE1_ERROR       = 3,
  _URC_NORMAL_STOP              = 4,
  _URC_END_OF_STACK             = 5,
  _URC_HANDLER_FOUND            = 6,
  _URC_INSTALL_CONTEXT          = 7,
  _URC_CONTINUE_UNWIND          = 8,
  _URC_RESUME_EXECUTION         = 9 // $$$ JDG: non-standard $$$
} _Unwind_Reason_Code;

typedef unsigned long long uint64;

#ifdef _WIN64
typedef unsigned long long uintptr_t;
#else
typedef unsigned int uintptr_t;
#endif

/* Forward declarations */
struct _Unwind_Exception;
struct _Unwind_Context;

/*-----------------------------------------------------------------------------
  _Unwind_Action [1.6.2]

  The actions argument to the personality routine is a bitwise OR of one
  or more of the following constants:
-----------------------------------------------------------------------------*/
  typedef int _Unwind_Action;
  static const _Unwind_Action _UA_SEARCH_PHASE  = 1;
  static const _Unwind_Action _UA_CLEANUP_PHASE = 2;
  static const _Unwind_Action _UA_HANDLER_FRAME = 4;
  static const _Unwind_Action _UA_FORCE_UNWIND  = 8;

/*-----------------------------------------------------------------------------
  _Unwind_Exception_Cleanup_Fn [1.2]

  The exception_cleanup routine is called whenever an exception object
  needs to be destroyed by a different runtime than the runtime which
  created the exception object, for instance if a Java exception is caught
  by a C++ catch handler.
-----------------------------------------------------------------------------*/
typedef void (*_Unwind_Exception_Cleanup_Fn)(
  _Unwind_Reason_Code reason, struct _Unwind_Exception *exc);

/*-----------------------------------------------------------------------------
  _Unwind_Exception [1.2]

  The unwind interface uses a pointer to an exception header object as
  its representation of an exception being thrown. In general, the full
  representation of an exception object is language- and implementation-
  specific.
-----------------------------------------------------------------------------*/
struct _Unwind_Exception
{
  uint64 exception_class;
  _Unwind_Exception_Cleanup_Fn exception_cleanup;
  uintptr_t private_1;
  uintptr_t private_2;
};

/*-----------------------------------------------------------------------------
  _Unwind_RaiseException [1.3]

  Raise an exception, passing along the given exception object, which
  should have its exception_class and exception_cleanup fields set.
  The exception object has been allocated by the language-specific runtime,
  and has a language-specific format.
-----------------------------------------------------------------------------*/
_Unwind_Reason_Code _Unwind_RaiseException(
  struct _Unwind_Exception* exception_object);

/*-----------------------------------------------------------------------------
  _Unwind_DeleteException [1.4]

  Deletes the given exception object. If a given runtime resumes normal
  execution after catching a foreign exception, it will not know how to
  delete that exception. Such an exception will be deleted by calling
  _Unwind_DeleteException. This is a convenience function that calls the
  function pointed to by the exception_cleanup field of the exception header.
-----------------------------------------------------------------------------*/
void _Unwind_DeleteException(
  struct _Unwind_Exception* exception_object);

/*-----------------------------------------------------------------------------
  _Unwind_Stop_Fn [1.3]

  The stop function parameter is called for each unwind frame, with the
  parameters described for the usual personality routine below, plus an
  additional stop_parameter.
-----------------------------------------------------------------------------*/
typedef _Unwind_Reason_Code(*_Unwind_Stop_Fn)(
  int version,
  _Unwind_Action actions,
  uint64 exceptionClass,
  struct _Unwind_Exception* exceptionObject,
  struct _Unwind_Context* context,
  void* stop_parameter);

/*-----------------------------------------------------------------------------
  _Unwind_ForcedUnwind [1.3]

  Raise an exception for forced unwinding, passing along the given
  exception object, which should have its exception_class and
  exception_cleanup fields set. The exception object has been allocated
  by the language-specific runtime, and has a language-specific format.
-----------------------------------------------------------------------------*/
_Unwind_Reason_Code _Unwind_ForcedUnwind(
  struct _Unwind_Exception* exception_object,
  _Unwind_Stop_Fn stop,
  void* stop_parameter);

/*-----------------------------------------------------------------------------
  _Unwind_Resume [1.3]

  Resume propagation of an existing exception e.g. after executing
  cleanup code in a partially unwound stack. A call to this routine
  is inserted at the end of a landing pad that performed cleanup,
  but did not resume normal execution. It causes unwinding to proceed
  further.
-----------------------------------------------------------------------------*/
_EXPFUNC void _Unwind_Resume(struct _Unwind_Exception* exception_object);

/*-----------------------------------------------------------------------------
  Context management [1.5]:

  _Unwind_GetGR
  _Unwind_SetGR
  _Unwind_GetIP
  _Unwind_SetIP
  _Unwind_GetLanguageSpecificData
  _Unwind_GetRegionStart

  These functions are used for communicating information about the unwind
  context (i.e. the unwind descriptors and the user register state) between
  the unwind library and the personality routine and landing pad. They
  include routines to read or set the context record images of registers
  in the stack frame corresponding to a given unwind context, and to
  identify the location of the current unwind descriptors and unwind frame.
-----------------------------------------------------------------------------*/
uintptr_t _Unwind_GetGR(
  struct _Unwind_Context* context, int index);

void _Unwind_SetGR(
  struct _Unwind_Context* context,
  int index,
  uintptr_t new_value);

uintptr_t _Unwind_GetIP(
  struct _Unwind_Context* context);

void _Unwind_SetIP(
  struct _Unwind_Context* context,
  uintptr_t new_value);

uintptr_t _Unwind_GetLanguageSpecificData(
  struct _Unwind_Context* context);

uintptr_t _Unwind_GetRegionStart(
  struct _Unwind_Context* context);

#if defined(__WIN32__)
    uintptr_t _Unwind_GetCFA(struct _Unwind_Context* context);
#endif

/*-----------------------------------------------------------------------------
  __personality_routine [1.6]:

  The personality routine is the function in the C++ (or other language)
  runtime library which serves as an interface between the system unwind
  library and language-specific exception handling semantics. It is specific
  to the code fragment described by an unwind info block, and it is always
  referenced via the pointer in the unwind info block.
-----------------------------------------------------------------------------*/
typedef _Unwind_Reason_Code(*__personality_routine_f)(
  int version,
  _Unwind_Action actions,
  uint64 exceptionClass,
  struct _Unwind_Exception* exceptionObject,
  struct _Unwind_Context* context);

#if defined(__cplusplus)
};
#endif

#endif
