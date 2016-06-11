/* xxasin.h -- common asin[fl] functionality */
#include "xmath.h"
_STD_BEGIN

FTYPE (FFUN(asin))(FTYPE x)
	{	/* compute asin(x) */
	static const FTYPE rthalf = FLIT(0.70710678118654752440084436210484905);
	unsigned short hex;

	switch (FNAME(Dtest)(&x))
		{	/* test for special codes */
	case _NANCODE:
	case 0:
		return (x);
	default:	/* FINITE or INF */
		if (x < FLIT(0.0))
			x = -x, hex = 0x8;
		else
			hex = 0x0;
		if (x <= rthalf)
			return (FNAME(Atan)(x / FFUN(sqrt)((FLIT(1.0) - x)
				* (FLIT(1.0) + x)), hex));
		else if (x <= FLIT(1.0))
			return (FNAME(Atan)(FFUN(sqrt)((FLIT(1.0) - x)
				* (FLIT(1.0) + x)) / x, hex ^ 0x2));
		else
			{	/* 1 < |x| */
			_Feraise(_FE_INVALID);
			return (FCONST(Nan));
			}
		}
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
