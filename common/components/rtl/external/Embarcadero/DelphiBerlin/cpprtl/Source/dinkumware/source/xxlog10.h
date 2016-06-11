/* xxlog10.h -- common log10[fl] functionality */
#include "xmath.h"
_STD_BEGIN

FTYPE (FFUN(log10))(FTYPE x)
	{	/* compute ln(x) */
	return (FNAME(Log)(x, 1));
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
