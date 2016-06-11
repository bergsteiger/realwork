/* xxctanh.h -- common ctanh[fl] functionality */
#include <complex.h>
#include "xmath.h"
_STD_BEGIN

FCTYPE (FFUN(ctanh))(FCTYPE x)
	{	/* find complex hyperbolic tangent */
	FTYPE re = FFUN(creal)(x);
	FTYPE im = FFUN(cimag)(x);
	short errx = FNAME(Dtest)(&re);
	short erry = FNAME(Dtest)(&im);

	if (errx == _INFCODE)
		return (FNAME(Cbuild)(re < FLIT(0.0) ? FLIT(-1.0) : FLIT(1.0),
			FISNEG(im) ? -FNAME(Zero) : FLIT(0.0)));	/* (+/-Inf, x) */
	else if (erry == _NANCODE)
		return (FNAME(Cbuild)(im, im));	/* (not +/-Inf, NaN) */
	else if (errx == _NANCODE)
		return (FNAME(Cbuild)(re,
			im == FLIT(0.0) ? im : re));	/* (NaN, x) */
	else if (erry == _INFCODE)
		return (FNAME(Cbuild)(FCONST(Nan), FCONST(Nan)));	/* (+/-Inf, x) */
	else
		{	/* (finite, finite) */
		const FTYPE tv = FFUN(tan)(im);
		const FTYPE sv = FFUN(sinh)(re);
		const FTYPE bv = sv * (FLIT(1.0) + tv * tv);
		const FTYPE dv = FLIT(1.0) + bv * sv;

		if (dv == FCONST(Inf))
			return (FNAME(Cbuild)(sv < FLIT(0.0) ? -FLIT(1.0) : FLIT(1.0),
				tv * FLIT(0.0)));
		else
			return (FNAME(Cbuild)(FFUN(sqrt)(FLIT(1.0) + sv * sv) * bv / dv,
				tv / dv));
		}
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
