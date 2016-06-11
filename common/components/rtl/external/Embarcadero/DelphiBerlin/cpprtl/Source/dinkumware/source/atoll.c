/* atoll function */
#include <stdlib.h>
_STD_BEGIN

_Longlong (atoll)(const char *s)
	{	/* convert string to long long */
	return ((_Longlong)_Stoull(s, 0, 10));
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
