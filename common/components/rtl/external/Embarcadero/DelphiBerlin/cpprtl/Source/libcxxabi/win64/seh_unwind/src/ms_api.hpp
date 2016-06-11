/*=============================================================================
 MS related API and helpers (internal only!)
=============================================================================*/
#if !defined(CXXRUNTIME_MS_API_HPP)
#define CXXRUNTIME_MS_API_HPP

#include <windows.h>
#include <_defs.h>
#include <stdint.h>
#include <unwind.h>

namespace ms_api
{
  // Rename these eye-sores!
  typedef USHORT uint16;
  typedef ULONG uint32;
  typedef ULONG64 uint64;

  typedef SHORT int16;
  typedef LONG int32;
  typedef LONG64 int64;

#if defined(_WIN64)
  typedef RUNTIME_FUNCTION runtime_function;
  typedef KNONVOLATILE_CONTEXT_POINTERS non_volatile_context_pointers;
  typedef UNWIND_HISTORY_TABLE unwind_history_table;
#endif

  typedef CONTEXT context;
  typedef EXCEPTION_ROUTINE exception_routine;
  typedef EXCEPTION_DISPOSITION exception_disposition;
  typedef EXCEPTION_RECORD exception_record;
  typedef ULONG_PTR exception_arg;

#if defined(__WIN32__)
    typedef CONTEXT dispatcher_context;
#else
    struct dispatcher_context;
#endif
}

extern "C"
{
#if defined(__WIN32__)
    struct _Unwind_FunctionContext
    {
	// next function in stack of handlers
	struct _Unwind_FunctionContext*		prev;
	void *rtl_handler;
	
	// set by calling function before registering to be the landing pad
	uintptr_t							resumeLocation;
	
	// set by personality handler to be parameters passed to landing pad function
	uintptr_t							resumeParameters[4];
	
	// set by calling function before registering
	__personality_routine_f				personality;
	uintptr_t							lsda;
	
	void*								jbuf[];
    };

    typedef struct _Unwind_FunctionContext* _Unwind_FunctionContext_t;
#endif // !_WIN64

    struct _Unwind_Exception;

    // Our private unwind context
    struct _Unwind_Context
    {
#if defined(__WIN32__)
	_Unwind_FunctionContext_t function_context;
#endif
	ms_api::dispatcher_context* disp_ctx;
    };
}

namespace ms_api
{
  /*-----------------------------------------------------------------------------
  // print a stack-trace for debugging
  -----------------------------------------------------------------------------*/
  void stack_trace();

  // See http://msdn.microsoft.com/en-us/library/het71c37(v=VS.80).aspx

  /*-----------------------------------------------------------------------------
    Exception handling flags:
      Possible flags for exception_record::ExceptionCode
  -----------------------------------------------------------------------------*/
  enum exception_flags
  {
    exception_noncontinuable   = 0x0001,
    exception_unwinding        = 0x0002,
    exception_exit_unwind      = 0x0004,
    exception_stack_invalid    = 0x0008,
    exception_nested_call      = 0x0010,
    exception_target_unwind    = 0x0020,
    exception_collided_unwind  = 0x0040,
    exception_unwind           = 0x0066
  };

  /*-----------------------------------------------------------------------------
  // clang related errors
  -----------------------------------------------------------------------------*/
  static unsigned int msvc_error =
    0xE0000001;

//#define CPP_EXCEPT_CODE 0xEEFFACE

#if defined(_WIN64)
  static unsigned int clang_id =
      msvc_error
    | 'c' << 24
    | 'l' << 16
    | 'g' << 8
    ;
#else
    // __WIN32__
    static unsigned int clang_id = 0xEEFFACE;
#endif

  static unsigned int delphi_throw_code = 0xeedfade;

  static unsigned int clang_throw_code =
      clang_id | 0;
  static unsigned int clang_unwind_code =
      clang_id | (1 << 1);

  inline bool is_clang_throw_code(exception_record const& x_rec)
  {
    return x_rec.ExceptionCode == clang_throw_code;
  }

  inline bool is_delphi_throw_code(exception_record const& x_rec)
  {
    return x_rec.ExceptionCode == delphi_throw_code;
  }

  inline bool is_clang_unwind_code(exception_record const& x_rec)
  {
    return x_rec.ExceptionCode == clang_unwind_code;
  }

  inline bool is_longjump_unwind(exception_record const &x_rec)
  {
    return x_rec.ExceptionCode == STATUS_LONGJUMP;
  }

  inline bool is_clang_exception(exception_record const& x_rec)
  {
    return is_clang_throw_code(x_rec)
      || is_clang_unwind_code(x_rec);
  }

  inline bool is_delphi_exception(exception_record const& x_rec)
  {
    return is_delphi_throw_code(x_rec);
  }

  inline bool is_exception_unwind(exception_record const& x_rec)
  {
    return (x_rec.ExceptionFlags & exception_unwind) != 0;
  }

  /*-----------------------------------------------------------------------------
    Convert an RaiseException to an exception_arg
  -----------------------------------------------------------------------------*/
  inline exception_arg* as_exception_arg(_Unwind_Exception*& x)
  {
    return reinterpret_cast<exception_arg*>(&x);
  }

  inline _Unwind_Exception* get_exception(exception_record const& x_rec)
  {
    return reinterpret_cast<_Unwind_Exception*>(
      x_rec.ExceptionInformation[0]);
  }

  /**
     Returns the exception object that was thrown in a Delphi exception.
     Assumes that the exception record is the one that was issued from Delphi.
     IOW, there will be 7 parameters, and the second is the object.
   */
  inline void* get_delphi_exception(exception_record const& x_rec)
  {
    return reinterpret_cast<void *>(
      x_rec.ExceptionInformation[1]);
  }

#if defined(_WIN64)
  /*-----------------------------------------------------------------------------
    The dispatcher context
  -----------------------------------------------------------------------------*/
  struct dispatcher_context
  {
    struct handler_data
    {
      char data[20];
    };

    uint64 ControlPc;
    uint64 ImageBase;
    runtime_function* FunctionEntry;
    uint64 EstablisherFrame;
    uint64 TargetIp;
    context* ContextRecord;
    exception_routine* LanguageHandler;
    handler_data* HandlerData;

    //  MSDN’s definition of DISPATCHER_CONTEXT is incomplete. There
    //  are some additional fields beyond HandlerData, which is the last
    //  field documented in MSDN. (see http://www.nynaeve.net/?p=99)

    unwind_history_table* HistoryTable;
    uint64 ScopeIndex;
    uint64 Fill0;
  };

    inline uint64 frame_pointer(dispatcher_context const *ctx) { return ctx->ContextRecord->Rbp; }

  /*-----------------------------------------------------------------------------
    _LLVM_specific_handler:
      The language specific handler is called as part of the search for an
      exception handler or as part of an unwind. This is the language handler
      that dispatches MS-SEH handling to Itanium style C++ Exception Handling.
  -----------------------------------------------------------------------------*/
  extern "C" _EXPFUNC exception_disposition _LLVM_specific_handler(
      exception_record* x_rec,
      uint64 est_frame,
      context* ctx,
      dispatcher_context* disp_ctx
    );
#else
    inline uintptr_t frame_pointer(dispatcher_context const *ctx) { return ctx->Ebp; }
#endif // !defined(_WIN64)
}

#endif
