// exception -- exception handlers
#include <cstdlib>
#include <exception>

 #if __GNUC__ < 3 && !defined(__APPLE__) && !defined(__MINGW32__)
_X_STD_BEGIN
 #else /* __GNUC__ < 3 && !defined(__APPLE__) && !defined(__MINGW32__) */
namespace std {
 #endif /* __GNUC__ < 3 && !defined(__APPLE__) && !defined(__MINGW32__) */

static void do_abort()
	{	// call abort (sidestepping linkage issues)
	abort();
	}

static terminate_handler _Term_handler = (terminate_handler)&do_abort;

 #if defined(__CYGWIN__)

 #else /* defined(__CYGWIN__) */

 #if 0	/* kludge version in <exception> */
terminate_handler
	get_terminate() _NOEXCEPT
	{	// get terminate handler pointer, return old
	_Lockit lock(_LOCK_MALLOC);
	return (_Term_handler);
	}
 #endif /* 0 */

_CRTIMP2 terminate_handler
	set_terminate(terminate_handler pnew) _THROW0()
	{	// store terminate handler pointer, return old
	_Lockit lock(_LOCK_MALLOC);
	terminate_handler pold = _Term_handler;
	_Term_handler = pnew;
	return (pold);
	}

_CRTIMP2_NR void terminate() _NOEXCEPT
	{	// call terminate handler or abort
	if (_Term_handler != 0)
		(*_Term_handler)();
	abort();
	}
 #endif /* defined(__CYGWIN__) */

 #if __GNUC__ < 4 || defined(_SA_LIB)
static unexpected_handler _Unex_handler = &terminate;

 #if 0	/* kludge version in <exception> */
unexpected_handler
	get_unexpected() _NOEXCEPT
	{	// get unexpected handler pointer, return old
	_Lockit lock(_LOCK_MALLOC);
	return (_Unex_handler);
	}
 #endif /* 0 */

_CRTIMP2 unexpected_handler
	_CDECL set_unexpected(unexpected_handler pnew) _THROW0()
	{	// store unexpected handler pointer, return old
	_Lockit lock(_LOCK_MALLOC);
	unexpected_handler pold = _Unex_handler;
	_Unex_handler = pnew;
	return (pold);
	}

_CRTIMP2_NR void _CDECL unexpected()
	{	// call unexpected handler or terminate
	if (_Unex_handler != 0)
		(*_Unex_handler)();
	terminate();
	}

 #if defined(_SA_LIB)
 bool _Uncaught() _THROW0();
 
bool uncaught_exception() _THROW0()
 	{	/* dispatch uncaught exception to handler */
 	return (_Uncaught());
 	}
 #endif	/* defined(_SA_LIB) */

 #endif /* __GNUC__ < 4 || defined(_SA_LIB) */

 #if __GNUC__ < 3 && !defined(__APPLE__) && !defined(__MINGW32__)
_X_STD_END

 #else /* __GNUC__ < 3 && !defined(__APPLE__) && !defined(__MINGW32__) */
} /* namespace std */
 #endif /* __GNUC__ < 3 && !defined(__APPLE__) && !defined(__MINGW32__) */

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
