// raisehan -- pointer to raise handler
#include <exception>

 #if __GNUC__ < 3 && !defined(__APPLE__) && !defined(__MINGW32__)
_X_STD_BEGIN
 #else /* __GNUC__ < 3 && !defined(__APPLE__) && !defined(__MINGW32__) */
namespace std {
 #endif /* __GNUC__ < 3 && !defined(__APPLE__) && !defined(__MINGW32__) */

_Prhand _Raise_handler = 0;	// define raise handler pointer

 #if __GNUC__ < 3 && !defined(__APPLE__) && !defined(__MINGW32__)
_X_STD_END

 #else /* __GNUC__ < 3 && !defined(__APPLE__) && !defined(__MINGW32__) */
} /* namespace std */
 #endif /* __GNUC__ < 3 && !defined(__APPLE__) && !defined(__MINGW32__) */

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
