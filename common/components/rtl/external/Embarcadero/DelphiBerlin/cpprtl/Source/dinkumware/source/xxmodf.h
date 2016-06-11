/* xxmodf.h -- common modf[fl] functionality */
#include "xmath.h"
_STD_BEGIN

FTYPE (FFUN(modf))(FTYPE x, FTYPE *pint)
	{	/* compute modf(x, &intpart) */
	*pint = x;
	switch (FNAME(Dint)(pint, 0))
		{	/* test for special codes */
	case _NANCODE:
		return (x);
	case _INFCODE:
	case 0:
		return (FISNEG(x) ? -FNAME(Zero) : FLIT(0.0));
	default:	/* finite */
		return (x - *pint);
		}
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
