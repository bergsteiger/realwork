// xrngabort: abort on precondition failure in TR1 random number generators
#include <yvals.h>

 #if _HAS_TR1
  #include <stdlib.h>
  #include <stdio.h>
  #include <random>

_STD_BEGIN
	namespace tr1 {	// TR1 additions

void _CRTIMP2 _Rng_abort(const char *msg)
	{	/* abort on precondition failure */
	fputs(msg, stderr);
	fputc('\n', stderr);
	abort();
	}

	}	// namespace tr1
_STD_END
 #endif /* _HAS_TR1 */

/*
 * Copyright (c) 1992-2008 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
