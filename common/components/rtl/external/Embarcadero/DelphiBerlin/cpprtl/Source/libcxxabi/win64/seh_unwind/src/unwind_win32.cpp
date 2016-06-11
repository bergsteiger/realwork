#include <_defs.h>
#include <windows.h>

#include <assert.h>

#include <stdint.h>
#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <float.h>		// for _clear87
#include "unwind.h"
#include "InternalMacros.h"
#include "ms_api.hpp"
#include "delphi_support.h"
#include "unwind_cpp_support.hpp"
#include "ms_api.hpp"
#include "diag.h"

INITIALIZE_DEBUG_PRINT_API
INITIALIZE_DEBUG_PRINT_UNWINDING

#define PREGREC_BC void *
#define CONTINUE_SEARCH 1
#define UNWINDING 2

extern "C" void _EH_longjmp(void *);
extern "C" void __rtl_unwind(PEXCEPTION_RECORD excPtr, PREGREC_BC err);

extern "C" void _RaiseWin32Exception(void *object) {
    unsigned long argTable[2];
//    argTable[0] = (unsigned long)object;
    argTable[1] = (unsigned long)object;
//	argTable[1] = (unsigned long)(void __far *)throwPC;
//	argTable[2] = (unsigned long)(void __far *)xdp;

	/* Call the OS to throw the exception */

//	RaiseException(CPP_EXCEPT_CODE,                 // exception code
    RaiseException(ms_api::clang_id,                 // exception code
		       EXCEPTION_NONCONTINUABLE,        // exception flags
		       2,                               // number of arguments
		       argTable);                  // &arguments
}

static _Unwind_Reason_Code unwind_phase2(_Unwind_Context *unwind_context,
					 struct _Unwind_Exception* exception_object,
    PEXCEPTION_RECORD excPtr)
{
    DEBUG_PRINT_UNWINDING("unwind_phase2(ex_ojb=%p)\n", exception_object); 

    bool isHandlerFrame = (uintptr_t)unwind_context->function_context == exception_object->private_2;

// walk each frame until we reach where search phase said to stop
    DEBUG_PRINT_UNWINDING("unwind_phase2s(ex_ojb=%p): function-context=%p\n", exception_object, unwind_context); 

    // if there is a personality routine, tell it we are unwinding
    if ( unwind_context->function_context->personality != NULL ) {
	_Unwind_Action action = _UA_CLEANUP_PHASE;
	if ( (uintptr_t)unwind_context->function_context == exception_object->private_2 )
	    action = (_Unwind_Action)(_UA_CLEANUP_PHASE|_UA_HANDLER_FRAME); // tell personality this was the frame it marked in phase 1
	_Unwind_Reason_Code personalityResult =
	    (*unwind_context->function_context->personality)(1, action, 
							     exception_object->exception_class, exception_object, 
							     unwind_context);
	switch ( personalityResult ) {
	case _URC_CONTINUE_UNWIND:
	    DEBUG_PRINT("cpprtl.unwind.phase2", ("continue unwinding\n"));
	    // continue unwinding
	    DEBUG_PRINT_UNWINDING("unwind_phase2(ex_ojb=%p): _URC_CONTINUE_UNWIND\n", exception_object);
	    if (isHandlerFrame) {
		// phase 1 said we would stop at this frame, but we did not...
		ABORT("during phase1 personality function said it would stop here, but now if phase2 it did not stop here");
	    }
	    return _URC_CONTINUE_UNWIND;
	case _URC_INSTALL_CONTEXT:
	    DEBUG_PRINT("cpprtl.unwind.phase2", ("install context: EIP will be 0x%08x\n",
			    unwind_context->function_context->jbuf[2]));
	    DEBUG_PRINT_UNWINDING("unwind_phase2(ex_ojb=%p): _URC_INSTALL_CONTEXT, will resume at landing pad %p\n", exception_object, unwind_context->function_context->jbuf[1]);
	    // personality routine says to transfer control to landing pad
	    // we may get control back if landing pad calls _Unwind_Resume()
//	    __Unwind_SjLj_SetTopOfFunctionStack(c);
	    if (isHandlerFrame) {
		_EH_longjmp(unwind_context->function_context->jbuf);
	    } else {
		// it's a cleanup frame - we invoke the cleanup, and continue the unwind
		ms_api::context ctx __attribute__((aligned(0x10)));
		uint32_t saved_frame_value = exception_object->private_2;
		exception_object->private_2 = (uintptr_t)&ctx;
		__seh_capture_context(&ctx);
		// _Unwind_Resume will set the private_2 field to zero as a flag
		if (exception_object->private_2) {
		    __invoke_filter_function(_Unwind_GetCFA(unwind_context),
					     exception_object,
					     (uintptr_t)unwind_context->function_context->jbuf[2]);
		} else {
		    // back here via "longjmp" from _Unwind_Resume
		    exception_object->private_2 = saved_frame_value;
		    return _URC_CONTINUE_UNWIND;
		}
	    }
//	    __builtin_longjmp(c->jbuf, 1);
	    // unw_resume() only returns if there was an error
	    return _URC_FATAL_PHASE2_ERROR;
	default:
					// something went wrong
	    DEBUG_MESSAGE("personality function returned unknown result %d", personalityResult);
	    return _URC_FATAL_PHASE2_ERROR;
	}
    }

    // clean up phase did not resume at the frame that the search phase said it would
    return _URC_FATAL_PHASE2_ERROR;
}

namespace System {
    extern __declspec(package) void * (__fastcall *ExceptObjProc)(_EXCEPTION_RECORD *);
}

extern "C" int      ___ExceptionHandler(PEXCEPTION_RECORD excPtr,
					PREGREC_BC        errPtr,
					PCONTEXT          ctxPtr,
					void *            _dspPtr,
					unsigned long     OSEsp,
					unsigned long     /*OSEbp*/,
					unsigned long     /*OSEsi*/,
					unsigned long     /*OSEdi*/,
					unsigned long     /*OSEbx*/,
					unsigned long     flags)
{
    struct _Unwind_Context unwind_context;
    struct _Unwind_FunctionContext *fc = (struct _Unwind_FunctionContext *)errPtr;
    struct _Unwind_Exception* exception_object;
    ms_api::exception_record *x_rec = (ms_api::exception_record *)excPtr;

    DEBUG_PRINT_UNWINDING("unwind_phase1: function-context=%p\n", fc);
    unwind_context.function_context = fc;
    unwind_context.disp_ctx = ctxPtr;

#define SEH_SUPPORT_READY 1   
#if SEH_SUPPORT_READY
    if (!ms_api::is_clang_exception(*x_rec) &&
	!ms_api::is_delphi_exception(*x_rec) &&
	System::ExceptObjProc != NULL) {
	/*
	  An external exception (e.g. AV) came in. The Delphi RTL appears to be
	  present, so we'll fire up ExceptObjProc to get a language exception object,
	  and re-raise the exception as a Delphi exception.
	*/
	// clear the FPU status word to prevent lingering FP exceptions from
	// repeating in case we use FP code while handling the exception.
	// e.g. memset has a code branch using FILD/FIST
	  _clear87();
	void *obj = (System::ExceptObjProc)(x_rec);
	__throw_as_delphi(obj, 0);
    }
#endif // SEH_SUPPORT_READY

    if (ms_api::is_delphi_exception(*x_rec)) {
//	  printf("delphi\n");
//	  DebugBreak();
	void* x = __cxa_allocate_exception(sizeof(ms_api::exception_record));
	*((ms_api::exception_record*)x) = *x_rec; // copy over the whole exception_record!
	DEBUG_PRINT("cpprtl.exceptions.delphi",
		    ("delphi exception intercepted: %p\n",
		     ms_api::get_delphi_exception(*x_rec)));
	__cxa_exception* exception =
	    __initialize_exception(x, NULL, destroy_delphi_exception);
	exception_object = &exception->unwindHeader;
	exception_object->private_1 = 0;
	exception_object->private_2 = 0;
//	unwind_exception->private_1 = clang_id;
//	unwind_exception->private_2 = (uint64) x;
    } else if (ms_api::is_clang_exception(*x_rec)) {
	exception_object = (struct _Unwind_Exception *)excPtr->ExceptionInformation[1];
    } else {
	/*
	  Who knows what this is.  It could be a foreign exception from
	  another language, or it could be a hardware violation of some
	  kind.
	*/
	DEBUG_PRINT("cpprtl.exceptions.foreign",
		    ("foreign exception intercepted: %x\n",
		     x_rec->ExceptionCode));
	_clear87();
	void* x = __cxa_allocate_exception(sizeof(ms_api::exception_record));
	*((ms_api::exception_record*)x) = *x_rec; // copy over the whole exception_record!
	__cxa_exception* exception =
            __initialize_exception(x, NULL, 0);
	exception_object = &exception->unwindHeader;
	exception_object->private_1 = ms_api::clang_id;
	exception_object->private_2 = (uintptr_t) x;
    }

    // if there is a personality routine, ask it if it will want to stop at this frame
    if ( fc->personality != NULL ) {
	DEBUG_PRINT_UNWINDING("unwind_phase1(ex_ojb=%p): calling personality function %p\n", exception_object, fc->personality);
	_Unwind_Reason_Code personalityResult;
	if (excPtr->ExceptionFlags & UNWINDING) {
	    unwind_phase2(&unwind_context, exception_object, excPtr);
	} else {
	    personalityResult = (*fc->personality)(1, _UA_SEARCH_PHASE,
						   exception_object->exception_class, exception_object,
						   &unwind_context);
	}
//	_Unwind_Reason_Code personalityResult = (*fc->personality)(1, _UA_SEARCH_PHASE,
//								  exception_object->exception_class, exception_object,
//								  &unwind_context);
	switch ( personalityResult ) {
	case _URC_HANDLER_FOUND:
	    // found a catch clause or locals that need destructing in this frame
	    // stop search and remember function context
	    exception_object->private_2 = (uintptr_t)fc;
	    DEBUG_PRINT_UNWINDING("unwind_phase1(ex_ojb=%p): _URC_HANDLER_FOUND\n", exception_object);
	    // handle it
	    excPtr->ExceptionFlags |= UNWINDING;
	    DEBUG_PRINT("cpprtl.exceptions.unwind", ("************ calling RTL_UNWIND\n"));
	    __rtl_unwind(excPtr, unwind_context.function_context);
	    DEBUG_PRINT("cpprtl.exceptions.unwind", ("************ done    RTL_UNWIND\n"));
	    unwind_phase2(&unwind_context, exception_object, excPtr);
	    break;
	    
	case _URC_CONTINUE_UNWIND:
	    DEBUG_PRINT_UNWINDING("unwind_phase1(ex_ojb=%p): _URC_CONTINUE_UNWIND\n", exception_object);
	    // continue unwinding
	    break;
	    
	default:
	    // something went wrong
	    DEBUG_PRINT_UNWINDING("unwind_phase1(ex_ojb=%p): _URC_FATAL_PHASE1_ERROR\n", exception_object);
//	    return _URC_FATAL_PHASE1_ERROR;
	    // TODO:  kill the app with a different return code
	    break;
	}
    }
    
    // phase 2: the clean up phase
//    return unwind_phase2(exception_object);
//    if (fc->prev)
//	return CONTINUE_SEARCH;
    return CONTINUE_SEARCH;
}

//extern "C" void	_UnhookERR(struct _Unwind_FunctionContext* fc);

//
// Called at end of each function that catches exceptions
//
//extern "C" _EXPFUNC void _Unwind_SjLj_Unregister(struct _Unwind_FunctionContext* fc)
//{
//  _UnhookERR(fc);
//}

//
// Called by personality handler during phase 2 to get LSDA for current frame
//
extern "C" EXPORT uintptr_t _Unwind_GetLanguageSpecificData(struct _Unwind_Context* context)
{
//	_Unwind_FunctionContext_t ufc = (_Unwind_FunctionContext_t)context;
	DEBUG_PRINT_API("_Unwind_GetLanguageSpecificData(context=%p) => 0x%0lX\n", context,
			context->function_context->lsda);
	return context->function_context->lsda;
}


//
// Called by personality handler during phase 2 to get register values
//
extern "C" EXPORT uintptr_t _Unwind_GetGR(struct _Unwind_Context* context, int index)
{
	DEBUG_PRINT_API("_Unwind_GetGR(context=%p, reg=%d)\n", context, index);
//	_Unwind_FunctionContext_t ufc = (_Unwind_FunctionContext_t)context;
	return context->function_context->resumeParameters[index];
}

//
// Called by personality handler during phase 2 to alter register values
//
extern "C" EXPORT void _Unwind_SetGR(struct _Unwind_Context* context, int index, uintptr_t new_value)
{
	DEBUG_PRINT_API("_Unwind_SetGR(context=%p, reg=%d, value=0x%0lX)\n", context, index, new_value);
//	_Unwind_FunctionContext_t ufc = (_Unwind_FunctionContext_t)context;
	context->function_context->resumeParameters[index] = new_value;
}


//
// Called by personality handler during phase 2 to get instruction pointer
//
EXPORT uintptr_t _Unwind_GetIP(struct _Unwind_Context* context)
{
//	_Unwind_FunctionContext_t ufc = (_Unwind_FunctionContext_t)context;
	DEBUG_PRINT_API("_Unwind_GetIP(context=%p) => 0x%lX\n", context,
			context->function_context->resumeLocation+1);
	return context->function_context->resumeLocation;
}
#if 0
//
// Called by personality handler during phase 2 to get instruction pointer
// ipBefore is a boolean that says if IP is already adjusted to be the call
// site address.  Normally IP is the return address.
//
extern "C" EXPORT uintptr_t _Unwind_GetIPInfo(struct _Unwind_Context* context, int* ipBefore)
{
//	_Unwind_FunctionContext_t ufc = (_Unwind_FunctionContext_t)context;
	*ipBefore = 0;
	DEBUG_PRINT_API("_Unwind_GetIPInfo(context=%p, %p) => 0x%lX\n", context, ipBefore,
			context->function_context->resumeLocation+1);
	return context->function_context->resumeLocation;
}
#endif


//
// Called by personality handler during phase 2 to alter instruction pointer
//
extern "C" EXPORT void _Unwind_SetIP(struct _Unwind_Context* context, uintptr_t new_value)
{
	DEBUG_PRINT_API("_Unwind_SetIP(context=%p, value=0x%0lX)\n", context, new_value);
//	_Unwind_FunctionContext_t ufc = (_Unwind_FunctionContext_t)context;
//	ufc->resumeLocation = new_value-1;
	context->function_context->jbuf[2] = (void *)new_value;
}

//
// Called by personality handler during phase 2 to find the start of the function
//
extern "C" EXPORT uintptr_t _Unwind_GetRegionStart(struct _Unwind_Context* context)
{
	// Not supported or needed for sjlj based unwinding
	DEBUG_PRINT_API("_Unwind_GetRegionStart(context=%p)\n", context);
	return 0;
}

//
// Called by personality handler during phase 2 if a foreign exception is caught 
//
extern "C" EXPORT void _Unwind_DeleteException(struct _Unwind_Exception* exception_object)
{
	DEBUG_PRINT_API("_Unwind_DeleteException(ex_obj=%p)\n", exception_object);
	if ( exception_object->exception_cleanup != NULL )
		(*exception_object->exception_cleanup)(_URC_FOREIGN_EXCEPTION_CAUGHT, exception_object);
}


//
// Called by personality handler during phase 2 to get base address for data relative encodings
//
extern "C" EXPORT uintptr_t _Unwind_GetDataRelBase(struct _Unwind_Context* context)
{
	// Not supported or needed for sjlj based unwinding
	DEBUG_PRINT_API("_Unwind_GetDataRelBase(context=%p)\n", context);
	ABORT("_Unwind_GetDataRelBase() not implemented");
}


//
// Called by personality handler during phase 2 to get base address for text relative encodings
//
extern "C" EXPORT uintptr_t _Unwind_GetTextRelBase(struct _Unwind_Context* context)
{
	// Not supported or needed for sjlj based unwinding
	DEBUG_PRINT_API("_Unwind_GetTextRelBase(context=%p)\n", context);
	ABORT("_Unwind_GetTextRelBase() not implemented");
}



//
// Called by personality handler to get Call Frame Area for current frame.
// This will be EBP saved for the function frame that registered the
// exception handler.  See _Unwind_SjLj_Register in hookerr.asm.
//
extern "C" EXPORT uintptr_t _Unwind_GetCFA(struct _Unwind_Context* context)
{
	DEBUG_PRINT_API("_Unwind_GetCFA(context=%p)\n", context);
	if ( context != NULL ) {
		return (uintptr_t)context->function_context->jbuf[0];
	}
	return 0;
}

//
// Called by __cxa_throw.  Only returns if there is a fatal error
//
extern "C" void _RaiseWin32Exception(void *object);
EXPORT _Unwind_Reason_Code _Unwind_SjLj_RaiseException(struct _Unwind_Exception* exception_object)
{
	DEBUG_PRINT_API("_Unwind_SjLj_RaiseException(ex_obj=%p)\n", exception_object);

	// mark that this is a non-forced unwind, so _Unwind_Resume() can do the right thing
	exception_object->private_1	= 0;
	exception_object->private_2	= 0;

#if 0
	// phase 1: the search phase
	_Unwind_Reason_Code phase1 = unwind_phase1(exception_object);
	if ( phase1 != _URC_NO_REASON )
		return phase1;
	
	// phase 2: the clean up phase
	return unwind_phase2(exception_object);  
#else
	_RaiseWin32Exception(exception_object);
#endif
}


//
// When _Unwind_RaiseException() is in phase2, it hands control
// to the personality function at each frame.  The personality
// may force a jump to a landing pad in that function, the landing
// pad code may then call _Unwind_Resume() to continue with the
// unwinding.  Note: the call to _Unwind_Resume() is from compiler
// geneated user code.  All other _Unwind_* routines are called 
// by the C++ runtime __cxa_* routines. 
//
// Re-throwing an exception is implemented by having the code call
// __cxa_rethrow() which in turn calls _Unwind_Resume_or_Rethrow()
//
EXPORT void _Unwind_SjLj_Resume(struct _Unwind_Exception* exception_object)
{
	DEBUG_PRINT_API("_Unwind_SjLj_Resume(ex_obj=%p)\n", exception_object);

#if 0	
	if ( exception_object->private_1 != 0 ) 
		unwind_phase2_forced(exception_object, (_Unwind_Stop_Fn)exception_object->private_1, (void*)exception_object->private_2);  
	else
		unwind_phase2(exception_object);
#else
	ms_api::context *ctx;
	ctx = (ms_api::context *)exception_object->private_2;
	exception_object->private_2 = 0;
	__seh_restore_context(ctx, 0);
#endif
	
	// clients assume _Unwind_Resume() does not return, so all we can do is abort.
	ABORT("_Unwind_SjLj_Resume() can't return");
}

//FIXME: hacked in this stub
extern "C" EXPORT void _Unwind_Resume(struct _Unwind_Exception* exception_object)
{
    _Unwind_SjLj_Resume(exception_object);
}

extern "C" EXPORT _Unwind_Reason_Code _Unwind_RaiseException(struct _Unwind_Exception* exception_object)
{
    _Unwind_SjLj_RaiseException(exception_object); // won't really return
    return _URC_NO_REASON;
}

// FIXME: hacking linkage issues in type info for the _very_ short term.
// see tinfo and tinfo2
int _ZTVN10__cxxabiv123__fundamental_type_infoE;
int _ZTVN10__cxxabiv120__si_class_type_infoE;
int _ZTVN10__cxxabiv117__class_type_infoE;
