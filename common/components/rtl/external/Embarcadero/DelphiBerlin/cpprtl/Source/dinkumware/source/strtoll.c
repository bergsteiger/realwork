/* strtoll function */
#include <stdlib.h>
_STD_BEGIN

_Longlong (strtoll)(const char *_Restrict s, char **_Restrict endptr,
	int base)
	{	/* convert string to long long, with checking */
	return (_Stoll(s, endptr, base));
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
