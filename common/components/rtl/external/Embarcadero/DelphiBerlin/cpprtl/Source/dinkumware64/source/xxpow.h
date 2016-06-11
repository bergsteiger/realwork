/* xxpow.h -- common pow[fl] functionality */
#include <string.h>
#include "xmath.h"
_C_LIB_DECL

 #if defined(__OXILI_CLRUNTIME)	/* compiler test */
#define memcpy __qcom_memcpy_DW
 #endif /* defined(__OXILI_CLRUNTIME) */

FTYPE FNAME(Logpoly)(FTYPE w);

#define ACSIZE	4	/* size of extended-precision accumulators */
#define LNSIZE	3
#define XSIZE	2

	/* coefficients */
 #include "xxpow.hx"

FTYPE (FNAME(Pow))(FTYPE x, FTYPE y, short *pex)
	{	/* compute x^y, binary scale factor to *pex */
	FTYPE x1;
	FTYPE yi = y;
	FTYPE z;

	long zexp = 0;
	short xexp;
	short neg;
	short errx = FNAME(Dunscale)(&xexp, &x);
	const short erry = FNAME(Dint)(&yi, 0);

	_STATIC_CONST FTYPE invln2 = FLIT(1.4426950408889634073599246810018922);
	_STATIC_CONST FTYPE ln2 = FLIT(0.69314718055994530941723212145817657);
	_STATIC_CONST FTYPE rthalf = FLIT(0.70710678118654752440084436210484904);
	_STATIC_CONST FTYPE maxexp = (FTYPE)(32768);	/* overlarge exponent */

 #if KMAX == 0

 #else /* KMAX == 0 */
	int k;
 #endif /* KMAX == 0 */

	if (pex != 0)
		*pex = 0;
	if ((erry == 0 && y == FLIT(0.0))
		|| (errx < 0 && xexp == 1
			&& (x == FLIT(0.5) || (erry == _INFCODE && x == FLIT(-0.5)))))
		return (FLIT(1.0));	/* x^0, 1^y, (-1)^-INF, (-1)^INF */
	else if (0 <= errx || 0 < erry)
		{	/* x == 0, INF, NAN; y == INF, NAN */
		if (errx == _NANCODE)
			return (x);	/* NAN^y */
		else if (erry == _NANCODE)
			return (y);	/* x^NAN */
		else if (errx == _INFCODE)
			if (!FISNEG(x))
				return (FISNEG(y) ? FLIT(0.0) : FCONST(Inf));	/* INF^y */
			else if (!FISNEG(y))
				return (erry == 0 && FNAME(Dint)(&yi, -1) < 0
					? -FCONST(Inf)
					: FCONST(Inf));	/* (-INF)^y, 0 < y */
			else
				return (erry == 0 && FNAME(Dint)(&yi, -1) < 0
					? -FNAME(Zero) : FLIT(0.0));	/* (-INF)^y, y < 0 */
		else if (erry == _INFCODE)
			if (!FISNEG(y))
				return (xexp <= 0 ? FLIT(0.0) : FCONST(Inf));	/* x^INF */
			else
				return (xexp <= 0 ? FCONST(Inf) : FLIT(0.0));	/* x^-INF */
		else	/* x == 0 */
			if (!FISNEG(y))
				return (erry == 0 && FNAME(Dint)(&yi, -1) < 0 && FISNEG(x)
					? -FNAME(Zero) : FLIT(0.0));	/* 0^y, 0 < y */
			else
				{	/* 0^y, y < 0: report zero divide */
				_Feraise(_FE_DIVBYZERO);
				return (erry == 0 && FNAME(Dint)(&yi, -1) < 0 && FISNEG(x)
					? -FCONST(Inf) : FCONST(Inf));	/* 0^y, y < 0 */
				}
		}
	else if (FISNEG(x) && erry < 0)
		{	/* x^y, x < 0 && y not integer: report invalid */
		_Feraise(_FE_INVALID);
		return (FCONST(Nan));	/* x^y, x < 0 && y not integer */
		}

	if (FLIT(0.0) < x)
		neg = 0;
	else
		{	/* x < 0 */
		FNEGATE(x);
		neg = FNAME(Dint)(&yi, -1);	/* negate result for y negative integer */
		}

 #if KMAX == 0
	 {	/* compute log2(x) as xexp + ln2 * (x + x1) */
	FTYPE z, w;

	if (x < rthalf)
		{	/* ensure sqrt(1/2) <= x < sqrt(2) */
		x *= FLIT(2.0);
		--xexp;
		}

	z = FDIV(x - FLIT(1.0), x + FLIT(1.0));
	w = z * z;

	x -= FLIT(1.0);
	x1 = z * (w * FNAME(Logpoly)(w) - x);

	yi = (FTYPE)xexp + (x + x1) * invln2;	/* yi = log2(x), roughly */
	 }

 #else /* KMAX == 0 */
	 {	/* compute ln(x+a) */
	FTYPE bias, z, w;

	if (xexp == 1 && x < rthalf)
		{	/* use simpler formula near 1.0 */
		k = 0;
		bias = FLIT(1.0);
		x *= FLIT(2.0);
/*		xexp = 0; */
		}
	else
		{	/* compute ln(a) away from 1.0 */
		k = (int)(x * scale + FLIT(0.5)) - (1 << (KMAX - 1));
		bias = FDIV((FTYPE)k, scale) + FLIT(0.5);
		}

	z = FDIV(x - bias, x + bias);
	w = z * z;

	x -= bias;
	x1 = z * (w * FNAME(Logpoly)(w) - x + FLIT(2.0) * (FLIT(1.0) - bias));

	yi = (x + x1) * invln2;	/* yi = log2(x), roughly */
	yi += lnbias[k][0] + (FTYPE)xexp;
	 }
 #endif /* KMAX == 0 */

	z = y * yi;	/* z = y * log2(x) */
	if (z < -maxexp)
		errx = 0;	/* certain underflow */
	else if (-MAX_YLOGX <= z && z <= MAX_YLOGX
		&& -MAX_Y < y && y < MAX_Y)
		{	/* y*ln(x) middling, compute it carefully */
		zexp = (long)(z < FLIT(0.0) ? z - FLIT(0.5) : z + FLIT(0.5));
		z = y * (x + x1);

 #if KMAX == 0
		z += (y * (FTYPE)xexp - (FTYPE)zexp) * ln2;

 #else /* KMAX == 0 */
		z += y * (lnbias[k][1] + lnbias[k][2]) * ln2;
		z += (y * ((FTYPE)xexp + lnbias[k][0]) - (FTYPE)zexp) * ln2;
 #endif /* KMAX == 0 */

		errx = -1;
		}
	else if (maxexp < z)
		errx = _INFCODE;	/* certain overflow */
	else
		{	/* y not too large, compute exp(y*ln(x)) to extra precision */
		FTYPE xpx1[XSIZE], xpx[ACSIZE], xpy[ACSIZE], xpz[ACSIZE];
		int i;

		FNAME(Xp_setw)(xpx, ACSIZE, x);	/* combine parts of ln(x) */
		FNAME(Xp_setw)(xpx1, XSIZE, x1);
		FNAME(Xp_addx)(xpx, ACSIZE, xpx1, XSIZE);

		if (xpx[0] == FLIT(0.0))
			FNAME(Xp_setw)(xpy, ACSIZE, FLIT(0.0));	/* log2(1) == 0 */
		else
			{	/* convert ln(x) to log2(x) */
			memcpy(xpy, log2e, sizeof (xpy));
			FNAME(Xp_mulh)(xpy, ACSIZE, xpx[0]);
			for (i = 1; i < ACSIZE && xpx[i] != FLIT(0.0); ++i)
				{	/* add in product of 1/ln(2) with lesser word of ln(x) */
				FTYPE xpw[ACSIZE];

				memcpy(xpw, log2e, sizeof (xpw));
				FNAME(Xp_mulh)(xpw, ACSIZE, xpx[i]);
				FNAME(Xp_addx)(xpy, ACSIZE, xpw, ACSIZE);
				}
			}

 #if KMAX == 0

 #else /* KMAX == 0 */
			FNAME(Xp_addx)(xpy, ACSIZE,
				&lnbias[k][0], LNSIZE);	/* add in ln(a) */
 #endif /* KMAX == 0 */

		FNAME(Xp_addh)(xpy, ACSIZE, (FTYPE)xexp);	/* add in power of 2 */

		FNAME(Xp_setw)(xpx, XSIZE, y);	/* form y * log2(x) */
		memcpy(xpz, xpy, sizeof (xpz));
		FNAME(Xp_mulh)(xpz, ACSIZE, xpx[0]);

		if (xpx[1] != FLIT(0.0))
			{	/* add in product with lesser word of y */
			FTYPE xpw[ACSIZE];

			memcpy(xpw, xpy, sizeof (xpw));
			FNAME(Xp_mulh)(xpw, ACSIZE, xpx[1]);
			FNAME(Xp_addx)(xpz, ACSIZE, xpw, ACSIZE);
			}

		x = xpz[0];
		if (xpz[0] != FLIT(0.0) && xpz[1] != FLIT(0.0))
			x += xpz[1] + xpz[2];
		FNAME(Dint)(&x, 0);	/* integer part of y*log2(x) */
		FNAME(Xp_addh)(xpz, ACSIZE, -x);
		z = FNAME(Xp_getw)(xpz, ACSIZE);	/* fractional part */
		z *= ln2;
		zexp = (long)x;
		errx = -1;
		}

	if (errx < 0)
		{	/* may be finite, compute final result */
		if (pex != 0)
			{	/* pass on binary exponent */
			*pex = zexp;
			zexp = 0;
			}
		errx = FNAME(Exp)(&z, FLIT(1.0), zexp);
		 }
	switch (errx)
		{	/* report over/underflow */
	case 0:
		z = FLIT(0.0);
		_Feraise(_FE_UNDERFLOW);
		break;

	case _INFCODE:
		if (z < FLIT(0.0))
			{	/* huge negative, underflow */
			z = FLIT(0.0);
			_Feraise(_FE_UNDERFLOW);
			}
		else
			{	/* huge positive, overflow */
			z = FCONST(Inf);
			_Feraise(_FE_OVERFLOW);
			}
		}

	if (neg)
		FNEGATE(z);
	return (z);
	}

FTYPE (FFUN(pow))(FTYPE x, FTYPE y)
	{	/* compute x^y */
	return (FNAME(Pow)(x, y, 0));
	}
_END_C_LIB_DECL

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
