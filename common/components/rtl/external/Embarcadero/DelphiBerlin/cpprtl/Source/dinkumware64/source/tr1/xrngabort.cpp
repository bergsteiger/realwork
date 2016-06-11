// xrngabort: abort on precondition failure in TR1 random number generators
#include <yvals.h>

 #if _HAS_TR1
  #include <stdlib.h>
  #include <stdio.h>
//  #include <random>

_STD_BEGIN
_CRTIMP2P _NO_RETURN(_PCDECL _Rng_abort(const char *_Msg));

void _PCDECL _Rng_abort(const char *msg)
	{	/* abort on precondition failure */
	_CSTD fputs(msg, stderr);
	_CSTD fputc('\n', stderr);
	_CSTD abort();
	}
_STD_END
 #endif /* _HAS_TR1 */

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
