/* xxcexp.h -- common cexp[fl] functionality */
#include <complex.h>
#include "xmath.h"
_STD_BEGIN

FCTYPE (FFUN(cexp))(FCTYPE x)
	{	/* find complex exponential */
	FTYPE re = FFUN(creal)(x);
	FTYPE im = FFUN(cimag)(x);
	short errx = FNAME(Dtest)(&re);
	short erry = FNAME(Dtest)(&im);
	FTYPE zre, zim;

	if (errx == _NANCODE)
		if (erry == 0)
			{	/* (NaN, +/-0) */
			zre = re;
			zim = im;
			}
		else
			{	/* (NaN, not zero) */
			zre = re;
			zim = re;
			}
	else if (erry == _NANCODE)
		if (errx == _INFCODE)
			if (re < FLIT(0.0))
				{	/* (-Inf, NaN) */
				zre = FLIT(0.0);
				zim = FLIT(0.0);
				}
			else
				{	/* (Inf, NaN) */
				zre = re;
				zim = im;
				}
		else
			{	/* (not Inf or Nan, NaN) */
			zre = im;
			zim = im;
			}
	else if (errx == _INFCODE)
		if (re < FLIT(0.0))
			if (erry == _INFCODE)
				{	/* (-Inf, +/-Inf) */
				zre = FLIT(0.0);
				zim = im < FLIT(0.0) ? -FNAME(Zero) : FLIT(0.0);
				}
			else
				{	/* (-Inf, finite) */
				zre = FLIT(0.0) * FFUN(cos)(im);
				zim = FLIT(0.0) * FFUN(sin)(im);
				}
		else
			if (erry == _INFCODE)
				{	/* (Inf, +/-Inf) */
				_Feraise(_FE_INVALID);
				zre = re;
				zim = FCONST(Nan);
				}
			else if (erry == 0)
				{	/* (Inf, +/-0) */
				zre = re;
				zim = im;
				}
			else
				{	/* (Inf, finite nonzero) */
				zre = re * FFUN(cos)(im);
				zim = re * FFUN(sin)(im);
				}
	else if (erry == _INFCODE)
		{	/* (finite, +/-Inf) */
		_Feraise(_FE_INVALID);
		zre = FCONST(Nan);
		zim = FCONST(Nan);
		}
	else
		{	/* (finite, finite) */
		zre = re;
		zim = re;
		FNAME(Exp)(&zre, FFUN(cos)(im), 0);
		FNAME(Exp)(&zim, FFUN(sin)(im), 0);
		}
	return (FNAME(Cbuild)(zre, zim));
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
