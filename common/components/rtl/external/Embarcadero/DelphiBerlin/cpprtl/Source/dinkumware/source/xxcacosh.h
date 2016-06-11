/* xxcacosh.h -- common cacosh[fl] functionality */
#include <complex.h>
#include "xmath.h"
_STD_BEGIN

FTYPE FFUN(asinh)(FTYPE);

 #if FMAXEXP <= 128
static const FTYPE big = FLIT(4.61e18);	/* ~sqrt(FLT_MAX)/4 */

 #elif FMAXEXP <= 1024
static const FTYPE big = FLIT(3.35e153);	/* ~sqrt(FLT_MAX)/4 */

 #elif FMAXEXP <= 16384
static const FTYPE big = FLIT(3.50e246);	/* ~sqrt(FLT_MAX)/4 */

 #else /* FMAXEXP */
  #error catanh has insufficient range
 #endif /* FMAXEXP */

static const FTYPE pi = FLIT(3.1415926535897932384626433832795029);
static const FTYPE pi3by4 = FLIT(2.3561944901923449288469825374596271);
static const FTYPE piby2 = FLIT(1.5707963267948966192313216916397514);
static const FTYPE piby4 = FLIT(0.78539816339744830961566084581987572);

FCTYPE (FFUN(cacosh))(FCTYPE x)
	{	/* compute complex hyperbolic arccosine */
	FTYPE re = FFUN(creal)(x);
	FTYPE im = FFUN(cimag)(x);
	const short errx = FNAME(Dtest)(&re);
	const short erry = FNAME(Dtest)(&im);
	FTYPE u, v;

	if (errx == _NANCODE)
		if (erry == _NANCODE)
			{	/* (NaN, NaN or 0) */
			u = re;
			v = im;
			}
		else if (erry == _INFCODE)
			{	/* (NaN, +/-Inf) */
			u = FCONST(Inf);
			v = re;
			}
		else
			{	/* (NaN, non-zero finite) */
			u = re;
			v = re;
			}
	else if (erry == _NANCODE)
		if (errx == _INFCODE)
			{	/* (+/-Inf, NaN) */
			u = FCONST(Inf);
			v = im;
			}
		else
			{	/* (finite, NaN) */
			u = im;
			v = im;
			}
	else if (errx == _INFCODE)
		{	/* (+/-Inf, not NaN) */
		u = FCONST(Inf);
		if (erry == _INFCODE)
			if (re < FLIT(0.0))
				v = pi3by4;	/* (-Inf, +/-Inf) */
			else
				v = piby4;	/* (+Inf, finite) */
		else
			if (re < FLIT(0.0))
				v = pi;	/* (-Inf, finite) */
			else
				v = FLIT(0.0);	/* (+Inf, finite) */
		if (FISNEG(im))
			v = -v;
		}
	else if (erry == _INFCODE)
		{	/* (finite, +/-Inf) */
		u = FCONST(Inf);
		v = im < FLIT(0.0) ? -piby2 : piby2;
		}
	else
		{	/* {finite, finite) */
		const FCTYPE w = FFUN(csqrt)(FNAME(Cbuild)(re - FLIT(1.0), -im));
		const FCTYPE z = FFUN(csqrt)(FNAME(Cbuild)(re + FLIT(1.0), im));
		const FTYPE wr = FFUN(creal)(w);
		const FTYPE wi = FFUN(cimag)(w);
		const FTYPE zi = FFUN(cimag)(z);
		const FTYPE zr = FFUN(creal)(z);
		int neg = 1;
		FTYPE alfa, beta;

		if (big < wr)
			{	/* real parts large */
			alfa = wr;
			beta = zr - wi * (zi / alfa);
			}
		else if (big < wi)
			{	/* imag parts large */
			alfa = wi;
			beta = wr * (zr / alfa) - zi;
			}
		else if (big < -wi)
			{	/* imag part of w large negative */
			alfa = -wi;
			beta = wr * (zr / alfa) - zi;
			}
		else
			{	/* shouldn't overflow */
			alfa = FLIT(0.0);
			beta = wr * zr - wi * zi;	/* Re(w * z) */
			}

		u = FFUN(asinh)(beta);
		if (alfa == FLIT(0.0))
			;
		else if (FLIT(0.0) <= u)
			u += FFUN(log)(alfa);
		else
			u -= FFUN(log)(alfa);	/* asinh(a*b) = asinh(a)+log(b) */

		if (FISNEG(im))
			im = -im;
		else
			neg = 0;
		v = FLIT(2.0) * FFUN(atan2)(
			FFUN(cimag)(FFUN(csqrt)(FNAME(Cbuild)(re - FLIT(1.0), im))), zr);
		if (neg)
			v = -v;
		}
	return (FNAME(Cbuild)(u, v));
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
