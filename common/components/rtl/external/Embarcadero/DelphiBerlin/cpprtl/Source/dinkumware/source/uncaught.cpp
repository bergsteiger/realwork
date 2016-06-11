// uncaught -- dummy uncaught_exception
#include <exception>

 #if __GNUC__ < 3 && !defined(__APPLE__) && !defined(__MINGW32__)
_X_STD_BEGIN

_CRTIMP2 bool uncaught_exception() _THROW0()
	{	// report if handling a throw
	return (false);
	}
_X_STD_END

 #else /* __GNUC__ < 3 && !defined(__APPLE__) && !defined(__MINGW32__) */
namespace std {

_CRTIMP2 bool uncaught_exception() _THROW0()
	{	// report if handling a throw
	return (false);
	}
} /* namespace std */
 #endif /* __GNUC__ < 3 && !defined(__APPLE__) && !defined(__MINGW32__) */

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
