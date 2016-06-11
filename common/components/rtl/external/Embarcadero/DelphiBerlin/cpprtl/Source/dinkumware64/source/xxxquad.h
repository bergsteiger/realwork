/* xxxquad.h -- common _[FL]Quad functionality */
#include <limits.h>
#include <string.h>
#include "xmath.h"

_C_LIB_DECL

 #if defined(__OXILI_CLRUNTIME)	/* compiler test */
#define memcpy __qcom_memcpy_DW
 #endif /* defined(__OXILI_CLRUNTIME) */

#define ACSIZE	(sizeof c / sizeof c[0])
#define XSIZE	2

	/* coefficients */
#define FRAC_BITS_1		FRAC_BITS
#define FRAC_BITS_2		(FRAC_BITS_1 * FRAC_BITS_1)
#define FRAC_BITS_3		(FRAC_BITS_2 * FRAC_BITS_1)
#define FRAC_BITS_4		(FRAC_BITS_2 * FRAC_BITS_2)
#define FRAC_BITS_5		(FRAC_BITS_4 * FRAC_BITS_1)
#define FRAC_BITS_6		(FRAC_BITS_4 * FRAC_BITS_2)

 #include "xxxquad.hx"

_STATIC_CONST FTYPE huge_rad = (FTYPE)(0.63661977236758134307553505349005744L
	* FULL_BITS / FRAC_BITS);	/* 2/pi (full - scaled) */
_STATIC_CONST FTYPE inv2pi = FLIT(0.15915494309189533576888376337251436);
_STATIC_CONST FTYPE pi = FLIT(3.1415926535897932384626433832795029);
_STATIC_CONST FTYPE piby4 = FLIT(0.78539816339744830961566084581987572);
_STATIC_CONST FTYPE twobypi = FLIT(0.63661977236758134307553505349005745);
_STATIC_CONST FTYPE inv_fracbits = FLIT(1.0) / (FTYPE)FRAC_BITS;

static FTYPE FNAME(Quad_multiply)(FTYPE x, FTYPE y)
	{	/* compute x * y, correcting for FTZ */
	FTYPE ans = x * y;

	if (ans == FLIT(0.0))
		{	/* underflow, try harder */
		short xexp, yexp;

		FNAME(Dunscale)(&xexp, &x);
		FNAME(Dunscale)(&yexp, &y);
		ans = x * y;
		FNAME(Dscale)(&ans, xexp + yexp);
		}
	return (ans);
	}

#define RETURN_QUAD	1

unsigned int FNAME(Quad)(FTYPE *px, int retcode)
	{	/* reduce *px to [-pi/2, pi/2], return quadrant */
	FTYPE x = *px;
	FTYPE g;

	if (retcode & RETURN_QUAD)
		{	/* reduce quadrant argument in *px to [-1/4, 1/4] */
		unsigned int qoff;

		FNAME(Dint)(&x, -1);	/* clear bits < 2 */
		if (x == FLIT(0.0))
			x = *px;	/* no high bits, leave tiny value alone */
		else
			{	/* clear bits >= 2 */
			x = *px - x;	/* |x| < 2 */
			*px = x;
			}
		qoff = (unsigned int)(int)(x + x);

		FNAME(Dint)(px, 1);	/* clear bits < 1/2 */
		if (*px != FLIT(0.0))
			x -= *px;	/* |x| < 1/2 */
		if (FLIT(0.25) < x)
			{	/* shift down a quadrant */
			x -= FLIT(0.5);
			++qoff;
			}
		else if (x < -FLIT(0.25))
			{	/* shift up a quadrant */
			x += FLIT(0.5);
			--qoff;
			}

		*px = FNAME(Quad_multiply)(x, pi);
		return (qoff);
		}

/* reduce radian argument in *px to [-pi/4, pi/4] */
	if (-piby4 < x && x < piby4)
		{	/* small, just return argument to avoid FTZ */
		*px = x;
		return (0);
		}

 #if _FAST_QUAD	/* fast version */
static const FTYPE c1 = (FTYPE)(13176794.0 / 8388608.0);
static const FTYPE c2 = FLIT(7.5497899548918821691639751442098585e-8);

static const FTYPE twobypi = FLIT(0.63661977236758134307553505349005745);
static const FTYPE twopi = FLIT(6.2831853071795864769252867665590058);

	if (x < -huge_rad || huge_rad < x)
		x = FFUN(fmod)(x, twopi);
	g = x * twobypi;
	if (FLIT(0.0) <= g)
		g += FLIT(0.5);
	else
		g -= FLIT(0.5);
	FNAME(Dint)(&g, 0);
	*px = (x - g * c1) - g * c2;
	return ((unsigned int)g & 0x3);

 #else	/* fast version */
	else if (-huge_rad < x && x < huge_rad)
		{	/* x small enough, reduce accurately mod pi/2 */
		g = x * twobypi;
		if (FLIT(0.0) <= g)
			g += FLIT(0.5);
		else
			g -= FLIT(0.5);
		FNAME(Dint)(&g, 0);
		if (g != FLIT(0.0))
			{	/* subtract multiple of pi/2 */
			FTYPE xpx[XSIZE], xpy[ACSIZE];

			memcpy(xpy, piby2, ACSIZE * sizeof (FTYPE));
			FNAME(Xp_mulh)(xpy, ACSIZE, -g);
			FNAME(Xp_setw)(xpx, XSIZE, x);
			FNAME(Xp_addx)(xpy, ACSIZE, xpx, XSIZE);
			x = FNAME(Xp_getw)(xpy, ACSIZE);
			}
		*px = x;
		}
	else
		{	/* eliminate N*2*pi, then reduce accurately mod pi/2 */
		FTYPE xpx[XSIZE], xpy[ACSIZE], xpz[ACSIZE];
		short xexp;

		g = x;
		FNAME(Dunscale)(&xexp, &g);

 #if FBITS <= 11
		FNAME(Xp_setw)(xpz, ACSIZE, x);

 #else /* FBITS <= 11 */
		if (xexp < FBITS + 5 + (1 << ACSHIFT))	/* magic threshold */
			FNAME(Xp_setw)(xpz, ACSIZE, x);
		else
			{	/* replace M*2^N with M*(2^N mod 2*Pi) */
			xexp = (xexp - (FBITS + 1)) >> ACSHIFT;
			FNAME(Dscale)(&x, -(xexp << ACSHIFT));
			FNAME(Xp_setw)(xpx, XSIZE, x);

			memcpy(xpz, &b[xexp - 1][0], ACSIZE * sizeof (FTYPE));
			FNAME(Xp_mulh)(xpz, ACSIZE, xpx[0]);
			if (xpx[1] != FLIT(0.0))
				{	/* add in product with lesser word of multiple */
				memcpy(xpy, &b[xexp - 1][0], ACSIZE * sizeof (FTYPE));
				FNAME(Xp_mulh)(xpy, ACSIZE, xpx[1]);
				FNAME(Xp_addx)(xpz, ACSIZE, xpy, ACSIZE);
				}
			}
 #endif /* FBITS <= 11 */

		for (; xpz[0] < -huge_rad || huge_rad < xpz[0]; )
			{	/* eliminate some multiples of 2*pi */
			g = (xpz[0] + xpz[1]) * inv2pi;
			FNAME(Dint)(&g, 0);

			FNAME(Xp_setw)(xpx, XSIZE, -g * inv_fracbits);
			memcpy(xpy, c, ACSIZE * sizeof (FTYPE));
			FNAME(Xp_mulh)(xpy, ACSIZE, xpx[0]);

			if (xpx[1] != FLIT(0.0))
				{	/* add in product with lesser word of integer multiple */
				FTYPE xpw[ACSIZE];

				memcpy(xpw, c, ACSIZE * sizeof (FTYPE));
				FNAME(Xp_mulh)(xpw, ACSIZE, xpx[1]);
				FNAME(Xp_addx)(xpy, ACSIZE, xpw, ACSIZE);
				}
			FNAME(Xp_addx)(xpz, ACSIZE, xpy, ACSIZE);
			}

		g = (xpz[0] + xpz[1]) * twobypi;	/* divide by pi/2 */
		if (FLIT(0.0) <= g)
			g += FLIT(0.5);
		else
			g -= FLIT(0.5);
		FNAME(Dint)(&g, 0);

		if (g != FLIT(0.0))
			{	/* reduce to [-pi/4, pi/4] and correct quadrant */
			FTYPE xpw[ACSIZE];

			memcpy(xpw, c, ACSIZE * sizeof (FTYPE));
			FNAME(Xp_mulh)(xpw, ACSIZE, -g * FLIT(0.25) * inv_fracbits);
			FNAME(Xp_addx)(xpz, ACSIZE, xpw, ACSIZE);
			}

		*px = FNAME(Xp_getw)(xpz, ACSIZE);	/* |x| < pi/4 */
		}

	if (g < -(FTYPE)LONG_MAX
		|| (FTYPE)LONG_MAX < g)	/* avoid integer overflow */
		g = FFUN(fmod)(g, (FTYPE)LONG_MAX + FLIT(1.0));
	return ((unsigned int)(long)g & 0x3);
 #endif	/* fast version */
	}

unsigned int FNAME(Quadph)(FTYPE *px, FTYPE phase)
	{	/* reduce *px+phase*Pi to [-pi/4, pi/4], return quadrant */
	unsigned int qoff = FNAME(Quad)(px, 0);
	FTYPE ph0 = phase;
	FTYPE ans;

	FNAME(Dint)(&ph0, 1);	/* get quadrant count */
	phase -= ph0;	/* |phase| < 1/2 */

	if (ph0 < -(FTYPE)(LONG_MAX / 2)
		|| (FTYPE)(LONG_MAX / 2) < ph0)	/* avoid overflow */
		ph0 = FFUN(fmod)(ph0, (FTYPE)(LONG_MAX / 2) + FLIT(1.0));
	qoff += ((unsigned int)(long)(ph0 * FLIT(2.0))) & 0x3;

	ans = *px + phase * pi;
	if (piby4 <= ans)
		{	/* shift down a quadrant */
		phase -= FLIT(0.5);
		++qoff;
		*px += phase * pi;
		}
	else if (ans <= -piby4)
		{	/* shift up a quadrant */
		phase += FLIT(0.5);
		--qoff;
		*px += phase * pi;
		}
	else
		*px = ans;

	return (qoff);
	}
_END_C_LIB_DECL

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
