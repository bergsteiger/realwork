/* xxsinh.h -- common sinh[fl] functionality */
#include "xmath.h"
_STD_BEGIN

_CRTIMP2 FTYPE (FFUN(sinh))(FTYPE x)
	{	/* compute sinh(x) */
	return (FNAME(Sinh)(x, FLIT(1.0)));
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
