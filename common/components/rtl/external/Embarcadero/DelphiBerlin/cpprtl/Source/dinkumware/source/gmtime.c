/* gmtime function */
#include "xtime.h"
_STD_BEGIN

struct tm *(gmtime)(const time_t *tod)
	{	/* convert to Greenwich Mean Time (UTC) */
	return (_Ttotm(0, *tod, 0));
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
