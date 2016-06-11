/*=============================================================================
 Level I Unwind API (Base ABI)
 http://www.codesourcery.com/public/cxx-abi/abi-eh.html

 (note: c++ is used in the implementation)
=============================================================================*/
#include <windows.h>
//#include <eh.h>
#include <assert.h>
#include <exception>        // for std::terminate
#include <setjmp.h>
#include "unwind_cpp_support.hpp"
#include "ms_api.hpp"
#include "cpp_unwind.hpp"

void __init_unwind_exception(_Unwind_Exception& x)
{
  x.exception_class = __clang_exception_class;
  x.exception_cleanup = &__cpp_unwind_exception_cleanup_fn;
}

#if defined(_WIN64)
extern "C" void back_trace();

extern "C" void DebugBreak();

_Unwind_Reason_Code _Unwind_RaiseException(
  _Unwind_Exception* exception_object)
{
//    back_trace();
//    DebugBreak();
  RaiseException(
    ms_api::clang_throw_code, 0, 1,
//    0x0EEFFACE, 0, 1,
    ms_api::as_exception_arg(exception_object));

  // RaiseException does not return, unless an error condition
  // is found (such as no handler for the exception, bad stack
  // format, etc.). In such a case, an _Unwind_Reason_Code value
  // is returned. Possibilities are:
  //
  //  _URC_END_OF_STACK: The unwinder encountered the end of the stack
  //  during phase 1, without finding a handler. The unwind runtime
  //  will not have modified the stack. The C++ runtime will normally
  //  call uncaught_exception() in this case.
  //
  //  _URC_FATAL_PHASE1_ERROR: The unwinder encountered an unexpected
  //  error during phase 1, e.g. stack corruption. The unwind runtime
  //  will not have modified the stack. The C++ runtime will normally
  //  call terminate() in this case.

  return _URC_END_OF_STACK;
}

void _Unwind_DeleteException(
  struct _Unwind_Exception* exception_object)
{
  exception_object->exception_cleanup(
    _URC_FOREIGN_EXCEPTION_CAUGHT, exception_object);
}

_EXPFUNC void _Unwind_Resume(struct _Unwind_Exception* exception_object)
{
  if (exception_object->private_1 == ms_api::clang_id)
  {
    // The MS exception_record is at the end of exception_object. Get it.
    ms_api::exception_record* er =
      (ms_api::exception_record*) (exception_object+1);
    if (ms_api::is_longjump_unwind(*er)) {
	/*
	  If we're here because we were cleaning up during an unwind for a
	  longjump, then we have to redo the longjump.  Just raising the exception
	  again will not have the desired effect.  Note that this will not work
	  properly if we've got here because MSVC code longjumped past our oode.
	 */
	longjmp(*(jmp_buf*)(void *)er->ExceptionInformation[0], (int)er->ExceptionInformation[1]);
    } else {
	RaiseException(
	    er->ExceptionCode,
	    er->ExceptionFlags,
	    er->NumberParameters,
	    er->ExceptionInformation);
    }
  }

  RaiseException(
    ms_api::clang_throw_code, 0, 1,
    ms_api::as_exception_arg(exception_object));
}

uint64 _Unwind_GetGR(
  struct _Unwind_Context* context, int index)
{
  switch (index)
  {
    case 0: return context->disp_ctx->ContextRecord->Rax;
    case 1: return context->disp_ctx->ContextRecord->Rcx;
    case 2: return context->disp_ctx->ContextRecord->Rdx;
    case 3: return context->disp_ctx->ContextRecord->Rbx;
    case 4: return context->disp_ctx->ContextRecord->Rsp;
    case 5: return context->disp_ctx->ContextRecord->Rbp;
    case 6: return context->disp_ctx->ContextRecord->Rsi;
    case 7: return context->disp_ctx->ContextRecord->Rdi;
    case 8: return context->disp_ctx->ContextRecord->R8;
    case 9: return context->disp_ctx->ContextRecord->R9;
    case 10: return context->disp_ctx->ContextRecord->R10;
    case 11: return context->disp_ctx->ContextRecord->R11;
    case 12: return context->disp_ctx->ContextRecord->R12;
    case 13: return context->disp_ctx->ContextRecord->R13;
    case 14: return context->disp_ctx->ContextRecord->R14;
    case 15: return context->disp_ctx->ContextRecord->R15;
    default: assert(false); std::terminate();
  }
}

void _Unwind_SetGR(
  struct _Unwind_Context* context,
  int index,
  uint64 new_value)
{
  switch (index)
  {
    case 0: context->disp_ctx->ContextRecord->Rax = new_value; break;
    case 1: context->disp_ctx->ContextRecord->Rcx = new_value; break;
    case 2: context->disp_ctx->ContextRecord->Rdx = new_value; break;
    case 3: context->disp_ctx->ContextRecord->Rbx = new_value; break;
    case 4: context->disp_ctx->ContextRecord->Rsp = new_value; break;
    case 5: context->disp_ctx->ContextRecord->Rbp = new_value; break;
    case 6: context->disp_ctx->ContextRecord->Rsi = new_value; break;
    case 7: context->disp_ctx->ContextRecord->Rdi = new_value; break;
    case 8: context->disp_ctx->ContextRecord->R8 = new_value; break;
    case 9: context->disp_ctx->ContextRecord->R9 = new_value; break;
    case 10: context->disp_ctx->ContextRecord->R10 = new_value; break;
    case 11: context->disp_ctx->ContextRecord->R11 = new_value; break;
    case 12: context->disp_ctx->ContextRecord->R12 = new_value; break;
    case 13: context->disp_ctx->ContextRecord->R13 = new_value; break;
    case 14: context->disp_ctx->ContextRecord->R14 = new_value; break;
    case 15: context->disp_ctx->ContextRecord->R15 = new_value; break;
    default: assert(false); std::terminate();
  }
}

uint64 _Unwind_GetIP(
  struct _Unwind_Context* context)
{
  return context->disp_ctx->ControlPc;
}

void _Unwind_SetIP(
  struct _Unwind_Context* context,
  uint64 new_value)
{
  context->disp_ctx->ControlPc = new_value;
}

uintptr_t _Unwind_GetLanguageSpecificData(
  struct _Unwind_Context* context)
{
  return (uint64)context->disp_ctx->HandlerData;
}

uint64 _Unwind_GetRegionStart(
  struct _Unwind_Context* context)
{
  return context->disp_ctx->FunctionEntry->BeginAddress
    + context->disp_ctx->ImageBase;
}

#endif // _WIN64
