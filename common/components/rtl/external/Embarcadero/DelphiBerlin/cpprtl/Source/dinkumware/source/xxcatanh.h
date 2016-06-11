/* xxcatanh.h -- common catanh[fl] functionality */
#include <complex.h>
#include "xmath.h"
_STD_BEGIN

FTYPE FFUN(log1p)(FTYPE);

 #if FMAXEXP <= 128
static const FTYPE big = FLIT(4.61e18);	/* ~sqrt(FLT_MAX)/4 */

 #elif FMAXEXP <= 1024
static const FTYPE big = FLIT(3.35e153);	/* ~sqrt(FLT_MAX)/4 */

 #elif FMAXEXP <= 16384
static const FTYPE big = FLIT(3.50e246);	/* ~sqrt(FLT_MAX)/4 */

 #else /* FMAXEXP */
  #error catanh has insufficient range
 #endif /* FMAXEXP */

static const FTYPE piby2 = FLIT(1.5707963267948966192313216916397514);

FCTYPE (FFUN(catanh))(FCTYPE x)
	{	/* compute complex hyperbolic arctangent */
	FTYPE re = FFUN(creal)(x);
	FTYPE im = FFUN(cimag)(x);
	short errx = FNAME(Dtest)(&re);
	short erry = FNAME(Dtest)(&im);
	FTYPE u, v;

	if (errx == _NANCODE)
		if (erry == _NANCODE)
			{	/* (NaN, NaN) */
			u = re;
			v = im;
			}
		else if (erry == _INFCODE)
			{	/* (NaN, +/-Inf) */
			u = FLIT(0.0);
			v = im < FLIT(0.0) ? -piby2 : piby2;
			}
		else
			{	/* (NaN, finite) */
			u = re;
			v = re;
			}
	else if (erry == _NANCODE)
		if (errx == _INFCODE || errx == 0)
			{	/* (+/-Inf or +/-0, NaN) */
			u = FISNEG(re) ? -FNAME(Zero) : FLIT(0.0);
			v = im;
			}
		else
			{	/* (finite, NaN) */
			u = im;
			v = im;
			}
	else if (errx == _INFCODE)
		{	/* (+/-Inf, not NaN) */
		u = re < FLIT(0.0) ? -FNAME(Zero) : FLIT(0.0);
		v = FISNEG(im) ? -piby2 : piby2;
		}
	else
		{	/* (not NaN, not NaN): compute atanh */
		int neg;
		FTYPE magim = FISNEG(im) ? -im : im;

		if (re < FLIT(0.0))
			{	/* creal(x) < 0 */
			neg = 1;
			re = -re;
			}
		else
			{	/* 0 <= creal(x) */
			neg = 0;
			im = -im;
			}

		if (big < re)
			{	/* |re| is large */
			FTYPE f = im / re;

			u = FLIT(1.0) / re / (FLIT(1.0) + f * f);	/* creal(1/x) */
			v = im < FLIT(0.0) ? -piby2 : piby2;
			}
		else if (big < magim)
			{	/* |im| is large */
			FTYPE f = re / im;	/* creal(1 / x) */

			u = f / im / (FLIT(1.0) + f * f);
			v = im < FLIT(0.0) ? -piby2 : piby2;
			}
		else if (re != FLIT(1.0))
			{	/* |re| is small */
			FTYPE refrom1 = FLIT(1.0) - re;
			FTYPE imeps2 = magim * magim;

			u = FLIT(0.25) * FFUN(log1p)(FLIT(4.0) * re
				/ (refrom1 * refrom1 + imeps2));
			v = FLIT(0.5) * FFUN(atan2)(FLIT(2.0) * im,
				refrom1 * (FLIT(1.0) + re) - imeps2);
			}
		else if (im == FLIT(0.0))
			{	/* {+/-1, 0) */
			_Feraise(_FE_DIVBYZERO);
			u = FCONST(Inf);
			v = im;
			}
		else
			{	/* {+/-1, nonzero) */
			u = FFUN(log)(FFUN(sqrt)(FFUN(sqrt)(FLIT(4.0) + im * im))
				/ FFUN(sqrt)(magim));
			v = FLIT(0.5) * (piby2 + FFUN(atan2)(magim, FLIT(2.0)));
			if (im < FLIT(0.0))
				v = -v;
			}

		if (neg)
			u = -u;
		else
			v = -v;
		}
	return (FNAME(Cbuild)(u, v));
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
