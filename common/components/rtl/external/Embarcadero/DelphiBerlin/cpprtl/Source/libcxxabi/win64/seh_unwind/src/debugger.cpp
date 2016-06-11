#include <windows.h>

#include <typeinfo>
#include <exception>

#include <stdio.h>

#include "delphi_support.h"
#include "../include/debugger.h"

/*
  Enable BYPASS_WINDOWS if you want to debug this code.  Enables the hooks,
  and changes the exception dispatching to debug dumps.
 */
//#define BYPASS_WINDOWS

extern int __CPPdebugHook;
int *__pCPPdebugHook = &__CPPdebugHook;

//int dummy = 1;

void    __initCPPdebugHook(void)
{
	__pCPPdebugHook = (int *)GetProcAddress(GetModuleHandleA(0), "__CPPdebugHook");

	if      (!__pCPPdebugHook)
		__pCPPdebugHook = &__CPPdebugHook;
//	__pCPPdebugHook = &dummy;
}
#pragma startup __initCPPdebugHook 0 /* Initializes the IDE debugger hook */

//#define BYPASS_WINDOWS
#ifdef BYPASS_WINDOWS
extern "C" void bypassRaiseException(
    DWORD dwExceptionCode,
    DWORD dwExceptionFlags,
    DWORD nNumberOfArguments,
    const ULONG_PTR *lpArguments
    ) {
    printf("RaiseException: 0x%x, flags(0x%x), param count = %d\n",
	   dwExceptionCode, dwExceptionFlags, nNumberOfArguments);
    for (int i = 0; i < nNumberOfArguments; i++) {
	printf("  param[%d] = %p\n", i, lpArguments[i]);
    }
}
#define RaiseException bypassRaiseException
#endif // BYPASS_WINDOWS
static const char *get_type_name(std::type_info const *tinfo) {
    static char buff[256];
    const char *name;

    if (!tinfo)
	return NULL;
    if (is_delphi_type((void const *)tinfo)) {
	name = *(const char **)tinfo + 1;
	strncpy(buff, name + 1, *name);
	name = &buff[0];
    } else {
	name = tinfo->name();
    }
    return name;
}

void __notifyThrow(void *obj, std::type_info* tinfo) {
    if (*__pCPPdebugHook) {
	ULONG_PTR params[6];

	const char *name = get_type_name(tinfo);

//	printf("__notifyThrow(%p, %s)\n", obj, name);

//	DebugBreak();
//	printf("throwing an exception: %s\n", tinfo ? *(((const char **)tinfo)+1) : "<null>");
//	printf("throwing an exception: %s\n", tinfo ? tinfo->name() : "<null>");
	params[0] = (ULONG_PTR)XXDNthrow;
	params[1] = 0; // old, not applicable to Win64
	params[2] = 0; // old, not applicable to Win64
	params[3] = (ULONG_PTR)name;
	params[4] = (ULONG_PTR)strlen(name);
	params[5] = (ULONG_PTR)obj;
	RaiseException(_DELPHI_DEBUGGER_XCPT_CODE,
		       EXCEPTION_NONCONTINUABLE,
		       6,
		       params);
    }
}

void __notifyCatch(void *obj, std::type_info** ptinfo, void *handlerAddr) {
    if (*__pCPPdebugHook) {
	const char *name;
	ULONG_PTR params[6];
	std::type_info* tinfo;
#if defined(__WIN32__)
	tinfo = (std::type_info *)ptinfo;
#else
	tinfo = ptinfo ? *ptinfo : NULL;
#endif
	name = get_type_name(tinfo);
//	printf("__notifyCatch(%p, %s, %p)\n", obj, name, handlerAddr);

//	DebugBreak();
//	printf("catching an exception: %s\n", tinfo ? *(((const char **)tinfo)+1) : "<null>");
	params[0] = (ULONG_PTR)XXDNcatch;
	params[1] = 0; // old, not applicable to Win64
	params[2] = (ULONG_PTR)handlerAddr;
	params[3] = (ULONG_PTR)name;
	params[4] = name ? (ULONG_PTR)strlen(name) : 0;
	params[5] = (ULONG_PTR)obj;
	RaiseException(_DELPHI_DEBUGGER_XCPT_CODE,
		       EXCEPTION_NONCONTINUABLE,
		       6,
		       params);
    }
}

void __notifyCatchTerminate() {
    if (*__pCPPdebugHook) {
    }
}
