/* strtoull function */
#include <stdlib.h>
#include "xmath.h"
_STD_BEGIN

_ULonglong (strtoull)(const char *_Restrict s,
	char **_Restrict endptr, int base)
	{	/* convert string to unsigned long long, with checking */
	return (_Stoull(s, endptr, base));
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
