/* xxtrunc.h -- common trunc[fl] functionality */
#include "xmath.h"
_STD_BEGIN

FTYPE (FFUN(trunc))(FTYPE x)
	{	/* truncate x toward zero */
	FNAME(Dint)(&x, 0);
	return (x);
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
