/* clock function -- simple version */
#include "xtime.h"
_STD_BEGIN

clock_t (clock)(void)
	{	/* return CPU time */
	return ((clock_t)time(0));
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
