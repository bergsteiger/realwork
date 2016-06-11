/* xxxsinh.h -- common _[FL]Sinh functionality */
#include "xmath.h"
_C_LIB_DECL

	/* coefficients */

 #if   FBITS <= 30
  #define CPOLY(x)	(c[0] * x + c[1])
  #define SPOLY(x)	(s[0])

static const FTYPE c[] = {	/* 3rd-order, |x| < ln(3)/2 (100.0%) */
	FLIT( 0.0018399770),
	FLIT(-0.0610359754),
	};
static const FTYPE s[] = {
	FLIT( 0.1056307265),
	};

 #elif FBITS <= 53
  #define CPOLY(x)	(c[0] * x + c[1])
  #define SPOLY(x)	((s[0] * x + s[1]) * x + s[2])

static const FTYPE c[] = {	/* 5th-order, |x| < ln(3)/2 (100.0%) */
	FLIT( 0.00015900461490295664),
	FLIT(-0.02056695099386675945),
	};
static const FTYPE s[] = {
	FLIT( 0.00005352221341916260),
	FLIT( 0.00506451278229574483),
	FLIT( 0.14609971567280727143),
	};

 #elif FBITS <= 64
  #define CPOLY(x)	((c[0] * x + c[1]) * x + c[2])
  #define SPOLY(x)	((s[0] * x + s[1]) * x + s[2])

static const FTYPE c[] = {	/* 6th-order, |x| < ln(3)/2 (100.0%) */
	FLIT(-0.00000158330729052950769915),
	FLIT( 0.00027519426342349878805713),
	FLIT( -0.0241170695527346096673505),
	};
static const FTYPE s[] = {
	FLIT( 0.0000417195220925635337445),
	FLIT( 0.0045890160046340899454803),
	FLIT( 0.1425495971139320626966453),
	};

 #elif FBITS <= 114
  #define CPOLY(x)	((((c[0] * x + c[1]) * x + c[2]) * x + c[3]) * x + c[4])
  #define SPOLY(x)	((((s[0] * x + s[1]) * x + s[2]) * x + s[3]) * x + s[4])

static const FTYPE c[] = {	/* 9th-order, |x| < ln(3)/2 (100.0%) */
	FLIT(-0.00000000000336993857130038006925178471496),
	FLIT( 0.00000000194074062258199190461301221438596),
	FLIT(-0.00000060338126386989611923562546176683121),
	FLIT( 0.00012225633519572222239274990096628782027),
	FLIT(-0.01570282210530478910525045132285980643671),
	};
static const FTYPE s[] = {
	FLIT( 0.0000000013284592352809230453478855863105),
	FLIT( 0.0000005602726057324471474526599821935838),
	FLIT( 0.0000873285221372423111008817391507917175),
	FLIT( 0.0058384526509782573715176746781914259057),
	FLIT( 0.1509638445613618775614162153438248456945),
	};

 #else /* FBITS */
  #error sinh has insufficient precision
 #endif /* FBITS */

_STATIC_CONST FTYPE ln3by2 = FLIT(0.54930614433405484569762261846126284);
_STATIC_CONST FTYPE xbig = (FTYPE)(0.308 * (FBITS + 1));

static FTYPE FNAME(Sinh_small)(FTYPE x)
	{	/* approximate sinh for [0, 0.54) */
	const FTYPE z = x * x;
	const FTYPE ch = FLIT(1.0) + z * CPOLY(z);

	x += x * z * SPOLY(z);
	return (FDIV(x, ch));
	}

_CRTIMP2 FTYPE _CDECL FNAME(Sinh)(FTYPE x, FTYPE y)
	{	/* compute sinh(x)*y */
	const short errx = FNAME(Dtest)(&x);
	const short erry = FNAME(Dtest)(&y);

	if (0 <= errx || 0 <= erry)
		{	/* x or y is 0, Inf, or NAN */
		if (errx == _NANCODE)
			return (x);	/* sinh(NaN)*y */
		else if (erry == _NANCODE)
			return (y);	/* sinh(x)*NaN */
		else if (errx == _INFCODE)
			if (erry != 0)
				return (x * y);	/* sinh(Inf)*{finite or Inf} */
			else
				{	/* sinh(Inf)*0, report invalid */
				_Feraise(_FE_INVALID);
				return (FCONST(Nan));
				}
		else if (errx == 0)
			if (erry != _INFCODE)
				return (x * y);	/* sinh(0)*{finite or 0} */
			else
				{	/* sinh(0)*Inf, report invalid */
				_Feraise(_FE_INVALID);
				return (FCONST(Nan));
				}
		else
			return (x * y);	/* sinh(finite)*{0 or Inf} */
		}
	else
		{	/* x and y finite */
		short neg;

		if (x < FLIT(0.0))
			{	/* make positive and remember sign */
			FNEGATE(x);
			neg = 1;
			}
		else
			neg = 0;

		if (x < FCONST(Rteps))
			{	/* x tiny, multiply by y */
			if (y != FLIT(1.0))	/* avoid FTZ */
				x *= y;
			}
		else if (x < ln3by2)
			x = y * FNAME(Sinh_small)(x);
		else if (x < FLIT(4.0))
			{	/* don't factor out expm1(z) */
			FTYPE z = FFUN(expm1)(x);

			x = z + FLIT(0.5) * z * FFUN(expm1)(-x);
			x *= y;
			}
		else if (x < xbig)
			{	/* x small, compute (exp(x)-exp(-x))/2 carefully */
			x = FFUN(expm1)(x)
					* (FLIT(1.0) + FLIT(0.5) * FFUN(expm1)(-x));
			x *= y;
			}
		else
			FNAME(Exp)(&x, y, -1);

		if (neg)
			FNEGATE(x);
		return (x);
		}
	}
_END_C_LIB_DECL

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
