/* xxxexp.h -- common _[FL]Exp functionality */
#include "xmath.h"
_C_LIB_DECL

	/* coefficients */

 #if   FBITS <= 33
  #define CPOLY(x)	(c[0])
  #define SPOLY(x)	(s[0] * x + s[1])

_STATIC_CONST FTYPE c[] = {	/* 3rd-order, |x| < ln(2)/2 (minimax) */
	FLIT(0.0999748594),
	};
_STATIC_CONST FTYPE s[] = {
	FLIT(0.0083208258),
	FLIT(0.4999999992),
	};

 #elif FBITS <= 60
  #define CPOLY(x)	(c[0] * x + c[1])
  #define SPOLY(x)	((s[0] * x + s[1]) * x + s[2])

_STATIC_CONST FTYPE c[] = {	/* 5th-order, |x| < ln(2)/2 (minimax) */
	FLIT(0.00099173235263350450),
	FLIT(0.11110779924116564678),
	};
_STATIC_CONST FTYPE s[] = {
	FLIT(0.00003304120783105597),
	FLIT(0.01388723295391837963),
	FLIT(0.49999999999999998664),
	};

 #elif FBITS <= 74
  #define CPOLY(x)	((c[0] * x + c[1]) * x + c[2])
  #define SPOLY(x)	((s[0] * x + s[1]) * x + s[2])

_STATIC_CONST FTYPE c[] = {	/* 6th-order, |x| < ln(2)/2 (minimax) */
	FLIT(0.0000015021009413506901594),
	FLIT(0.0012624415588135726592198),
	FLIT(0.1136346396655614546681762),
	};
_STATIC_CONST FTYPE s[] = {
	FLIT(0.0000631107933417128455181),
	FLIT(0.0151506531661140608604973),
	FLIT(0.4999999999999999999991708),
	};

 #elif FBITS <= 118
  #define CPOLY(x)	(((c[0] * x + c[1]) * x + c[2]) * x + c[3])
  #define SPOLY(x)	((((s[0] * x + s[1]) * x + s[2]) * x + s[3]) * x + s[4])

_STATIC_CONST FTYPE c[] = {	/* 9th-order, |x| < ln(2)/2 (102.5%) */
	FLIT(0.0000000050996601178111255913989690351278),
	FLIT(0.0000062839134587711380261342848362075402),
	FLIT(0.0017156346619451467305600244926131415489),
	FLIT(0.1176466115124820805029461151975277929451),
	};
_STATIC_CONST FTYPE s[] = {
	FLIT(0.0000000000566531262664884418901404512823),
	FLIT(0.0000002244096566956636845481353790434277),
	FLIT(0.0001225418512858200109905907769221302052),
	FLIT(0.0171566390895743735848063909321167993553),
	FLIT(0.4999999999999999999999999999999999603141),
	};

 #else /* FBITS */
  #error Exp has insufficient precision
 #endif /* FBITS */

 #if 113 <= FBITS
  #define FRAC_BITS	72057594037927936.0L		/* 2^56 */
  #define LN2_F1	49946518145322873.0L
  #define LN2_F23	0.67104933867086895232250769757934356L

 #elif 64 <= FBITS
  #define FRAC_BITS	2147483648.0L		/* 2^31 */
  #define LN2_F1	1488522235.0L
  #define LN2_F23	0.9097860357478063902517841L

 #elif 53 <= FBITS
  #define FRAC_BITS	67108864.0L		/* 2^26 */
  #define LN2_F1	46516319.0L
  #define LN2_F23	0.87218081361711894970L

 #elif 24 <= FBITS
  #define FRAC_BITS	2048.0L		/* 2^11 */
  #define LN2_F1	1419.0L
  #define LN2_F23	0.5654257868L

 #elif 11 <= FBITS
  #define FRAC_BITS	32.0L		/* 2^5 */
  #define LN2_F1	22.0L
  #define LN2_F23	0.180709L

 #else /* FBITS */
  #error Exp has insufficient precision
 #endif /* FBITS */

_STATIC_CONST FTYPE c1 = (FTYPE)(LN2_F1 / FRAC_BITS);
_STATIC_CONST FTYPE c23 = (FTYPE)(LN2_F23 / FRAC_BITS);

_STATIC_CONST FTYPE hugexp = FMACRO(HUGE_EXP);
_STATIC_CONST FTYPE invln2 = FLIT(1.4426950408889634073599246810018922);

_CRTIMP2 short _CDECL FNAME(Exp)(FTYPE *px, FTYPE y, long eoff)
	{	/* compute y*e^(*px)*2^eoff, (*px) finite, |y| not huge */
	short errx = FNAME(Dtest)(px);
	short erry = FNAME(Dtest)(&y);

	if (0 <= errx || 0 <= erry)
		{	/* x or y is Inf, NAN, or zero */
		if (errx == _NANCODE)
			return (_NANCODE);	/* exp(NaN)*y */
		else if (erry == _NANCODE)
			{	/* exp(x)*NaN */
			*px = y;
			return (_NANCODE);
			}
		else if (erry == 0)
			if (*px != FCONST(Inf))
				{	/* {0 finite}*0 */
				*px = y;
				return (0);
				}
			else
				{	/* exp(Inf)*0, report invalid */
				_Feraise(_FE_INVALID);
				*px = FCONST(Nan);
				return (_NANCODE);
				}
		else if (erry == _INFCODE)
			if (*px != -FCONST(Inf))
				{	/* exp({0 finite})*{-Inf or Inf} */
				*px = y;
				return (_INFCODE);
				}
			else
				{	/* exp(-Inf)*{-Inf or Inf}, report invalid */
				_Feraise(_FE_INVALID);
				*px = FCONST(Nan);
				return (_NANCODE);
				}
		else if (errx == 0)
			{	/* exp(0)*finite */
			*px = y;
			switch (errx = FNAME(Dscale)(px, eoff))
				{	/* report over/underflow from scaling */
			case 0:
				_Feraise(_FE_UNDERFLOW);
				break;

			case _INFCODE:
				_Feraise(_FE_OVERFLOW);
				}
			return (errx);
			}
		else if (*px == FCONST(Inf))
			{	/* exp(Inf)*finite */
			*px *= y;	/* get sign of y */
			return (_INFCODE);
			}
		else
			{	/* exp(-Inf)*finite */
			*px = FLIT(0.0) * y;	/* get sign of y */
			return (0);
			}
		}
	else if (*px < -hugexp)	/* x and y finite */
		{	/* certain underflow */
		*px = FLIT(0.0) * y;	/* get sign of y */
		return (0);
		}
	else if (hugexp < *px)
		{	/* certain overflow */
		*px = FCONST(Inf) * y;	/* get sign of y */
		_Feraise(_FE_OVERFLOW);
		return (_INFCODE);
		}
	else
		{	/* xexp won't overflow */
		FTYPE g = *px * invln2;
		long xexp = (long)(g + (g < FLIT(0.0) ? - FLIT(0.5) : FLIT(0.5)));

		g = xexp;
		g = (FTYPE)((*px - g * c1) - g * c23);
		if (-FCONST(Eps) < g && g < FCONST(Eps))
			*px = y;
		else
			{	/* g*g worth computing */
			const FTYPE z = g * g;
			const FTYPE ch = z * CPOLY(z);
			const FTYPE sh = g * SPOLY(z);
			const FTYPE den = FINVERT(FLIT(1.0) + (ch - sh));

			*px = (den + (ch + sh) * den) * y;
			}

		switch (errx = FNAME(Dscale)(px, (long)xexp + eoff))
			{	/* report over/underflow from scaling */
		case 0:
			_Feraise(_FE_UNDERFLOW);
			break;

		case _INFCODE:
			_Feraise(_FE_OVERFLOW);
			}
		return (errx);
		}
	}
_END_C_LIB_DECL

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
