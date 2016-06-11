/* xxxquad.h -- common _[FL]Quad functionality */
#include <limits.h>
#include <string.h>
#include "xmath.h"


_STD_BEGIN

FTYPE FNAME(Xp_getw)(FTYPE *, int);
FTYPE *FNAME(Xp_setw)(FTYPE *, int, FTYPE);
FTYPE *FNAME(Xp_mulh)(FTYPE *, int, FTYPE);
FTYPE *FNAME(Xp_addx)(FTYPE *, int, FTYPE *, int);

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

static const FTYPE huge_rad = (FTYPE)(0.63661977236758134307553505349005744L
	* FULL_BITS / FRAC_BITS);	/* 2/pi (full - scaled) */
static const FTYPE inv2pi = FLIT(0.15915494309189533576888376337251436);
static const FTYPE twobypi = FLIT(0.63661977236758134307553505349005745);

static int get_acsize(FTYPE x)
	{	/* determine precision required for magnitude of x */
	int acsize;
	short xexp;

	FNAME(Dunscale)(&xexp, &x);
	acsize = 2 * (xexp / FBITS) + FRAC_XTRA;
	return (acsize <= ACSIZE ? acsize	/* full precison */
		: (int)ACSIZE);	/* get approximate value */
	}

unsigned int FNAME(Quad)(FTYPE *px)
	{	/* reduce *px to [-pi/2, pi/2], return quadrant */
	FTYPE x = *px;
	FTYPE g;

	if (-huge_rad < x && x < huge_rad)
		{	/* x small enough, reduce accurately mod pi/2 */
		g = x * twobypi;
		if (FLIT(0.0) <= g)
			g += FLIT(0.5);
		else
			g -= FLIT(0.5);
		FNAME(Dint)(&g, 0);
		if (g != FLIT(0.0))
			{	/* subtract multiple of pi/2 */
			FTYPE g4 = g * FLIT(0.25) / FRAC_BITS;

			x = ((((x - g4 * c[0]) - g4 * c[1]) - g4 * c[2])
				- g4 * c[3]) - g4 * c[4];
			}
		*px = x;
		}
	else
		{	/* subtract N*2*pi, then reduce accurately mod pi/2 */
		FTYPE xpy[ACSIZE], xpz[ACSIZE], xpx[XSIZE];
		int acsize = ACSIZE;
		short xexp;

		g = x;
		FNAME(Dunscale)(&xexp, &g);
		if (xexp < FBITS + 1 + (1 << ACSHIFT))
			FNAME(Xp_setw)(xpz, acsize, x);
		else
			{	/* replace M*2^N with M*2^-N*(2^N mod 2*Pi) */
			xexp = (xexp - (FBITS + 1)) >> ACSHIFT;
			FNAME(Dscale)(&x, -(xexp << ACSHIFT));
			FNAME(Xp_setw)(xpx, XSIZE, x);

			memcpy(xpz, &b[xexp - 1][0], ACSIZE * sizeof (b[0][0]));
			FNAME(Xp_mulh)(xpz, acsize, xpx[0]);
			if (xpx[1] != FLIT(0.0))
				{	/* add in product with lesser word of multiple */
				memcpy(xpy, &b[xexp - 1][0], ACSIZE * sizeof (b[0][0]));
				FNAME(Xp_mulh)(xpy, acsize, xpx[1]);
				FNAME(Xp_addx)(xpz, acsize, xpy, acsize);
				}
			}
		for (; xpz[0] < -huge_rad || huge_rad < xpz[0]; )
			{	/* eliminate some multiples of 2*pi */
			g = (xpz[0] + xpz[1]) * inv2pi;	
			FNAME(Dint)(&g, 0);

			FNAME(Xp_setw)(xpx, XSIZE, -g / FRAC_BITS);
			memcpy(xpy, c, acsize * sizeof (c[0]));
			FNAME(Xp_mulh)(xpy, acsize, xpx[0]);

			if (xpx[1] != FLIT(0.0))
				{	/* add in product with lesser word of integer multiple */
				FTYPE xpw[ACSIZE];

				acsize = get_acsize(xpz[0]);
				memcpy(xpw, c, acsize * sizeof (c[0]));
				FNAME(Xp_mulh)(xpw, acsize, xpx[1]);
				FNAME(Xp_addx)(xpy, acsize, xpw, acsize);
				}
			FNAME(Xp_addx)(xpz, acsize, xpy, acsize);
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

			acsize = get_acsize(xpz[0]);
			memcpy(xpw, c, acsize * sizeof (c[0]));
			FNAME(Xp_mulh)(xpw, acsize, -g * FLIT(0.25) / FRAC_BITS);
			FNAME(Xp_addx)(xpz, acsize, xpw, acsize);
			}
		*px = FNAME(Xp_getw)(xpz, acsize);	/* x -= N*pi/2 */
		}

	if (g < -LONG_MAX || LONG_MAX < g)	/* avoid integer overflow */
		g = FFUN(fmod)(g, (FTYPE)LONG_MAX + FLIT(1.0));
	return ((unsigned int)(long)g & 0x3);
	}

static const FTYPE pi = FLIT(3.14159265358979323846264338327950287);
static const FTYPE piby4 = FLIT(0.78539816339744830961566084581987572);

unsigned int FNAME(Quadph)(FTYPE *px, FTYPE phase)
	{	/* reduce *px+phase*Pi to [-pi/4, pi/4], return quadrant */
	unsigned int qoff = FNAME(Quad)(px);
	FTYPE ph0 = phase;
	FTYPE ans;

	FNAME(Dint)(&ph0, 1);	/* get quadrant count */
	phase -= ph0;	/* |phase| < 1/2 */

	if (ph0 < -LONG_MAX / 2 || LONG_MAX / 2 < ph0)	/* avoid overflow */
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
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
