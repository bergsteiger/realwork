/* xxacos.h -- common acos[fl] functionality */
#include "xmath.h"
_C_LIB_DECL

 #if FBITS <= 24
  #define SPOLY(x)	(((((s[0] * x + s[1]) * x + s[2]) * x \
	+ s[3]) * x + s[4]) * x + s[5])

_STATIC_CONST FTYPE s[] = {	/* acos(x)=POLY(x)/sqrt(1-x) */
	FLIT( 0.1419156502e-2),
	FLIT( 0.2531873677e-2),
	FLIT( 0.7916136913e-2),
	FLIT( 0.2651478708e-1),
	FLIT( 0.1178511743),
	FLIT( 1.4142135621),
	};
 #endif /* FBITS */

_STATIC_CONST FTYPE pi = FLIT(3.1415926535897932384626433832795029);
_STATIC_CONST FTYPE rthalf = FLIT(0.70710678118654752440084436210484905);

FTYPE (_CDECL FFUN(acos))(FTYPE x)
	{	/* compute acos(x) */
	unsigned short hex;

	switch (FNAME(Dtest)(&x))
		{	/* test for special codes */
	case _NANCODE:
		return (x);

	default:	/* 0, FINITE, or INF */
		if (x < FLIT(0.0))
			{	/* make positive and remember sign */
			FNEGATE(x);
			hex = 0x4;
			}
		else
			hex = 0x2;

		if (x <= rthalf)
			return (FNAME(Atan)(FDIV(x, FFUN(sqrt)((FLIT(1.0) - x)
				* (FLIT(1.0) + x))), hex));

 #ifdef SPOLY
		else if (x <= FLIT(1.0))
			{	/* compute close to 1 */
			FTYPE eps = FLIT(1.0) - x;

			x = SPOLY(eps) * FFUN(sqrt)(eps);

			if (hex == 0x4)
				return (pi - x);
			else
				return (x);
			}

 #else /* SPOLY */
		else if (x <= FLIT(1.0))
			return (FNAME(Atan)(FDIV(FFUN(sqrt)((FLIT(1.0) - x)
				* (FLIT(1.0) + x)), x), hex ^ 0x2));
 #endif /* SPOLY */

		else
			{	/* 1 < |x| */
			_Feraise(_FE_INVALID);
			return (FCONST(Nan));
			}
		}
	}
_END_C_LIB_DECL

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
