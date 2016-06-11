// raisehan -- pointer to raise handler
#include <exception>

 #if __GNUC__ < 3 && !defined(__APPLE__) && !defined(__MINGW32__)
_X_STD_BEGIN

 #else /* __GNUC__ < 3 && !defined(__APPLE__) && !defined(__MINGW32__) */
namespace std {
 #endif /* __GNUC__ < 3 && !defined(__APPLE__) && !defined(__MINGW32__) */

_CRTIMP2 _Prhand _Raise_handler = 0;	// define raise handler pointer

 #if __GNUC__ < 3 && !defined(__APPLE__) && !defined(__MINGW32__)
_X_STD_END

 #else /* __GNUC__ < 3 && !defined(__APPLE__) && !defined(__MINGW32__) */
} /* namespace std */
 #endif /* __GNUC__ < 3 && !defined(__APPLE__) && !defined(__MINGW32__) */

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
