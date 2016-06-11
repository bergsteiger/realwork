/* xxcsqrt.h -- common csqrt[fl] functionality */
#include <complex.h>
#include "xmath.h"
_STD_BEGIN

FCTYPE (FFUN(csqrt))(FCTYPE x)
	{	/* find complex square root */
	FTYPE re = FFUN(creal)(x);
	FTYPE im = FFUN(cimag)(x);
	short erry = FNAME(Dtest)(&im);
	int xexp;
	FTYPE rho;

	if (erry == _INFCODE)
		return (FNAME(Cbuild)(FCONST(Inf),
			im));	/* (any, +/-INF) => (INF, +/-INF) */
	else if (FNAME(Dtest)(&re) != _INFCODE)
		;
	else if (erry == _NANCODE)
		if (re < FLIT(0.0))
			return (FNAME(Cbuild)(im, re));	/* (-INF, NaN) => (NaN, -INF) */
		else
			return (x);	/* (INF, NaN) => (INF, NaN) */
	else if (re < FLIT(0.0))
		return (FNAME(Cbuild)(FLIT(0.0),
			FISNEG(im) ? -FCONST(Inf)	/* (-INF, <0) => (0, -INF) */
				: FCONST(Inf)));	/* (-INF, >=0) => (0, INF) */
	else
		return (FNAME(Cbuild)(FCONST(Inf),
			FISNEG(im) ? -FNAME(Zero)	/* (INF, <0) => (INF, -0) */
				: FLIT(0.0)));	/* (INF, >=0) => (INF, 0) */

	rho = FNAME(Hypot)(re, im, &xexp);	/* get magnitude and scale factor */
	if (xexp == 0)
		return (FNAME(Cbuild)(rho, im * rho));	/* x is 0, INF, or NaN */
	else
		{	/* compute in safest quadrant */
		FTYPE remag = FFUN(ldexp)(re < FLIT(0.0) ? -re : re, -xexp);

		rho = FFUN(ldexp)(FFUN(sqrt)(FLIT(2.0) * (remag + rho)),
			xexp / 2 - 1);
		if (FLIT(0.0) <= re)
			return (FNAME(Cbuild)(rho, im / (FLIT(2.0) * rho)));
		else if (FISNEG(im))
			return (FNAME(Cbuild)(-im / (FLIT(2.0) * rho), -rho));
		else if (im == FLIT(0.0))
			return (FNAME(Cbuild)(FLIT(0.0), rho));
		else
			return (FNAME(Cbuild)(im / (FLIT(2.0) * rho), rho));
		}
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
