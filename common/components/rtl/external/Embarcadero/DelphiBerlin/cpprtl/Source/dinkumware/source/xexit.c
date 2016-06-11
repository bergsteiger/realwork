/* _Exit function */
#include <yvals.h>

 #if defined(__MWERKS__)
  #define _exit	__exit
 #endif

_STD_BEGIN
_NO_RETURN(_exit(int));
_NO_RETURN(_Exit(int status));

void _Exit(int status)
	{	/* call _exit */
	_exit(status);
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
