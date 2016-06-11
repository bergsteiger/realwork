/* xxtgamma.h -- common tgamma[fl] functionality */
#include "xmath.h"
_STD_BEGIN

FTYPE FNAME(Tgamma)(FTYPE *, short *);
extern FTYPE FNAME(Gamma_big);

 #if 16384 == FMAXEXP
  #define HUGE_ARG	FLIT(1758.0)	/* ceil(x)+2 for huge <= gamma(x) */

 #elif 1024 == FMAXEXP
  #define HUGE_ARG	FLIT(174.0)

 #elif 128 == FMAXEXP
  #define HUGE_ARG	FLIT(38.0)

 #else /* FMAXEXP */
  #error tgamma has unknnown exponent range
 #endif /* FMAXEXP */

static const FTYPE pi = FLIT(3.14159265358979323846264338327950288);

FTYPE (FFUN(tgamma))(FTYPE x)
	{	/* compute gamma(x) */
	FTYPE y = x;

	switch (FNAME(Dint)(&y, 0))
		{	/* test for special codes */
	case _NANCODE:
		return (x);

	case _INFCODE:
		if (!FISNEG(x))
			return (x);
		else
			{	/* -INF is invalid */
			_Feraise(_FE_INVALID);
			return (FCONST(Nan));
			}

	case 0:
		if (x == FLIT(0.0))
			{	/* gamma(0) is +/-INF */
			_Feraise(_FE_DIVBYZERO);
			return (FISNEG(x) ? -FCONST(Inf) : FCONST(Inf));
			}
		else if (x < FLIT(0.0))
			{	/* x a negative integer, undefined */
			_Feraise(_FE_INVALID);
			return (FCONST(Nan));
			}

	default:	/* result finite, may fall through */
		if (x <= -HUGE_ARG)
			{	/* finite fraction should underflow */
			_Feraise(_FE_UNDERFLOW);
			return (FLIT(0.0));
			}
		else if (x < -FNAME(Gamma_big))
			{	/* large negative, use reflection relation */
			FTYPE z = x;
			FTYPE w = -x - FLIT(1.0);
			short xexp;

			y = x - y;
			FNAME(Dint)(&z, -1);
			if (x - z < FLIT(-1.0))
				y = -y;	/* floor(x) is odd negative integer */
			z = pi / (-x * FNAME(Sin)(pi * y, 0) * (-x - FLIT(1.0)));
			z /= (FLIT(1.0) + FNAME(Tgamma)(&w, &xexp));
			z *= w;

			switch (FNAME(Dscale)(&z, xexp))
				{	/* report over/underflow */
			case 0:
				_Feraise(_FE_UNDERFLOW);
				break;
			case _INFCODE:
				_Feraise(_FE_OVERFLOW);
				}
			return (z);
			}
		else if (x <= HUGE_ARG)
			{	/* finite, evaluate by recurrence */
			short xexp;
			FTYPE y = FNAME(Tgamma)(&x, &xexp);

			x = (FLIT(1.0) + y) / x;
			switch (FNAME(Dscale)(&x, -xexp))
				{	/* report over/underflow */
			case 0:
				_Feraise(_FE_UNDERFLOW);
				break;
			case _INFCODE:
				_Feraise(_FE_OVERFLOW);
				}
			return (x);
			}
		else
			{	/* certain overflow */
			_Feraise(_FE_OVERFLOW);
			return (FCONST(Inf));
			}
		}
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
