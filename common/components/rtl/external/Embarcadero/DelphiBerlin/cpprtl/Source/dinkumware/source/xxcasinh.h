/* xxcasinh.h -- common casinh[fl] functionality */
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

static const FTYPE piby2 = FLIT(1.5707963267948966192313216916397514);
static const FTYPE piby4 = FLIT(0.78539816339744830961566084581987572);

FCTYPE (FFUN(casinh))(FCTYPE x)
	{	/* compute complex hyperbolic arcsine */
	FTYPE re = FFUN(creal)(x);
	FTYPE im = FFUN(cimag)(x);
	const short errx = FNAME(Dtest)(&re);
	const short erry = FNAME(Dtest)(&im);
	FTYPE u, v;

	if (errx == _NANCODE)
		if (erry == _NANCODE || erry == 0)
			{	/* (NaN, NaN or 0) */
			u = re;
			v = im;
			}
		else if (erry == _INFCODE)
			{	/* (NaN, +/-Inf) */
			u = im;
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
			u = re;
			v = im;
			}
		else
			{	/* (finite, NaN) */
			u = im;
			v = im;
			}
	else if (errx == _INFCODE)
		if (erry == _INFCODE)
			{	/* (+/-Inf, +/-Inf) */
			u = re;
			v = im < FLIT(0.0) ? -piby4 : piby4;
			}
		else
			{	/* (+/-Inf, finite) */
			u = re;
			v = FISNEG(im) ? -FNAME(Zero) : FLIT(0.0);
			}
	else if (erry == _INFCODE)
		{	/* (finite, +/-Inf) */
		u = im;
		v = im < FLIT(0.0) ? -piby2 : piby2;
		}
	else
		{	/* {finite, finite) */
		const FCTYPE w = FFUN(csqrt)(FNAME(Cbuild)(FLIT(1.0) - im, re));
		const FCTYPE z = FFUN(csqrt)(FNAME(Cbuild)(FLIT(1.0) + im, -re));

		if (re == FLIT(0.0))
			u = re;
		else
			{	/* compute asinh carefully for large values */
			const FTYPE wr = FFUN(creal)(w);
			const FTYPE wi = FFUN(cimag)(w);
			const FTYPE zr = FFUN(creal)(z);
			const FTYPE zi = FFUN(cimag)(z);
			FTYPE alfa, beta;

			if (big < wr)
				{	/* real parts large */
				alfa = wr;
				beta = wi * (zr / alfa) - zi;
				}
			else if (big < wi)
				{	/* imag parts large */
				alfa = wi;
				beta = zr - wr * (zi / alfa);
				}
			else if (big < -wi)
				{	/* imag part of w large negative */
				alfa = -wi;
				beta = zr - wr * (zi / alfa);
				}
			else
				{	/* shouldn't overflow */
				alfa = FLIT(0.0);
				beta = wi * zr - wr * zi;	/* Im(w * conj(z)) */
				}

			u = FFUN(asinh)(beta);
			if (alfa == FLIT(0.0))
				;
			else if (FLIT(0.0) <= u)
				u += FFUN(log)(alfa);
			else
				u -= FFUN(log)(alfa);	/* asinh(a*b) = asinh(a)+log(b) */
			}

		v = FFUN(atan2)(im, FFUN(creal)(FNAME(Cmulcc)(w, z)));
		}
	return (FNAME(Cbuild)(u, v));
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
