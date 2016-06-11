/*=============================================================================
 The Language Specific Handler
 http://msdn.microsoft.com/en-us/library/b6sf5kbd%28v=vs.80%29.aspx
=============================================================================*/
#include <assert.h>
#include <exception>
#include "ms_api.hpp"
#include "unwind_cpp_support.hpp"
#include "delphi_support.h"
#include "diag.h"
#include <stdio.h>

extern "C" void DebugBreak();
//static void DebugBreak() { }

/**
   This is a routine pointer setup in the Delphi RTL to allocate a Delphi exception
   object for OS exceptions.  If it is non-null, we can use it.
*/
typedef void *(*ExceptObjProc_t)(ms_api::exception_record *excRec);
namespace System {
    extern ExceptObjProc_t ExceptObjProc;
}

namespace ms_api { namespace detail
{
  struct exception_handler
  {
    enum action_code
    {
      action_unwind,
      action_target_unwind,
      action_colliding_unwind,
      action_forced_unwind,
      action_search_phase,
      action_cleanup_phase,
    };

    exception_record& x_rec;
    uint64 est_frame;
    context& ctx;
    dispatcher_context& disp_ctx;
    _Unwind_Exception* unwind_exception;
    _Unwind_Context cpp_context;

    exception_handler(
      exception_record& x_rec,
      uint64 est_frame,
      context& ctx,
      dispatcher_context& disp_ctx)
    : x_rec(x_rec), est_frame(est_frame),
      ctx(ctx), disp_ctx(disp_ctx)
    {
    }

    action_code get_action()
    {
      if (x_rec.ExceptionFlags & exception_target_unwind)
        return action_target_unwind;

      if (is_clang_unwind_code(x_rec))
        return action_unwind;

      int cleanup_phase_flags =
        exception_unwinding
      | exception_exit_unwind;

      if (x_rec.ExceptionFlags & cleanup_phase_flags)
        return action_cleanup_phase;
      else
        return action_search_phase;
    }

    exception_disposition search_phase()
    {
//	printf("search phase\n");
      assert(unwind_exception);
      int reason = __seh_cxx_personality_v0(
        1, _UA_SEARCH_PHASE, unwind_exception->exception_class,
        unwind_exception, &cpp_context);

//	printf("search phase1\n");
      switch (reason)
      {
        case _URC_CONTINUE_UNWIND:
//	printf("CONTINUE_UNWIND\n");
          return ExceptionContinueSearch;
        case _URC_RESUME_EXECUTION:
//	printf("RESUME_EXEC\n");
          return ExceptionContinueExecution;
        case _URC_HANDLER_FOUND:
        {
//	printf("HANDLER_FOUND\n");
          // When we successfully find a handler or if there's a valid
          // target landing-pad IP for cleanup, we can proceed and initiate
          // the actual unwind through RtlUnwindEx. Our language handler
          // (__seh_cxx_personality_v0) caches the necessary information to
          // transfer control to a landing pad in the exception object:
          //
          //    exception->adjustedPtr:         The target IP
          //    exception->handlerSwitchValue:  LLVM's selector index
          //
          // The selector index along with the unwind_exception will be
          // installed next time around in target_unwind(). For now, we
          // need the target IP to be able to call RtlUnwindEx which does
          // the actual unwinding and in turn calls our target_unwind()
          // above when we are at the the target frame.

          __cxa_exception* exception =
            __to_cpp_exception(unwind_exception);

          // initiate phase2 *ONLY* if there's a valid target-IP.
          if (exception->adjustedPtr)
          {
//	printf("heading into RtlUnwindEx\n");
//	DebugBreak();
            // Initiate phase2
            RtlUnwindEx(
              (void*)est_frame,
              exception->adjustedPtr,
              &x_rec,
              unwind_exception,
              &ctx,
              disp_ctx.HistoryTable);

            // RtlUnwindEx cannot return! If it does, there's something wrong.
            std::terminate();
          }
        }
      }
      return ExceptionContinueSearch;
    }

    exception_disposition target_unwind()
    {
//	printf("target_unwind\n");
      assert(unwind_exception);
      int reason = __seh_cxx_personality_v0(
        1, _UA_CLEANUP_PHASE | _UA_HANDLER_FRAME,
        unwind_exception->exception_class,
        unwind_exception, &cpp_context);

      if (reason != _URC_INSTALL_CONTEXT)
        std::terminate();

      return ExceptionContinueSearch;
    }

    exception_disposition unwind()
    {
//	printf("unwind\n");
      if (x_rec.ExceptionInformation[1] == est_frame)
      {
        __cxa_exception* exception =
          __to_cpp_exception(unwind_exception);

        if (exception->adjustedPtr)
        {
          RtlUnwindEx(
            (void*)est_frame,
            (void*)exception->adjustedPtr, // target IP
            &x_rec,
            unwind_exception,
            &ctx,
            disp_ctx.HistoryTable);

          // RtlUnwindEx cannot return! If it does, there's something wrong.
          std::terminate();
        }
      }

      return ExceptionContinueSearch;
    }

    exception_disposition colliding_unwind()
    {
      assert(false); // Unimplemented colliding_unwind
      return ExceptionContinueExecution;
    }

    exception_disposition forced_unwind()
    {
      assert(false); // Unimplemented forced_unwind
      return ExceptionContinueExecution;
    }

    exception_disposition cleanup_phase()
    {
//	printf("cleanup phase\n");
      assert(unwind_exception);
      int reason = __seh_cxx_personality_v0(
        1, _UA_CLEANUP_PHASE,
        unwind_exception->exception_class,
        unwind_exception, &cpp_context);

      if (reason == _URC_CONTINUE_UNWIND)
	      return ExceptionContinueSearch;

      if (reason == _URC_INSTALL_CONTEXT)
      {
        __cxa_exception* exception =
          __to_cpp_exception(unwind_exception);

        // The unwind_exception
        x_rec.ExceptionInformation[0] = (uint64)unwind_exception;

        // This frame
        x_rec.ExceptionInformation[1] = est_frame;

        RaiseException(
          clang_unwind_code,
          ms_api::exception_noncontinuable,
          2, x_rec.ExceptionInformation);
      }

      std::terminate();
      return ExceptionContinueExecution;
    }

    exception_disposition start()
    {
//	printf("start\n");
      // There are situations where we lose the current in flight exception
      // when deep inside the MS unwind mechanism where the MS runtime
      // rethrows another exception. To deal with such a situation, the only
      // recourse is to take note of the current in-flight exception for
      // each thread.
      static thread_local _Unwind_Exception* current_inflight_exception = 0;
//      DebugBreak();

      if (is_clang_exception(x_rec))
      {
//	  printf("clang\n");
        // Extract the exception from the MS exception_record.
        unwind_exception = get_exception(x_rec);
        current_inflight_exception = unwind_exception;
      }
      else if (is_delphi_exception(x_rec))
      {
//	  printf("delphi\n");
//	  DebugBreak();
          void* x = __cxa_allocate_exception(sizeof(exception_record));
          *((exception_record*)x) = x_rec; // copy over the whole exception_record!
	  DEBUG_PRINT("cpprtl.exceptions.delphi",
		      ("delphi exception intercepted: %p\n",
		       get_delphi_exception(x_rec)));
          __cxa_exception* exception =
	      __initialize_exception(x, NULL, destroy_delphi_exception);
          unwind_exception = &exception->unwindHeader;
          unwind_exception->private_1 = clang_id;
          unwind_exception->private_2 = (uint64) x;
          current_inflight_exception = unwind_exception;
      }
      else
      {
//	  printf("other\n");
//	  DebugBreak();
	  /*
	    Who knows what this is.  It could be a foreign exception from
	    another language, or it could be a hardware violation of some
	    kind.
	   */
#if 0
        if (ms_api::is_exception_unwind(x_rec))
        {
	    printf("ms unwind\n");
          unwind_exception = current_inflight_exception;
        }
        else
#endif
        if (ms_api::is_longjump_unwind(x_rec))
	{
          void* x = __cxa_allocate_exception(sizeof(exception_record));
          *((exception_record*)x) = x_rec; // copy over the whole exception_record!
          __cxa_exception* exception =
            __initialize_exception(x, NULL, 0);
          unwind_exception = &exception->unwindHeader;
          unwind_exception->private_1 = clang_id;
          unwind_exception->private_2 = (uint64) x;
          current_inflight_exception = unwind_exception;
	  cpp_context.disp_ctx = &disp_ctx;
          return cleanup_phase();
	}
	else
        {
//	    printf("hardware exception coming through\n");
//	  DebugBreak();
          void* x = __cxa_allocate_exception(sizeof(exception_record));
          *((exception_record*)x) = x_rec; // copy over the whole exception_record!
          __cxa_exception* exception =
            __initialize_exception(x, NULL, 0);
          unwind_exception = &exception->unwindHeader;
          unwind_exception->private_1 = clang_id;
          unwind_exception->private_2 = (uint64) x;
          current_inflight_exception = unwind_exception;
        }
      }

      // Now we can make a c++ unwind context
      cpp_context.disp_ctx = &disp_ctx;

      switch (get_action())
      {
        case action_unwind:
          return unwind();
        case action_target_unwind:
          return target_unwind();
        case action_colliding_unwind:
          return colliding_unwind();
        case action_forced_unwind:
          return forced_unwind();
        case action_search_phase:
          return search_phase();
        case action_cleanup_phase:
          return cleanup_phase();
      }

      // This should be unreachable.
      std::terminate();
      return ExceptionContinueExecution;
    }
  };
}}

namespace ms_api
{
static void dumpDispatcherContext(dispatcher_context* disp_ctx) {
    printf("DispatcherContext:\n");
    printf("ControlPc = 0x%llx\n", disp_ctx->ControlPc);
    printf("ImageBase = 0x%llx\n", disp_ctx->ImageBase);
    printf("FunctionEntry = 0x%p\n", disp_ctx->FunctionEntry);
    printf("TargetIp = 0x%llx\n", disp_ctx->TargetIp);
    printf("ContextRecord = 0x%p\n", disp_ctx->ContextRecord);
    printf("LanguageHandler = 0x%p\n", disp_ctx->LanguageHandler);
    printf("HandlerData = 0x%p\n", disp_ctx->HandlerData);
}

  /*-----------------------------------------------------------------------------
      x_rec: A pointer to an exception record, which has the standard
      Win64 definition.

      est_frame: The address of the base of the fixed stack allocation
      for this function.

      ctx: Points to the exception context at the time the exception was
      raised (in the exception handler case) or the current "unwind"
      context (in the termination handler case).

      disp_ctx: Points to the dispatcher context for this function.
      It has the following definition:
  -----------------------------------------------------------------------------*/
  extern "C" _EXPFUNC exception_disposition _LLVM_specific_handler(
      exception_record* x_rec,
      uint64 est_frame,
      context* ctx,
      dispatcher_context* disp_ctx
    )
  {
//      printf("llvm handler: exception code = 0x%08x, exception flags = 0x%08x\n",
//	     x_rec->ExceptionCode, x_rec->ExceptionFlags);
//      dumpDispatcherContext(disp_ctx);
//      DebugBreak();
      if (!is_clang_exception(*x_rec) &&
	  !is_delphi_exception(*x_rec) &&
	  System::ExceptObjProc != NULL) {
	  /*
	    An external exception (e.g. AV) came in. The Delphi RTL appears to be
	    present, so we'll fire up ExceptObjProc to get a language exception object,
	    and re-raise the exception as a Delphi exception.
	   */
	  void *obj = (System::ExceptObjProc)(x_rec);
	  __throw_as_delphi(obj, 0);
      }
    detail::exception_handler handler(*x_rec, est_frame, *ctx, *disp_ctx);
    return handler.start();
  }
}
