/*=============================================================================
 Level II Unwind API (C++ ABI)
 http://www.codesourcery.com/public/cxx-abi/abi-eh.html

 (note: c++ is used in the implementation)
=============================================================================*/
#include <stddef.h> // for offsetof
#include <assert.h>
#include <cstdlib>          // for malloc, free
#include <exception>        // for std::terminate
#include <string>           // for memset

#include <stdio.h>

//#include <_stddef.h> // for offsetof
#include "unwind_cpp_support.hpp"
#include "../include/cpp_unwind.hpp"
#include "../include/debugger.h"
//#include <stddef.h> // for offsetof
#include "fallback_malloc.hpp"
#include "delphi_support.h"
#include "ms_api.hpp"

// workaround for compiler issue - commandline -DFoo= doesn't behave right?
#define NO_THREAD_LOCAL

extern "C" void DebugBreak();
namespace
{
  //  Allocate some memory from _somewhere_
  void* do_malloc(uint64 size) throw()
  {
    void* ptr = std::malloc(size);
    if (0 == ptr) // if malloc fails, fall back to emergency stash
      ptr = __cxx_runtime::detail::fallback_malloc(size);
    return ptr;
  }

  void* thrown_object_from_exception(void* p) throw()
  {
    return (void*) (((__cxa_exception*) p) + 1);
  }

  __cxa_exception* exception_from_thrown_object(void* p)
  {
    return ((__cxa_exception*) p) - 1;
  }

  uint64 object_size_from_exception_size(uint64 size) throw()
  {
    return size + sizeof(__cxa_exception);
  }

    static void setExceptionClass(_Unwind_Exception* unwind_exception) {
	unwind_exception->exception_class = __clang_exception_class;
    }
    
    static void setDependentExceptionClass(_Unwind_Exception* unwind_exception) {
	unwind_exception->exception_class = __clang_dependent_exception_class;
    }
    
//  Is it one of ours?
    static bool isOurExceptionClass(const _Unwind_Exception* unwind_exception) {
	return (unwind_exception->exception_class & __clang_vendor_and_language) == 
	    (__clang_exception_class           & __clang_vendor_and_language);
    }
    
    static bool isDependentException(const _Unwind_Exception* unwind_exception) {
	return (unwind_exception->exception_class & 0xFF) == 0x01;
    }
    
  static thread_local __cxa_eh_globals eh_globals;
  __cxa_eh_globals* __globals()
  {
    // TLS __declspec(thread) is MSVC specific
      /*
	Used to have this as a local static, but it ran into a compiler bug.  The
	compiler bug has been fixed, but just as a workaround, we moved it out to a
	file static.
       */
//    static thread_local __cxa_eh_globals eh_globals;
    return &eh_globals;
  }

  void do_free(void *ptr)
  {
    if (__cxx_runtime::detail::is_fallback_ptr(ptr))
      return __cxx_runtime::detail::fallback_free(ptr);
    else
      return std::free(ptr);
  }

  void failed_throw(__cxa_exception* exception)
  {
    __cxa_begin_catch(&exception->unwindHeader);
    std::terminate();
  }

  // TODO: This needs to be atomic
  int incrementHandlerCount(__cxa_exception* exception)
  {
    return ++exception->handlerCount;
  }

  // TODO: This needs to be atomic
  int decrementHandlerCount(__cxa_exception* exception)
  {
    return --exception->handlerCount;
  }

  void cleanup(__cxa_exception* exception)
  {
//      DebugBreak();
    void* thrown_object = thrown_object_from_exception(exception);
    if (0 != exception->exceptionDestructor)
        exception->exceptionDestructor(thrown_object);
    __cxa_free_exception(thrown_object);
  }
}


_EXPFUNC void __cpp_terminate()
{
  std::terminate();
}

/*
    If thrown_object is not null, atomically increment the referenceCount field
    of the __cxa_exception header associated with the thrown object referred to
    by thrown_object.

    Requires:  If thrown_object is not NULL, it is a native exception.
*/
void
__cxa_increment_exception_refcount(void* thrown_object) throw()
{
    if (thrown_object != NULL )
    {
        __cxa_exception* exception_header = exception_from_thrown_object(thrown_object);
        __sync_add_and_fetch(&exception_header->referenceCount, 1);
    }
}

/*
    If thrown_object is not null, atomically decrement the referenceCount field
    of the __cxa_exception header associated with the thrown object referred to
    by thrown_object.  If the referenceCount drops to zero, destroy and
    deallocate the exception.

    Requires:  If thrown_object is not NULL, it is a native exception.
*/
void
__cxa_decrement_exception_refcount(void* thrown_object) throw()
{
    if (thrown_object != NULL )
    {
        __cxa_exception* exception_header = exception_from_thrown_object(thrown_object);
        if (__sync_sub_and_fetch(&exception_header->referenceCount, size_t(1)) == 0)
        {
            if (NULL != exception_header->exceptionDestructor)
                exception_header->exceptionDestructor(thrown_object);
            __cxa_free_exception(thrown_object);
        }
    }
}

void __cpp_unwind_exception_cleanup_fn(
    _Unwind_Reason_Code reason, struct _Unwind_Exception* exc)
{
  __cxa_exception* exception = __to_cpp_exception(exc);
  if (_URC_FOREIGN_EXCEPTION_CAUGHT != reason)
      exception->terminateHandler();

    // Just in case there exists a dependent exception that is pointing to this,
    //    check the reference count and only destroy this if that count goes to zero.
  __cxa_decrement_exception_refcount(exc + 1);
//  cleanup(exception);
}

__cxa_eh_globals* __cxa_get_globals()
{
  return __globals();
}

__cxa_eh_globals* __cxa_get_globals_fast()
{
  return __globals();
}

_EXPFUNC void* __cxa_allocate_exception(uint64 thrown_size)
{
  uint64 actual_size = object_size_from_exception_size(thrown_size);
  void* ptr = do_malloc(actual_size);
  if (0 == ptr)
    std::terminate();
  std::memset(ptr, 0, actual_size);
  return thrown_object_from_exception(ptr);
}

_EXPFUNC void __cxa_free_exception(void* thrown_exception)
{
  do_free(exception_from_thrown_object(thrown_exception));
}

_EXPFUNC __cxa_exception* __initialize_exception(
  void* thrown_exception,
  std::type_info* tinfo,
  void (*dest)(void*))
{
  __cxa_eh_globals* globals = __cxa_get_globals();
  __cxa_exception* exception = exception_from_thrown_object(thrown_exception);

  exception->unexpectedHandler = std::unexpected;
  exception->terminateHandler  = std::terminate;
  exception->exceptionType = tinfo;
  exception->exceptionDestructor = dest;
  exception->adjusted_thrown_object = thrown_exception;
  __init_unwind_exception(exception->unwindHeader);

  exception->referenceCount = 1;  // This is a newly allocated exception, no need for thread safety;
  globals->uncaughtExceptions += 1;   // Not atomically, since globals are thread-local

  exception->unwindHeader.exception_cleanup = __cpp_unwind_exception_cleanup_fn;

  return exception;
}

_EXPFUNC void __cxa_throw(
  void* thrown_exception,
  std::type_info* tinfo,
  void (*dest)(void*))
{
//    printf("throwing %p, type = %p, dtor = %p\n",
//	   thrown_exception, tinfo, dest);
// TODO: __notifyThrow is dealing with two different things here, in C++ exceptions,
    // it's a cxa_allocate_exception block, and in Delphi exceptions, a raw pointer
    if (is_delphi_type(tinfo)) 
    {
	__throw_as_delphi(thrown_exception, 0);
    }
    else
    {
        __notifyThrow(thrown_exception, tinfo);
    }

  __cxa_exception* exception =
    __initialize_exception(thrown_exception, tinfo, dest);

//  back_trace();
//  printf("__cxa_throw\n");
  _Unwind_RaiseException(&exception->unwindHeader);

  // _Unwind_RaiseException cannot return! If it does, there's something wrong.
  failed_throw(exception);
}

_EXPFUNC void* __cxa_get_exception_ptr(void* exceptionObject)
{
   return ((_Unwind_Exception*)exceptionObject)+1;
}

_EXPFUNC void* __cxa_begin_catch(void* exceptionObject)
{
  __cxa_eh_globals* globals = __cxa_get_globals();

  __cxa_exception* exception =
    __to_cpp_exception((_Unwind_Exception*)exceptionObject);

  exception->handlerCount =
    exception->handlerCount < 0 ?
    -exception->handlerCount + 1 :
    exception->handlerCount + 1;

  //  place the exception on the top of the stack if it's not there.
  if (exception != globals->caughtExceptions)
  {
      exception->nextException = globals->caughtExceptions;
      globals->caughtExceptions = exception;
  }

  globals->uncaughtExceptions -= 1;   // Not atomically, since globals are thread-local
  if (exception->exceptionType == 0 || is_delphi_type((void const *)exception->exceptionType)) {
      ms_api::exception_record *er = (ms_api::exception_record *)thrown_object_from_exception(exception);
      return ms_api::get_delphi_exception(*er);
  }
//  return thrown_object_from_exception(exception);
  return exception->adjusted_thrown_object;
}

_EXPFUNC void __cxa_end_catch()
{
    static_assert(sizeof(__cxa_exception) == sizeof(__cxa_dependent_exception),
                  "sizeof(__cxa_exception) must be equal to sizeof(__cxa_dependent_exception)");

  __cxa_eh_globals* globals = __cxa_get_globals();
  __cxa_exception* current_exception = globals->caughtExceptions;

  if (NULL != current_exception)
  {
    if (current_exception->handlerCount < 0)
    {
      //  The exception has been rethrown
      if (0 == incrementHandlerCount(current_exception))
      {
          globals->caughtExceptions = current_exception->nextException;
      //  Howard says: If the exception has been rethrown, don't destroy.
      }
    }
    else
    {
      if (0 == decrementHandlerCount(current_exception))
      {
        //  Remove from the chain of uncaught exceptions
        globals->caughtExceptions = current_exception->nextException;
	// Destroy this exception, being careful to distinguish
	//    between dependent and primary exceptions
	if (isDependentException(&current_exception->unwindHeader))
	    {
		// Reset exception_header to primaryException and deallocate the dependent exception
		__cxa_dependent_exception* dep_exception_header =
		    reinterpret_cast<__cxa_dependent_exception*>(current_exception);
		current_exception =
		    exception_from_thrown_object(dep_exception_header->primaryException);
		__cxa_free_dependent_exception(dep_exception_header);
	    }
//	__notifyCatchTerminate((void *)current_exception->adjustedPtr);
    // Just in case there exists a dependent exception that is pointing to this,
    //    check the reference count and only destroy this if that count goes to zero.
	__cxa_decrement_exception_refcount(current_exception + 1);
//        cleanup(current_exception);
        // $$$ JDG $$$ TODO: Deal with dependent exceptions
      }
    }
  }
}

_EXPFUNC void __cxa_rethrow()
{
  __cxa_eh_globals* globals = __cxa_get_globals();
  __cxa_exception* exception = globals->caughtExceptions;

  if (0 == exception) // there's no current exception!
      std::terminate();

  //  Mark the exception as being rethrown
  exception->handlerCount = -exception->handlerCount ;	// TODO: Atomic

  globals->uncaughtExceptions += 1;   // Not atomically, since globals are thread-local

  // $$$ JDG $$$ This should really call _Unwind_Resume_or_Rethrow
  _Unwind_RaiseException(&exception->unwindHeader);

  //  If we get here, some kind of unwinding error has occurred.
  failed_throw(exception);
}

extern "C" _EXPFUNC void __cxa_call_unexpected()
{
  std::unexpected();
}


namespace std {
  _EXPFUNC bool uncaught_exception() throw()
  {	// report if handling a throw
    __cxa_eh_globals* globals = __cxa_get_globals();
    if (globals == 0)
        return false;
    return globals->uncaughtExceptions != 0;
  }
} /* namespace std */

_EXPFUNC void*
__cxa_current_primary_exception() throw()
{
  __cxa_eh_globals* globals = __cxa_get_globals();
  __cxa_exception* exception = globals->caughtExceptions;

  if (0 == exception) // there's no current exception
      return 0;

    if (!isOurExceptionClass(&exception->unwindHeader))
        return NULL;        // Can't capture a foreign exception (no way to refcount it)
    if (isDependentException(&exception->unwindHeader)) {
        __cxa_dependent_exception* dep_exception_header =
            reinterpret_cast<__cxa_dependent_exception*>(exception);
        exception = exception_from_thrown_object(dep_exception_header->primaryException);
    }
    void* thrown_object = thrown_object_from_exception(exception);
    __cxa_increment_exception_refcount(thrown_object);
    return thrown_object;
#if 0
  //  Mark the exception as being ret
  exception->handlerCount = ++exception->handlerCount ;	// TODO: Atomic

  return thrown_object_from_exception(exception);
#endif
}

/*
    If reason isn't _URC_FOREIGN_EXCEPTION_CAUGHT, then the terminateHandler
    stored in exc is called.  Otherwise the referenceCount stored in the
    primary exception is decremented, destroying the primary if necessary.
    Finally the dependent exception is destroyed.
*/
static
void
dependent_exception_cleanup(_Unwind_Reason_Code reason, _Unwind_Exception* unwind_exception)
{
    __cxa_dependent_exception* dep_exception_header = 
                      reinterpret_cast<__cxa_dependent_exception*>(unwind_exception + 1) - 1;
    if (_URC_FOREIGN_EXCEPTION_CAUGHT != reason)
        dep_exception_header->terminateHandler();
    __cxa_decrement_exception_refcount(dep_exception_header->primaryException);
    __cxa_free_dependent_exception(dep_exception_header);
}

/*
    If thrown_object is not null, allocate, initialize and thow a dependent
    exception.
*/
_EXPFUNC void
__cxa_rethrow_primary_exception(void* thrown_object)
{
    if ( thrown_object != NULL )
    {
        // thrown_object guaranteed to be native because
        //   __cxa_current_primary_exception returns NULL for foreign exceptions
        __cxa_exception* exception_header = exception_from_thrown_object(thrown_object);
        __cxa_dependent_exception* dep_exception_header =
            static_cast<__cxa_dependent_exception*>(__cxa_allocate_dependent_exception());
        dep_exception_header->primaryException = thrown_object;
        __cxa_increment_exception_refcount(thrown_object);
        dep_exception_header->exceptionType = exception_header->exceptionType;
        dep_exception_header->unexpectedHandler = std::get_unexpected();
        dep_exception_header->terminateHandler = std::get_terminate();
        setDependentExceptionClass(&dep_exception_header->unwindHeader);
        __cxa_get_globals()->uncaughtExceptions += 1;
        dep_exception_header->unwindHeader.exception_cleanup = dependent_exception_cleanup;
#if __arm__
        _Unwind_SjLj_RaiseException(&dep_exception_header->unwindHeader);
#else
        _Unwind_RaiseException(&dep_exception_header->unwindHeader);
#endif
        // Some sort of unwinding error.  Note that terminate is a handler.
        __cxa_begin_catch(&dep_exception_header->unwindHeader);
    }
    // If we return client will call terminate()
}

#if 0
_EXPFUNC void
__cxa_rethrow_primary_exception(void* thrown_object)
{
  __cxa_eh_globals* globals = __cxa_get_globals();
  __cxa_exception* exception = globals->caughtExceptions;

  if (0 == exception) // there's no current exception!
      std::terminate();

  assert(thrown_object == thrown_object_from_exception(exception));
  exception->handlerCount--;
  __cxa_rethrow();
}
#endif

//  This function shall allocate a __cxa_dependent_exception and
//  return a pointer to it. (Really to the object, not past its' end).
//  Otherwise, it will work like __cxa_allocate_exception.
void * __cxa_allocate_dependent_exception () {
    size_t actual_size = sizeof(__cxa_dependent_exception);
    void *ptr = do_malloc(actual_size);
    if (NULL == ptr)
        std::terminate();
    std::memset(ptr, 0, actual_size);
    return ptr;
}


//  This function shall free a dependent_exception.
//  It does not affect the reference count of the primary exception.
void __cxa_free_dependent_exception (void * dependent_exception) {
    do_free(dependent_exception);
}
