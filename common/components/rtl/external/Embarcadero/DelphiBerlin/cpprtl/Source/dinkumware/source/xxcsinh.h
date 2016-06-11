/* xxcsinh.h -- common csinh[fl] functionality */
#include <complex.h>
#include "xmath.h"
_STD_BEGIN

FCTYPE (FFUN(csinh))(FCTYPE x)
	{	/* find complex hyperbolic sine */
	FTYPE re = FFUN(creal)(x);
	FTYPE im = FFUN(cimag)(x);
	short errx = FNAME(Dtest)(&re);
	short erry = FNAME(Dtest)(&im);

	if (errx == _NANCODE)
		if (erry == 0)
			return (FNAME(Cbuild)(FCONST(Nan), im));	/* (NaN, +/-0) */
		else
			return (FNAME(Cbuild)(FCONST(Nan), FCONST(Nan)));
	else if (erry == _INFCODE)
		{	/* (not NaN, +/-Inf) */
		_Feraise(_FE_INVALID);
		if (errx == 0 || errx == _INFCODE)
			return (FNAME(Cbuild)(re,
				FCONST(Nan)));	/* (+/-0 or +/-Inf, +/-Inf) */
		else
			return (FNAME(Cbuild)(FCONST(Nan), FCONST(Nan)));
		}
	else if (erry == _NANCODE)
		if (errx == 0 || errx == _INFCODE)
			return (FNAME(Cbuild)(re,
				FCONST(Nan)));	/* (+/-0 or +/-Inf, NaN) */
		else
			return (FNAME(Cbuild)(FCONST(Nan), FCONST(Nan)));
	else if (errx == _INFCODE)
		if (erry == 0)
			return (FNAME(Cbuild)(re, im));	/* (Inf, +/-0) */
		else
			return (FNAME(Cbuild)(re * FFUN(cos)(im),
				FCONST(Inf) * FFUN(sin)(im)));
	else
		return (FNAME(Cbuild)(FNAME(Sinh)(re, FFUN(cos)(im)),
			FNAME(Cosh)(re, FFUN(sin)(im))));	/* (finite, finite) */
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
