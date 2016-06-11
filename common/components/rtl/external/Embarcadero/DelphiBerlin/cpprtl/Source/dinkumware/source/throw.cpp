// throw -- terminate on thrown exception REPLACEABLE
#include <cstdio>
#include <cstdlib>
#include <exception>
_STD_BEGIN

_CRTIMP2 void _Debug_message(const char *s1, const char *s2)
	{	// report error and die
	_CSTD fflush(0);
	_CSTD fputs(s1, stderr);
	_CSTD fputs(s2 != 0 ? s2 : "unknown", stderr);
	_CSTD fputs("\n", stderr);
	_CSTD abort();
	}
_STD_END

 #if __GNUC__ < 3 && !defined(__APPLE__) && !defined(__MINGW32__)
_X_STD_BEGIN

 #else /* __GNUC__ < 3 && !defined(__APPLE__) && !defined(__MINGW32__) */
namespace std {
 #endif /* __GNUC__ < 3 && !defined(__APPLE__) && !defined(__MINGW32__) */

_CRTIMP2 void _Throw(const exception& ex)
	{	// report throw exception and die
	_STD _Debug_message("exception: ", ex.what());
	}

 #if __GNUC__ < 3 && !defined(__APPLE__) && !defined(__MINGW32__)
_X_STD_END

 #else /* __GNUC__ < 3 && !defined(__APPLE__) && !defined(__MINGW32__) */
} /* namespace std */
 #endif /* __GNUC__ < 3 && !defined(__APPLE__) && !defined(__MINGW32__) */

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
