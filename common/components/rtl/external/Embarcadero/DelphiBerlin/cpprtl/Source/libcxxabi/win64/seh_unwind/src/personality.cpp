/*=============================================================================
 __seh_cxx_personality_v0
 Implementation of the SEH personality function

 (note: c++ is used in the implementation)
=============================================================================*/
#include <_defs.h>
#include <stddef.h>
#include <stdint.h>
#include <cstdlib>          // for malloc, free
#include <exception>        // for std::terminate
#include <string>           // for memset
#include <assert.h>

#include "unwind_cpp_support.hpp"
#include "../include/cpp_unwind.hpp"
#include "../include/debugger.h"
#include "../../src/private_typeinfo.h"
#include "ms_api.hpp"
#if 0
#include <cstdlib>          // for malloc, free
#include <exception>        // for std::terminate
#include <string>           // for memset
#include <assert.h>
#endif

#include <stdio.h>

#include "diag.h"
#include "delphi_support.h"

//#define DEBUG_PRINT(a,b)

extern "C" void DebugBreak();
//static void DebugBreak() { }

extern "C"
{
  // our pseudo type_infos
_EXPFUNC   void* __seh_filter;
_EXPFUNC   void* __seh_handler;
  extern void* _ZTVN10__cxxabiv119__pointer_type_infoE;
  extern void* _ZTVN10__cxxabiv117__class_type_infoE;
  extern void* _ZTVN10__cxxabiv120__si_class_type_infoE;
}

/**
   Used to ge the current exception code/exception info support, only during SEH
   filter expression operations.  Note that the implementation of this as a thread
   var makes us non-reentrant.
 */
static __declspec(thread) ms_api::exception_record exception_info_context;

namespace
{
  typedef unsigned char byte;
  using ms_api::uint16;
  using ms_api::uint32;

  using ms_api::int16;
  using ms_api::int32;
  using ms_api::int64;

  template <bool signed_>
  uint64 read_leb128(byte const*& p)
  {
    uint64 result = 0;
    uint64 shift = 0;
    byte b;

    do
    {
      b = *p++;
      result |= (b & 0x7f) << shift;
      shift += 7;
    }
    while (b & 0x80);

    if (signed_)
      if ((b & 0x40) && (shift < (sizeof(result) << 3)))
        result |= (~0 << shift);
    return result;
  }

  uint64 read_uleb128(byte const*& p)
  {
    return read_leb128<false>(p);
  }

  uint64 read_sleb128(byte const*& p)
  {
    return read_leb128<true>(p);
  }

  enum dwarf_constants
  {
    DW_EH_PE_absptr = 0x00,
    DW_EH_PE_omit = 0xff,
    DW_EH_PE_uleb128 = 0x01,
    DW_EH_PE_udata2 = 0x02,
    DW_EH_PE_udata4 = 0x03,
    DW_EH_PE_udata8 = 0x04,
    DW_EH_PE_sleb128 = 0x09,
    DW_EH_PE_sdata2 = 0x0A,
    DW_EH_PE_sdata4 = 0x0B,
    DW_EH_PE_sdata8 = 0x0C,
    DW_EH_PE_signed = 0x08,
    DW_EH_PE_pcrel = 0x10,
    DW_EH_PE_textrel = 0x20,
    DW_EH_PE_datarel = 0x30,
    DW_EH_PE_funcrel = 0x40,
    DW_EH_PE_aligned = 0x50,
    DW_EH_PE_indirect = 0x80
  };

  uint64 read_encoded_pointer(byte const*& p, byte encoding)
  {
    uint64 result = 0;

    if (encoding == DW_EH_PE_omit)
      return(result);

    // first get value
    switch (encoding & 0x0F)
    {
      case DW_EH_PE_absptr:
        result = *((uint64*)p);
        p += sizeof(uint64);
        break;
      case DW_EH_PE_uleb128:
        result = read_uleb128(p);
        break;
        // Note: This case has not been tested
      case DW_EH_PE_sleb128:
        result = read_sleb128(p);
        break;
      case DW_EH_PE_udata2:
        result = *((uint16*)p);
        p += sizeof(uint16);
        break;
      case DW_EH_PE_udata4:
        result = *((uint32*)p);
        p += sizeof(uint32);
        break;
      case DW_EH_PE_udata8:
        result = *((uint64*)p);
        p += sizeof(uint64);
        break;
      case DW_EH_PE_sdata2:
        result = *((int16*)p);
        p += sizeof(int16);
        break;
      case DW_EH_PE_sdata4:
        result = *((int32*)p);
        p += sizeof(int32);
        break;
      case DW_EH_PE_sdata8:
        result = *((int64*)p);
        p += sizeof(int64);
        break;
      default:
        // not supported
///	  printf("encoding = %d(0x%x)\n", encoding & 0x0F, encoding & 0x0F);
//	  DebugBreak();
        assert(false);
        break;
    }

    // then add relative offset
    switch (encoding & 0x70)
    {
      case DW_EH_PE_absptr:
        // do nothing
        break;
      case DW_EH_PE_pcrel:
        result += (uint64)(*p);
        break;
      case DW_EH_PE_textrel:
      case DW_EH_PE_datarel:
      case DW_EH_PE_funcrel:
      case DW_EH_PE_aligned:
      default:
        // not supported
        assert(false);
        break;
    }

    // then apply indirection
    if (encoding & DW_EH_PE_indirect)
      result = *((uint64*)result);

    return result;
  }

  struct exception_handler
  {
    _Unwind_Action actions;
    _Unwind_Exception* unwind_exception;
    _Unwind_Context* context;
    __cxa_exception *cxa_exception;
    bool is_foreign;

    uint64 pc;
    uintptr_t funct_start;
    uintptr_t pc_offset;

    uintptr_t* class_info;

    exception_handler(
      _Unwind_Action actions,
      _Unwind_Exception* unwind_exception,
      _Unwind_Context* context,
      bool is_foreign)
    : actions(actions),
      unwind_exception(unwind_exception),
      cxa_exception(__to_cpp_exception(unwind_exception)),
      context(context),
      class_info(0),
      is_foreign(is_foreign)
    {
    }

#if DEBUG_CODE_ON
      static const char *action_flags(_Unwind_Action actions) {
	  static char buff[128];
	  buff[0] = '\0';
	  if (actions & _UA_SEARCH_PHASE)
	      strcat(buff, "_UA_SEARCH_PHASE");
	  if (actions & _UA_CLEANUP_PHASE)
	      strcat(buff, "_UA_CLEANUP_PHASE");
	  if (actions & _UA_HANDLER_FRAME)
	      strcat(buff, "_UA_HANDLER_FRAME");
	  if (actions & _UA_FORCE_UNWIND)
	      strcat(buff, "_UA_FORCE_UNWIND");
	  return buff;
      }
#endif

    void parse_lsda_header(byte const*& lsda)
    {
      DEBUG_PRINT("cpprtl.unwind", ("lsda = 0x%p\n", lsda));
//	printf("lsda: %p\n", lsda);
      byte encoding = *lsda++;
//      DebugBreak();

      if (encoding != DW_EH_PE_omit)
        read_encoded_pointer(lsda, encoding);

      encoding = *lsda++;
      uint64 class_info_offset;

      if (encoding != DW_EH_PE_omit)
      {
        // Calculate type info locations in emitted dwarf code which
        // were flagged by type info arguments to llvm.eh.selector
        // intrinsic
        class_info_offset = read_uleb128(lsda);
        class_info = (uintptr_t*) (lsda + class_info_offset);
      }
    }

    int invoke_filter(uint64 target_ip, __cxa_exception *exception) {
      ms_api::context ctx __attribute__((aligned(0x10)));
#if defined(_WIN64)
      RtlCaptureContext(&ctx);
#endif
#if defined(__WIN32__)
      __seh_capture_context(&ctx);
#endif

#if defined(_WIN64)
      DEBUG_PRINT("cpprtl.unwind.seh_filter",
		  ("captured RIP = 0x%p\n", ctx.Rip));
#endif // _WIN64
      if (exception->catchTemp == 0) {
        exception->catchTemp = &ctx;
//	DebugBreak();
#if defined(__WIN32__)
      _Unwind_SetGR(context, 0, (uintptr_t)unwind_exception);
      _Unwind_SetGR(context, 1, 2);
      __invoke_filter_function(_Unwind_GetCFA(context),
			       unwind_exception,
			       target_ip);
#endif // __WIN32__
#if defined(_WIN64)
	__invoke_filter_function(ms_api::frame_pointer(context->disp_ctx), //->ContextRecord->Rbp,
				 unwind_exception,
				 target_ip);
#endif // _WIN64
	assert(!"should never get here");
      } else {
        exception->catchTemp = 0;
        int r = int(exception->handlerSwitchValue);
        exception->handlerSwitchValue = 0;
	DEBUG_PRINT("cpprtl.unwind.seh_filter",
		    ("filter function returned %d\n", r));
        return r;
      }
      assert(!"should never get here");
      return 0;
    }

    int call_filter(void* target_ip)
    {
//      DebugBreak();
      DEBUG_PRINT("cpprtl.unwind.seh_filter",
		  ("filter function = 0x%p\n", target_ip));
      __cxa_exception* exception =
        __to_cpp_exception(unwind_exception);

      exception_info_context = *(ms_api::exception_record *)(unwind_exception + 1);
      return invoke_filter((uint64)target_ip, exception);
    }

    enum action_result
    {
      action_handler_not_found,
      action_handler_found,
      action_resume_execution
    };

// Start Borland-isms
    struct tinfo
    {
      void* vtable;
    };

    struct pointer_tinfo
    {
      void* vtable;
      void* name;
      uint32 flags;
      void* pointee;
    };

    struct class_tinfo
    {
      void* vtable;
      void* name;
    };

    struct derived_tinfo
    {
      void* vtable;
      void* name;
      void* base;
    };

    static bool is_pointer(uintptr_t x)
    {
      tinfo& info = *((tinfo*)x);
      return info.vtable ==
        ((char*)&_ZTVN10__cxxabiv119__pointer_type_infoE) + 16;
    }

    static bool is_base_class(uintptr_t x) // most-base class (no base class)
    {
      tinfo& info = *((tinfo*)x);
      return info.vtable ==
        ((char*)&_ZTVN10__cxxabiv117__class_type_infoE) + 16;
    }

    static bool is_derived_class(uintptr_t x) // derived class (single inheritance!!!)
    {
      tinfo& info = *((tinfo*)x);
      return info.vtable ==
        ((char*)&_ZTVN10__cxxabiv120__si_class_type_infoE) + 16;
    }

    static bool is_borland_exception(uintptr_t x)
    {
#ifdef HASBORLANDRTL
// $$$ fix this once we have a real RTL %$$$
      while (is_derived_class(x))
        x = uint64(((derived_tinfo*)x)->base);

      assert(is_base_class(x));

      return x == uint64(&_ZTINSt8SysUtils9ExceptionE);
#else
      return true;
#endif
    }

// End Borland-isms

    bool compare_types(uintptr_t src, uintptr_t dest)
    {
	DEBUG_PRINT("cpprtl.unwind.personality",
		    ("compare_types(0x%p, 0x%p)\n", (void *)src, (void *)dest));
//	printf("compare_types(0x%p, 0x%p)\n", (void *)src, (void *)dest);
//      if (src == dest)
//        return true;

// Start Borland-isms
//      DebugBreak();
//	if (src == dest)
//	    return true;
      if (!src)
          return false;

      bool src_is_delphi = is_delphi_type((void *)src);
      bool dest_is_delphi = is_delphi_type((void *)dest);
      DEBUG_PRINT("cpprtl.unwind.personality",
		  ("source type is%s a delphi type, dest type is%s a dephi type.\n",
		   src_is_delphi ? "" : " not",
		   dest_is_delphi ? "" : " not"));
      if ((src_is_delphi && !dest_is_delphi) ||
	  (!src_is_delphi && dest_is_delphi))
	  return false;
      if (src_is_delphi || dest_is_delphi) {
//	  if (!src_is_delphi || !dest_is_delphi)
//	      return false;
	  return compare_delphi_types((void *)src, (void *)dest);
      }

//      if (src && dest) {
      {
	typedef __cxxabiv1::__shim_type_info my_t;
	DEBUG_PRINT("cpprtl.unwind.personality",
		    ("comparing '%s' to '%s'\n",
		     ((my_t *)src)->name(), ((my_t *)dest)->name()));
#if 1
//	void *adjusted_thrown_object = cxa_exception->adjusted_thrown_object;
	void *adjusted_thrown_object = cxa_exception->thrown_object_from_exception();
	if (((my_t *)dest)->can_catch((my_t *)src,
				      adjusted_thrown_object)) {
	  cxa_exception->adjusted_thrown_object = adjusted_thrown_object;
	  return true;
	}
#endif
#if 0
	if (((my_t *)src)->equals(*(my_t *)dest)) {
	  cxa_exception->adjusted_thrown_object = adjusted_thrown_object;
	  return true;
	}
#endif
      }
#if 0
      // TODO: these checks are likely obsolete now that compare_delphi_types is in place
      // check if src is a pointer
      if (is_pointer(src))
      {
        if (is_pointer(dest))
          return ((pointer_tinfo*)src)->pointee == ((pointer_tinfo*)dest)->pointee;
        if (is_borland_exception(dest))
          return ((pointer_tinfo*)src)->pointee == ((void*)dest);
      }
#endif
// End Borland-isms

      return false;
    }

    action_result handle_action_value(uintptr_t action_entry, void* target_ip)
    {
      int64 action_value;
      action_result result = action_handler_not_found;

      if (!unwind_exception)
        return result;
//      DebugBreak();

      __cxa_exception* exception =
        __to_cpp_exception(unwind_exception);
      uintptr_t type = (uintptr_t)exception->exceptionType;

      DEBUG_PRINT("cpprtl.unwind.search", ("exception type = %p\n", type));

      if (type == 0) {
	  ms_api::exception_record &x_rec =
	      *(ms_api::exception_record *)__cxa_get_exception_ptr(unwind_exception);
	  if (ms_api::is_delphi_exception(x_rec)) {
	  /*
	    It was a Delphi exception, received directly from the Delphi RTL.  We have to
	    delve into the delphi exception object itself to get the type info.
	   */
	      type = (uintptr_t)get_delphi_type_from_object(ms_api::get_delphi_exception(x_rec));
	  }
//		  ms_api::get_delphi_exception(*(ms_api::exception_record *)__cxa_get_exception_ptr(unwind_exception)));
      }

      const byte* action_pos = (byte*) action_entry;
      const byte* temp_action_pos;
      int64 type_offset = 0;
      int64 action_offset;
      int filter_action = 0;

      for (int i = 0; true; ++i)
      {
        // Each emitted dwarf action corresponds to a 2 tuple of
        // type info address offset, and action offset to the next
        // emitted action.
        type_offset = read_sleb128(action_pos);
        temp_action_pos = action_pos;
        action_offset = read_sleb128(temp_action_pos);

	DEBUG_PRINT("cpprtl.unwind.search",
		    ("classinfo = 0x%llx, type_offset = %d\n", class_info, type_offset));

        assert((type_offset >= 0) &&
               "filters are not supported.");

        // Note: A type_offset == 0 implies that a cleanup llvm.eh.selector
        //       argument has been matched.

        if (type_offset > 0)
        {
//	  DEBUG_PRINT("cpprtl.unwind.search",
//		      ("classinfo = 0x%llx, type_offset = %d\n", class_info, type_offset));
          uintptr_t info = class_info[-type_offset];
	  uintptr_t handler_type;

	  if (info) {
//	      printf("handler_type = %p\n", (void *)info);
#if defined(_WIN64)
	      handler_type = (uintptr_t)*((uintptr_t *)info);
#else
	      handler_type = info;
#endif
	  }
          // Check if a type matches. Note: a null i8* is interpreted as a catch-all
          // by the C++ personality function, and will always match.
//          bool handler_found = ((info == 0) || compare_types(type, info));
	  DEBUG_PRINT("cpprtl.unwind.search",
		      ("info = 0x%llx, type = %p, handler_type = %p, filter_action = %d\n",
		       info, type, handler_type, filter_action));
//	  DebugBreak();
	  if (handler_type == (uintptr_t)&__seh_filter) {
	    DEBUG_PRINT("cpprtl.unwind.search",
			("SEH Filter expression found: IP = 0x%p\n", target_ip));
            filter_action = call_filter(target_ip);
	    DEBUG_PRINT("cpprtl.unwind.search",
			("SEH filter result = %d\n", filter_action));
            if (filter_action == -1)
            {
              result = action_resume_execution;
              break;
            }
	    else if (filter_action == 0) {
		result = action_handler_not_found;
		break;
	    }
	  } else {
	      bool handler_found = false;
	      bool seh_handler_found = false;

	      if (handler_type == (uintptr_t)&__seh_handler) {
		DEBUG_PRINT("cpprtl.unwind.search", ("SEH handler found\n"));
		seh_handler_found = filter_action == 1;
	      } else {

//          bool handler_found = ((info == 0) || compare_types(type, handler_type));
		handler_found = ((info == 0) || compare_types(type, handler_type));
	      }

          // Check if we have an SEH handler
//          bool seh_handler_found =
//            (filter_action == 1) &&
//            (uint64(&__seh_handler) == (class_info[-type_offset]));

          if (handler_found || seh_handler_found)
          {
            action_value = i + 1;
            result = action_handler_found;

            // Cache the values in the __cxa_exception
            exception->handlerSwitchValue = int(type_offset);
            exception->actionRecord = (const char*) action_entry;
//            exception->languageSpecificData =
//              (const char*)&class_info[-type_offset];
            exception->languageSpecificData =
              (const char*)class_info[-type_offset];
            exception->adjustedPtr = target_ip;
            break;
	  }
	  }
#if 0
          else if (uint64(&__seh_filter) == (class_info[-type_offset]))
          {
            filter_action = call_filter(target_ip);
            if (filter_action == -1)
            {
              result = action_resume_execution;
              break;
            }
          }
#endif
        }

        if (!action_offset)
          break;

        action_pos += action_offset;
      }

      if (result != action_handler_found)
      {
        // If no exception matched, cache some values for cleanup
          exception->handlerSwitchValue = 0;
          exception->actionRecord = (const char*) action_entry;
          exception->languageSpecificData = 0;
      }
      return result;
    }

    action_result find_call_site(byte const*& lsda)
    {
#if defined(_WIN64)
      byte encoding = *lsda++;
      uint64 table_length = read_uleb128(lsda);
      const byte* table_start = lsda;
      const byte* table_end =
        table_start + table_length;
      const byte* action_table_start = table_end;
      const byte* call_site = table_start;

      DEBUG_PRINT("cpprtl.unwind.find_call_site",
		  ("looking for pc_offset = 0x%llx\n", pc_offset));
      while (call_site < table_end)
      {
        uint64 start = read_encoded_pointer(call_site, encoding);
        uint64 length = read_encoded_pointer(call_site, encoding);
        uint64 landing_pad = read_encoded_pointer(call_site, encoding);

	DEBUG_PRINT("cpprtl.unwind.find_call_site",
		    ("(0x%llx, 0x%llx) -> 0x%llx\n", start, length, landing_pad));

        // Note: Action value
        uintptr_t action_entry = read_uleb128(call_site);

        if (is_foreign)
        {
          // We have been notified of a foreign exception being thrown,
          // and we therefore need to execute cleanup landing pads
          action_entry = 0;
        }

        if (landing_pad == 0)
          continue; // no landing pad for this entry

        if (action_entry)
          action_entry += ((uint64) action_table_start) - 1;

        action_result result = action_handler_not_found;

        if ((start <= pc_offset) && (pc_offset < (start + length)))
        {
          void* target_ip = (void*) (funct_start + landing_pad);

	  DEBUG_PRINT("cpprtl.unwind.find_call_site",
		      ("found landing pad: 0x%p\n", target_ip));

          if (action_entry && !is_foreign)
          {
            result = handle_action_value(action_entry, target_ip);
          }

          if (result == action_handler_not_found)
          {
            // Cache the values in the __cxa_exception for cleanup
            __cxa_exception* exception =
              __to_cpp_exception(unwind_exception);
            exception->handlerSwitchValue = 0;
            exception->actionRecord = (const char*) action_entry;
            exception->languageSpecificData =
              (const char*)&class_info[0];
#ifdef __WIN32__
            exception->adjustedPtr = 0;
#else
            exception->adjustedPtr = target_ip;
#endif
            return action_handler_not_found;
          }
          return result;
        }
      }
      __cxa_exception* exception =
        __to_cpp_exception(unwind_exception);
      exception->adjustedPtr = 0; // signal search failure
      return action_handler_not_found;
#else
      DEBUG_PRINT("cpprtl.unwind.find_call_site",
		  ("looking for pc_offset = 0x%lx\n", pc_offset));
      byte encoding = *lsda++;
      uint32 table_length = read_uleb128(lsda);
      const byte* call_site = lsda;
      uint32_t landing_pad;
      uint32_t action;
      const byte* table_start = lsda;
      const byte* table_end =
        table_start + table_length;
      const byte* action_table_start = table_end;
      uintptr_t action_entry = 0;
      int ip = pc_offset - 1;
      if (ip < 0)
	  return action_handler_not_found;
      action_result result = action_handler_not_found;
//      DebugBreak();
      do {
//	  read_uleb128(call_site);
	  landing_pad = *(uint32_t *)call_site;
	  call_site += 4;
	  action = read_uleb128(call_site);
      } while (ip--);
      if (action)
	  action_entry = (uintptr_t)(action_table_start + action - 1);
      assert(landing_pad);
//      void* target_ip = (void*) (funct_start + landing_pad);
      void* target_ip = (void*) (landing_pad);

      DEBUG_PRINT("cpprtl.unwind.find_call_site",
		  ("found landing pad: 0x%p\n", target_ip));
      DEBUG_PRINT("cpprtl.unwind.find_call_site",
		  ("  action: 0x%x\n", action));
      
      if (action_entry && !is_foreign) {
	  result = handle_action_value(action_entry, target_ip);
      }
      
//      if (result == action_handler_not_found) {
      if ((result == action_handler_not_found) && (actions & _UA_CLEANUP_PHASE)) {
	  // no real handler, but we have cleanup to do
	  // Cache the values in the __cxa_exception for cleanup
	  __cxa_exception* exception =
              __to_cpp_exception(unwind_exception);
	  exception->handlerSwitchValue = 0;
	  exception->actionRecord = (const char*) action_entry;
	  exception->languageSpecificData = 0;
	  exception->adjustedPtr = target_ip;
	  return action_handler_found;
      }
      return result;
#endif // !_WIN64
    }

    _Unwind_Reason_Code phase1()
    {
      bool const is_phase1 =
        (actions & _UA_SEARCH_PHASE) && !(actions & _UA_CLEANUP_PHASE);

      if (!context || !unwind_exception || !is_phase1)
        return _URC_FATAL_PHASE1_ERROR;

      DEBUG_PRINT("cpprtl.unwind.phase1", ("phase 1 entry, context = 0x%p, action = %s\n",
					   context, action_flags(actions)));
#if defined(__WIN32__)
      DEBUG_PRINT("cpprtl.unwind.phase1",
		  ("  ERR = 0x%p\n", context->function_context));
      DEBUG_PRINT("cpprtl.unwind.phase1",
		  ("  EBP = 0x%p\n", _Unwind_GetCFA(context)));
#endif
//      DebugBreak();
#if defined(_WIN64)
      byte const* lsda
        = **(byte const***)_Unwind_GetLanguageSpecificData(context);
#else
      byte const* lsda
        = (byte const*)_Unwind_GetLanguageSpecificData(context);
#endif
//      DEBUG_PRINT("cpprtl.unwind.phase1x",
//	  ("lsda = 0x%p\n",
//		   _Unwind_GetLanguageSpecificData(context)));
      parse_lsda_header(lsda);

      switch (find_call_site(lsda))
      {
      case action_handler_not_found:
	  DEBUG_PRINT("cpprtl.unwind.phase1x", ("no handler found - continue unwind\n"));
          return _URC_CONTINUE_UNWIND;
        case action_handler_found:
	  DEBUG_PRINT("cpprtl.unwind.phase1x", ("handler found\n"));
          return _URC_HANDLER_FOUND;
        case action_resume_execution:
	  DEBUG_PRINT("cpprtl.unwind.phase1x", ("resume execution\n"));
          return _URC_RESUME_EXECUTION;
      }
      return _URC_CONTINUE_UNWIND;
    }

    _Unwind_Reason_Code phase2()
    {
      DEBUG_PRINT("cpprtl.unwind.phase2",
		  ("phase 2 entry, context = 0x%p\n", context));
#if defined(__WIN32__)
      DEBUG_PRINT("cpprtl.unwind.phase2",
		  ("  ERR = 0x%p\n", context->function_context));
      DEBUG_PRINT("cpprtl.unwind.phase2",
		  ("  EBP = 0x%p\n", _Unwind_GetCFA(context)));
#endif
      bool const is_phase2 =
        (actions & (_UA_CLEANUP_PHASE | _UA_HANDLER_FRAME)) != 0;

      if (!context || !unwind_exception || !is_phase2)
        return _URC_FATAL_PHASE1_ERROR;

#if defined(_WIN64)
      byte const* lsda
        = **(byte const***)_Unwind_GetLanguageSpecificData(context);
//        = *(byte const**)_Unwind_GetLanguageSpecificData(context);
#else
      byte const* lsda
        = (byte const*)_Unwind_GetLanguageSpecificData(context);
#endif
      parse_lsda_header(lsda);

      action_result action = find_call_site(lsda);

      // find_call_site gets the necessary information to transfer control
      // to a landing pad in the exception object as follows:
      //
      //    exception->adjustedPtr:         The target IP
      //    exception->handlerSwitchValue:  LLVM's selector index
      //
      // The selector index along with the unwind_exception will be
      // installed when we reach the target frame here.

      __cxa_exception* exception =
        __to_cpp_exception(unwind_exception);

      // If there are no handlers or unwind-cleanup code to execute,
      // return _URC_CONTINUE_UNWIND
#ifdef __WIN32__
      if (action == action_handler_not_found) {
#else
	  // the fix for Win32 broke Win64 code.
      if (exception->adjustedPtr == 0) {
#endif
	  DEBUG_PRINT("cpprtl.unwind.phase2", ("no handler found - continue unwind\n"));
        return _URC_CONTINUE_UNWIND;
      }

      // Tell the debugger that we are about to catch an exception
      // for the found handler type.
      if (action == action_handler_found)
	  __notifyCatch((void *)unwind_exception,
			(std::type_info **)exception->languageSpecificData,
			(void *)exception->adjustedPtr);

      // Install the context by placing the arguments into registers
      // Rax for unwind_exception and Rdx for selector index:
#ifdef _WIN64
      context->disp_ctx->ContextRecord->Rax =
        (uint64)unwind_exception;

      context->disp_ctx->ContextRecord->Rdx =
        exception->handlerSwitchValue;
#else
      _Unwind_SetIP(context, (uintptr_t)exception->adjustedPtr);
      _Unwind_SetGR(context, 0, (uintptr_t)unwind_exception);
      _Unwind_SetGR(context, 1, (uintptr_t)exception->handlerSwitchValue);
//      assert(!"not implemented");
//      DebugBreak();
#endif

      // Success, now signal installation of the context.
      return _URC_INSTALL_CONTEXT;
    }

    _Unwind_Reason_Code start()
    {
      // Get the current instruction pointer and offset it before next
      // instruction in the current frame which threw the exception.
#if defined(_WIN64)
      pc = _Unwind_GetIP(context)-1;
#else
      pc = _Unwind_GetIP(context);
#endif

      // Get beginning current frame's code (as defined by the
      // emitted dwarf code)
      funct_start = _Unwind_GetRegionStart(context);
      pc_offset = pc - funct_start;

      if (actions & _UA_SEARCH_PHASE)
        return phase1();
      else
        return phase2();

      return _URC_NO_REASON;
    }
  };
}

_Unwind_Reason_Code __seh_cxx_personality_v0(
  int version,
  _Unwind_Action actions,
  uint64 exception_class,
  _Unwind_Exception* unwind_exception,
  _Unwind_Context* context)
{
  if (version != 1) // make sure this is version 1!
    return _URC_FATAL_PHASE1_ERROR;

  DEBUG_PRINT("cpprtl.unwind.personality",
	      ("entering %s, exception_class = 0x%llx\n", __FUNCTION__, exception_class));
//#if defined(_WIN64)
  DEBUG_PRINT("cpprtl.unwind.personality",
	      ("frame pointer = 0x%llx\n", ms_api::frame_pointer(context->disp_ctx)));
//#endif
//  DebugBreak();
  exception_handler handler(
    actions, unwind_exception, context,
    (exception_class != __clang_exception_class) &&
    (exception_class != __clang_dependent_exception_class));
  return handler.start();
}

extern "C" _EXPFUNC _Unwind_Reason_Code __gxx_personality_sj0(
  int version,
  _Unwind_Action actions,
  uint64 exception_class,
  _Unwind_Exception* unwind_exception,
  _Unwind_Context* context) {
  return __seh_cxx_personality_v0(version, actions, exception_class, unwind_exception, context);
}

extern "C" _EXPFUNC _Unwind_Reason_Code __seh_personality_v0(
  int version,
  _Unwind_Action actions,
  uint64 exception_class,
  _Unwind_Exception* unwind_exception,
  _Unwind_Context* context) {
    return __seh_cxx_personality_v0(version, actions, exception_class, unwind_exception, context);
}

_EXPFUNC void __seh_end_filter(unsigned long result, _Unwind_Exception* exception_object)
{
  DEBUG_PRINT("cpprtl.unwind.seh_filter", ("__seh_end_filter: %d\n", result));
  assert(exception_object);
  __cxa_exception* exception =
    __to_cpp_exception(exception_object);

  exception->handlerSwitchValue = result;
  assert(exception->catchTemp);
  ms_api::context* ctx = (ms_api::context*)exception->catchTemp;
//  DebugBreak();
#ifdef _WIN64
  DEBUG_PRINT("cpprtl.unwind.seh_filter", ("restoring RIP to 0x%p\n", ctx->Rip));
  RtlRestoreContext(ctx, 0);
#else
  __seh_restore_context(ctx, 0);
#endif
}

_EXPFUNC extern "C" int __exception_code() {
  return exception_info_context.ExceptionCode;
}

_EXPFUNC extern "C" ms_api::exception_record * __exception_info() {
  return &exception_info_context;
}
