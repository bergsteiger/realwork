/*=============================================================================
 C++ EH Integration API
=============================================================================*/
#if !defined(CXXRUNTIME_UNWIND_CPP_SUPPORT_HPP)
#define CXXRUNTIME_UNWIND_CPP_SUPPORT_HPP

#include "../include/unwind.h"
#include "../include/cpp_unwind.hpp"

extern "C" uint64 const __clang_exception_class;
void __init_unwind_exception(_Unwind_Exception& x);

///////////////////////////////////////////////////////////////////////////////
// our own personality routine
extern "C" _Unwind_Reason_Code __seh_cxx_personality_v0(
  int version,
  _Unwind_Action actions,
  uint64 exceptionClass,
  struct _Unwind_Exception* exceptionObject,
  struct _Unwind_Context* context);

///////////////////////////////////////////////////////////////////////////////
// The callback that ends an SEH filter
extern "C" void __seh_end_filter(unsigned long result, _Unwind_Exception* p);

///////////////////////////////////////////////////////////////////////////////
void __cpp_unwind_exception_cleanup_fn(
    _Unwind_Reason_Code reason, struct _Unwind_Exception* exc);

///////////////////////////////////////////////////////////////////////////////
inline __cxa_exception* __to_cpp_exception(_Unwind_Exception* p)
{
  return (__cxa_exception*)
    (((char*)p)-offsetof(__cxa_exception, unwindHeader));
}

///////////////////////////////////////////////////////////////////////////////
__cxa_exception* __initialize_exception(
  void* thrown_exception,
  std::type_info* tinfo,
  void (*dest)(void*));

///////////////////////////////////////////////////////////////////////////////
extern "C" void __cpp_terminate();

#endif