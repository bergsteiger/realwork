/* xxcproj.h -- common cproj[fl] functionality */
#include <complex.h>
#include "xmath.h"
_STD_BEGIN

FCTYPE (FFUN(cproj))(FCTYPE x)
	{	/* find projection onto Riemann sphere */
	FTYPE re = FFUN(creal)(x);
	FTYPE im = FFUN(cimag)(x);
	const short err_re = FNAME(Dtest)(&re);
	const short err_im = FNAME(Dtest)(&im);

	return (err_re != _INFCODE && err_im != _INFCODE ? x
		: FNAME(Cbuild)(FCONST(Inf), FISNEG(im) ? -FNAME(Zero) : FLIT(0.0)));
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
