/* xxacos.h -- common acos[fl] functionality */
#include "xmath.h"
_STD_BEGIN

FTYPE (FFUN(acos))(FTYPE x)
	{	/* compute acos(x) */
	static const FTYPE rthalf = FLIT(0.70710678118654752440084436210484905);
	unsigned short hex;

	switch (FNAME(Dtest)(&x))
		{	/* test for special codes */
	case _NANCODE:
		return (x);
	default:	/* 0, FINITE, or INF */
		if (x < FLIT(0.0))
			x = -x, hex = 0x4;
		else
			hex = 0x2;
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
