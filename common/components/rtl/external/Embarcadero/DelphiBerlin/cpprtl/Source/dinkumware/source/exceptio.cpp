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

_CRTIMP2 terminate_handler
	set_terminate(terminate_handler pnew) _THROW0()
	{	// store terminate handler pointer, return old
	_Lockit lock(_LOCK_MALLOC);
	terminate_handler pold = _Term_handler;
	_Term_handler = pnew;
	return (pold);
	}

//_CRTIMP2 void _NO_RETURN terminate()
_CRTIMP2_NR void terminate()
	{	// call terminate handler or abort
	if (_Term_handler != 0)
		(*_Term_handler)();
	abort();
	}

 #if __GNUC__ < 4
static unexpected_handler _Unex_handler = &terminate;

_CRTIMP2 unexpected_handler
	set_unexpected(unexpected_handler pnew) _THROW0()
	{	// store unexpected handler pointer, return old
	_Lockit lock(_LOCK_MALLOC);
	unexpected_handler pold = _Unex_handler;
	_Unex_handler = pnew;
	return (pold);
	}

_CRTIMP2 void unexpected()
	{	// call unexpected handler or terminate
	if (_Unex_handler != 0)
		(*_Unex_handler)();
	terminate();
	}
 #endif /* __GNUC__ < 4 */

 #if __GNUC__ < 3 && !defined(__APPLE__) && !defined(__MINGW32__)
_X_STD_END

 #else /* __GNUC__ < 3 && !defined(__APPLE__) && !defined(__MINGW32__) */
} /* namespace std */
 #endif /* __GNUC__ < 3 && !defined(__APPLE__) && !defined(__MINGW32__) */

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
