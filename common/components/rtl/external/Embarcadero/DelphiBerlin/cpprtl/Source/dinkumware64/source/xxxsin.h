/* xxxsin.h -- common _[FL]Sin functionality */
#include "xmath.h"
_C_LIB_DECL

unsigned int _CDECL FNAME(Quad)(FTYPE *px, int quads);

	/* coefficients */

 #if   FBITS <= 24
  #define CPOLY(x)	((c[0] * x + c[1]) * x + c[2])

_STATIC_CONST FTYPE c[] = {	/* 6th-order, |x| < pi/4 (102.5%) */
	FLIT(-0.0013602249),
	FLIT( 0.0416566950),
	FLIT(-0.4999990225),
	};

 #elif FBITS <= 53
  #define CPOLY(x)	(((((c[0] * x + c[1]) * x + c[2]) * x + c[3]) * x \
		+ c[4]) * x + c[5])

_STATIC_CONST FTYPE c[] = {	/* 12th-order, |x| < pi/4 (101.0%) */
	FLIT( 0.00000000206374484196),
	FLIT(-0.00000027555365134677),
	FLIT( 0.00002480157946764225),
	FLIT(-0.00138888888730525966),
	FLIT( 0.04166666666651986722),
	FLIT(-0.49999999999999547304),
	};

 #elif FBITS <= 74
  #define CPOLY(x)	FNAME(Poly)(x, c, sizeof (c) / sizeof (c[0]) - 1)

_STATIC_CONST FTYPE c[] = {	/* 16th-order, |x| < pi/4 (100.5%) */
	FLIT( 0.0000000000000473739219005),
	FLIT(-0.0000000000114702734945190),
	FLIT( 0.0000000020876754143374602),
	FLIT(-0.0000002755731921405952840),
	FLIT( 0.0000248015873015671504515),
	FLIT(-0.0013888888888888866294676),
	FLIT( 0.0416666666666666665442766),
	FLIT(-0.4999999999999999999977307),
	};

 #elif FBITS <= 120
  #define CPOLY(x)	FNAME(Poly)(x, c, sizeof (c) / sizeof (c[0]) - 1)

_STATIC_CONST FTYPE c[] = {	/* 24th-order, |x| < pi/4 (101.5%) */
	FLIT( 0.00000000000000000000000160175666880),
	FLIT(-0.00000000000000000000088966135828502),
	FLIT( 0.00000000000000000041103174390826501),
	FLIT(-0.00000000000000015619206967357287223),
	FLIT( 0.00000000000004779477332386833269879),
	FLIT(-0.00000000001147074559772972301708321),
	FLIT( 0.00000000208767569878680989756556773),
	FLIT(-0.00000027557319223985890652552359412),
	FLIT( 0.00002480158730158730158730158289917),
	FLIT(-0.00138888888888888888888888888866000),
	FLIT( 0.04166666666666666666666666666666070),
	FLIT(-0.49999999999999999999999999999999994),
	};

 #else /* FBITS */
  #error cos has insufficient precision
 #endif /* FBITS */

 #if   FBITS <= 27
  #define SPOLY(x)	((s[0] * x + s[1]) * x + s[2])

_STATIC_CONST FTYPE s[] = {	/* 7th-order, |x| < pi/4 (101.0%) */
	FLIT(-0.0001950727),
	FLIT( 0.0083320758),
	FLIT(-0.1666665247),
	};

 #elif FBITS <= 57
  #define SPOLY(x)	(((((s[0] * x + s[1]) * x + s[2]) * x + s[3]) * x \
		+ s[4]) * x + s[5])

_STATIC_CONST FTYPE s[] = {	/* 13th-order, |x| < pi/4 (100.1%) */
	FLIT( 0.00000000015893606014),
	FLIT(-0.00000002505069049138),
	FLIT( 0.00000275573131527032),
	FLIT(-0.00019841269827816117),
	FLIT( 0.00833333333331908278),
	FLIT(-0.16666666666666612594),
	};

 #elif FBITS <= 67
  #define SPOLY(x)	((((((s[0] * x + s[1]) * x + s[2]) * x + s[3]) * x \
		+ s[4]) * x + s[5]) * x + s[6])

_STATIC_CONST FTYPE s[] = {	/* 15th-order, |x| < pi/4 (100.1%) */
	FLIT(-0.0000000000007577431355678),
	FLIT( 0.0000000001605833578937085),
	FLIT(-0.0000000250521046154711532),
	FLIT( 0.0000027557319212771469543),
	FLIT(-0.0001984126984125154751008),
	FLIT( 0.0083333333333333185880032),
	FLIT(-0.1666666666666666662327406),
	};

 #elif FBITS <= 113
  #define SPOLY(x)	FNAME(Poly)(x, s, sizeof (s) / sizeof (s[0]) - 1)

_STATIC_CONST FTYPE s[] = {	/* 23rd-order, |x| < pi/4 (100.0%) */
	FLIT(-0.00000000000000000000003844137998642),
	FLIT( 0.00000000000000000001957254719540577),
	FLIT(-0.00000000000000000822063487427561904),
	FLIT( 0.00000000000000281145725412124613278),
	FLIT(-0.00000000000076471637318189191073892),
	FLIT( 0.00000000016059043836821612186861621),
	FLIT(-0.00000002505210838544171877074319675),
	FLIT( 0.00000275573192239858906525523834363),
	FLIT(-0.00019841269841269841269841266458560),
	FLIT( 0.00833333333333333333333333333212182),
	FLIT(-0.16666666666666666666666666666665028),
	};

 #else /* FBITS */
  #error sin has insufficient precision
 #endif /* FBITS */

FTYPE _CDECL FNAME(Sinx)(FTYPE x, unsigned int qoff, int quads)
	{	/* compute sin(x) or cos(x) */
	switch (FNAME(Dtest)(&x))
		{
	case _NANCODE:
		return (x);

	case 0:
		if ((qoff & 0x1) != 0)
			x = FLIT(1.0);
		return ((qoff & 0x2) != 0 ? -x : x);

	case _INFCODE:
		_Feraise(_FE_INVALID);
		return (FCONST(Nan));

	default:	/* finite */
		qoff += FNAME(Quad)(&x, quads);
		if (-FCONST(Rteps) < x && x < FCONST(Rteps))
			{	/* sin(tiny)==tiny, cos(tiny)==1 */
			if ((qoff & 0x1) != 0)
				x = FLIT(1.0);	/* cos(tiny) */
			}
		else
			{	/* compute approximation for |g| < pi/4 */
			FTYPE w = x * x;

			if ((qoff & 0x1) != 0)
				x = FLIT(1.0) + w * CPOLY(w);
			else
				x += x * w * SPOLY(w);
			}

		if (qoff & 0x2)
			FNEGATE(x);
		return (x);
		}
	}

FTYPE _CDECL FNAME(Sincos)(FTYPE x, FTYPE *pcos)
	{	/* compute sin(x) and cos(x) */
	switch (FNAME(Dtest)(&x))
		{
	case _NANCODE:
		*pcos = x;
		return (x);

	case 0:
		*pcos = FLIT(1.0);
		return (x);

	case _INFCODE:
		*pcos = FCONST(Nan);
		_Feraise(_FE_INVALID);
		return (FCONST(Nan));

	default:
		 {	/* finite */
		unsigned int qoff = FNAME(Quad)(&x, 0);

		if (-FCONST(Rteps) < x && x < FCONST(Rteps))
			if ((qoff & 0x1) == 0)
				*pcos = FLIT(1.0);	/* near 0 or pi */
			else
				{	/* near |pi/2| */
				*pcos = x;
				x = FLIT(1.0);	/* cos(tiny) */
				}
		else
			{	/* compute approximation for |g| < pi/4 */
			FTYPE w = x * x;

			if ((qoff & 0x1) != 0)
				x = FLIT(1.0) + w * CPOLY(w);
			else
				x += x * w * SPOLY(w);
			}

		if (((qoff + 1) & 0x2) != 0)
			*pcos = -*pcos;
		if (qoff & 0x2)
			FNEGATE(x);
		return (x);
		 }
		}
	}

FTYPE _CDECL FNAME(Sin)(FTYPE x, unsigned int qoff)
	{	/* compute sin(x) or cos(x) */
	return (FNAME(Sinx)(x, qoff, 0));
	}
_END_C_LIB_DECL

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
