/*=============================================================================
 Level II Unwind API (C++ ABI)
 http://www.codesourcery.com/public/cxx-abi/abi-eh.html#cxx-abi
=============================================================================*/
#if !defined(CXXRUNTIME_CPP_UNWIND_H)
#define CXXRUNTIME_CPP_UNWIND_H

#include "unwind.h"
#include "../src/ms_api.hpp"

#if !defined(__clang_version__) // for MSVC
#include <typeinfo>
#endif

#if defined(__cplusplus)
extern "C" {
#endif

namespace std
{
#if defined(__clang_version__)
  class type_info; // forward declaration
#endif

  typedef void (*unexpected_handler)();
  typedef void (*terminate_handler)();
}

uint64 const __clang_exception_class =
    uint64('c') << 56
  | uint64('l') << 48
  | uint64('n') << 40
  | uint64('g') << 32
  | uint64('c') << 24
  | uint64('+') << 16
  | uint64('+') << 8
  ;

uint64 const __clang_dependent_exception_class =
    uint64('c') << 56
  | uint64('l') << 48
  | uint64('n') << 40
  | uint64('g') << 32
  | uint64('c') << 24
  | uint64('+') << 16
  | uint64('+') << 8
  | uint64(1);
  ;

uint64 const __clang_vendor_and_language = 
    uint64(0xf) << 56
  | uint64(0xf) << 48
  | uint64(0xf) << 40
  | uint64(0xf) << 32
  | uint64(0xf) << 24
  | uint64(0xf) << 16
  | uint64(0xf) << 8
  ;

struct __cxa_dependent_exception;

/*-----------------------------------------------------------------------------
  __cxa_exception [2.2.1]

  A complete C++ exception object consists of a header, which is a
  wrapper around an unwind object header with additional C++ specific
  information, followed by the thrown C++ exception object itself.
-----------------------------------------------------------------------------*/
struct __cxa_exception
{
#if __LP64__
    // This is a new field to support C++ 0x exception_ptr.
    // For binary compatibility it is at the start of this
    // struct which is prepended to the object thrown in
    // __cxa_allocate_exception.
        size_t referenceCount;
#endif
  std::type_info* exceptionType;
  void (*exceptionDestructor) (void *);

  std::unexpected_handler unexpectedHandler;
  std::terminate_handler terminateHandler;
  __cxa_exception* nextException;

  int handlerCount;
  int handlerSwitchValue;
  const char* actionRecord;
  const char* languageSpecificData;
  void* catchTemp;
  void* adjustedPtr;
  void *adjusted_thrown_object;

#if !__LP64__
    // This is a new field to support C++ 0x exception_ptr.
    // For binary compatibility it is placed where the compiler
    // previously adding padded to 64-bit align unwindHeader.
        size_t referenceCount;
#endif

  _Unwind_Exception unwindHeader;
    void *thrown_object_from_exception();
};

// http://sourcery.mentor.com/archives/cxx-abi-dev/msg01924.html
    
    struct __cxa_dependent_exception {
#if __LP64__
        void* primaryException;
#endif
    
        std::type_info *exceptionType;
        void (*exceptionDestructor)(void *); 
        std::unexpected_handler unexpectedHandler;
        std::terminate_handler terminateHandler;
    
        __cxa_exception *nextException;
    
        int handlerCount;
    
#ifdef __ARM_EABI_UNWINDER__
        __cxa_exception* nextPropagatingException;
        int propagationCount;
#else
        int handlerSwitchValue;
        const unsigned char *actionRecord;
        const unsigned char *languageSpecificData;
        void * catchTemp;
        void *adjustedPtr;
	void *adjusted_thrown_object;
#endif
    
#if !__LP64__
        void* primaryException;
#endif
    
        _Unwind_Exception unwindHeader;
        };

    inline void* __cxa_exception::thrown_object_from_exception() {
	void *obj = (void *)(this + 1);
	if (unwindHeader.exception_class == __clang_dependent_exception_class)
	    return ((__cxa_dependent_exception *)obj - 1)->primaryException;
	return obj;
    }
/*-----------------------------------------------------------------------------
  __cxa_allocate_exception [2.4.2]

  Memory will be allocated by the __cxa_allocate_exception runtime
  library routine. This routine is passed the size of the exception object
  to be thrown (not including the size of the __cxa_exception header), and
  returns a pointer to the temporary space for the exception object.
-----------------------------------------------------------------------------*/
void* __cxa_allocate_exception(uint64 thrown_size);

/*-----------------------------------------------------------------------------
  __cxa_free_exception [2.4.2]

  The temporary space will be freed by __cxa_free_exception, which is
  passed the address returned by the previous __cxa_allocate_exception.
-----------------------------------------------------------------------------*/
void __cxa_free_exception(void* thrown_exception);

/*-----------------------------------------------------------------------------
  __cxa_throw [2.4.3]

  After constructing the exception object with the throw argument value,
  the generated code calls the __cxa_throw runtime library routine.
  This routine never returns.
-----------------------------------------------------------------------------*/
void __cxa_throw(
  void* thrown_exception,
  std::type_info* tinfo,
  void (*dest)(void*));

/*-----------------------------------------------------------------------------
  __cxa_eh_globals [2.2.2]

  Each thread in a C++ program has access to an object of the following class.
-----------------------------------------------------------------------------*/
  struct __cxa_eh_globals
  {
    __cxa_exception* caughtExceptions;
    unsigned int uncaughtExceptions;
  };

/*-----------------------------------------------------------------------------
  __cxa_get_globals [2.2.2]

  Return a pointer to the __cxa_eh_globals structure for the current thread,
  initializing it if necessary.
-----------------------------------------------------------------------------*/
__cxa_eh_globals* __cxa_get_globals();

/*-----------------------------------------------------------------------------
  __cxa_get_globals_fast [2.2.2]

  Return a pointer to the __cxa_eh_globals structure for the current thread,
  assuming that at least one prior call to __cxa_get_globals has been made
  from the current thread.
-----------------------------------------------------------------------------*/
__cxa_eh_globals* __cxa_get_globals_fast();

/*-----------------------------------------------------------------------------
  __cxa_get_exception_ptr [2.5.3]

  Upon entry, a handler must call __cxa_get_exception_ptr.
-----------------------------------------------------------------------------*/

void* __cxa_get_exception_ptr(void* exceptionObject);

/*-----------------------------------------------------------------------------
  __cxa_begin_catch [2.5.3]

  __cxa_begin_catch returns the adjusted pointer to the exception object.
  (The adjusted pointer is typically computed by the personality routine
  during phase 1 and saved in the exception object.)
-----------------------------------------------------------------------------*/
void* __cxa_begin_catch(void* exceptionObject);

/*-----------------------------------------------------------------------------
  __cxa_end_catch [2.5.3]

  Upon exit for any reason, a handler must call __cxa_end_catch.
-----------------------------------------------------------------------------*/
void __cxa_end_catch();

/*-----------------------------------------------------------------------------
  __cxa_rethrow [2.5.4]

  This routine marks the exception object on top of the caughtExceptions
  stack (in an implementation-defined way) as being rethrown. If the
  caughtExceptions stack is empty, it calls terminate(). It then returns
  to the handler that called it, which must call __cxa_end_catch(), perform
  any necessary cleanup, and finally call _Unwind_Resume() to continue
  unwinding.
-----------------------------------------------------------------------------*/
void __cxa_rethrow();

void * __cxa_allocate_dependent_exception ();
void __cxa_free_dependent_exception (void * dependent_exception);

void __invoke_filter_function(uintptr_t rbp, _Unwind_Exception *exception,
			      uintptr_t targetPC);

void __seh_restore_context(ms_api::dispatcher_context *ctx, int ret_val);
void __seh_capture_context(ms_api::dispatcher_context *ctx);

#if defined(__cplusplus)
};
#endif

#endif
