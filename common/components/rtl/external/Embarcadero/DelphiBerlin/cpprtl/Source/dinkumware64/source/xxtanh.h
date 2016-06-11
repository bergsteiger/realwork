/* xxtanh.h -- common tanh[fl] functionality */
#include "xmath.h"
_C_LIB_DECL

	/* coefficients */

 #if   FBITS <= 24
_STATIC_CONST FTYPE halfpln2 = FLIT(8.32);

  #define CPOLY(x)	((c[0] * x + c[1]) * x + c[2])
  #define SPOLY(x)	((s[0] * x + s[1]) * x + s[2])

_STATIC_CONST FTYPE c[] = {	/* |x| < ln(2) */
	FLIT( 0.1585177015e-1),
	FLIT( 0.4436509950),
	FLIT( 0.9981704274),
	};
_STATIC_CONST FTYPE s[] = {
	FLIT( 0.1057492273e-2),
	FLIT( 0.1109275208),
	FLIT( 0.9981704276),
	};

 #elif FBITS <= 57
_STATIC_CONST FTYPE halfpln2 = FLIT(19.76);

  #define CPOLY(x)	(c[0] * x + c[1])
  #define SPOLY(x)	((s[0] * x + s[1]) * x + s[2])

_STATIC_CONST FTYPE c[] = {	/* 5th-order, |x| < ln(2)/2 (100.0%) */
	FLIT( 0.01750072318694301863),
	FLIT( 0.44846583775713999745),
	};
_STATIC_CONST FTYPE s[] = {
	FLIT(-0.00000638332552609522),
	FLIT( 0.00134544393444808061),
	FLIT( 0.11513250442380779058),
	};

 #elif FBITS <= 71
_STATIC_CONST FTYPE halfpln2 = FLIT(24.61);

  #define CPOLY(x)	((c[0] * x + c[1]) * x + c[2])
  #define SPOLY(x)	((s[0] * x + s[1]) * x + s[2])

_STATIC_CONST FTYPE c[] = {	/* 6th-order, |x| < ln(2)/2 (100.0%) */
	FLIT( 0.00020696020152007992945634),
	FLIT( 0.02330329902739970135468429),
	FLIT( 0.46152333099254421099513332),
	};
_STATIC_CONST FTYPE s[] = {
	FLIT( 0.0000073840231396924596636),
	FLIT( 0.0027955220298849456025345),
	FLIT( 0.1281899976592108777990220),
	};

 #elif FBITS <= 125
_STATIC_CONST FTYPE halfpln2 = FLIT(43.33);

  #define CPOLY(x)	((((c[0] * x + c[1]) * x + c[2]) * x + c[3]) * x + c[4])
  #define SPOLY(x)	((((s[0] * x + s[1]) * x + s[2]) * x + s[3]) * x + s[4])

_STATIC_CONST FTYPE c[] = {	/* 9th-order, |x| < ln(2)/2 (100.0%) */
	FLIT( 0.00000000479572627136582713642655232360907),
	FLIT( 0.00000327477333679019896114550152093706361),
	FLIT( 0.00055030065216154133882249297095438191102),
	FLIT( 0.03007356026311641196754358517430911119925),
	FLIT( 0.47618701728773560854179734623107874650052),
	};
_STATIC_CONST FTYPE s[] = {
	FLIT( 0.0000000000726306330285737396220950671593),
	FLIT( 0.0000001559084838092647986147092019374643),
	FLIT( 0.0000491289012335169012460234429776073008),
	FLIT( 0.0046778878338712091202778030972754230619),
	FLIT( 0.1428536839544022752084640128977454362166),
	};

 #else /* FBITS */
  #error tanh has insufficient precision
 #endif /* FBITS */

_STATIC_CONST FTYPE ln2by2 = FLIT(0.34657359027997265470861606072908827);
_STATIC_CONST FTYPE ln2 = FLIT(0.69314718055994530941723212145817657);

 #if FBITS <= 24

 #else /* FBITS <= 24 */
static FTYPE FNAME(Tanh_approx)(FTYPE x)
	{	/* compute tanh(x) for |x| < ln(2)/2 */
	const FTYPE z = x * x;
	const FTYPE ch = FLIT(1.0) + z * CPOLY(z);

	x += x * z * SPOLY(z);
	return (FDIV(x, ch));
	}
 #endif /* FBITS <= 24 */

FTYPE (_CDECL FFUN(tanh))(FTYPE x)
	{	/* compute tanh(x) */
	short neg;

	switch (FNAME(Dtest)(&x))
		{	/* test for special codes */
	case _NANCODE:
		return (x);

	case _INFCODE:
		return (FISNEG(x) ? FLIT(-1.0) : FLIT(1.0));

	case 0:
		return (x);

	default:	/* finite */
		if (x < FLIT(0.0))
			{	/* make positive and remember sign */
			FNEGATE(x);
			neg = 1;
			}
		else
			neg = 0;

		if (x < FCONST(Rteps))
			;	/* x tiny */

 #if FBITS <= 24
		else if (x < ln2)
			{	/* use approximation */
			const FTYPE xsq = x * x;

			x *= FDIV(SPOLY(xsq), CPOLY(xsq));
			}

 #else /* FBITS <= 24 */
		else if (x < ln2by2)
			x = FNAME(Tanh_approx)(x);
		else if (x < ln2)
			{	/* use half argument formula */
			const FTYPE z = FNAME(Tanh_approx)(x * FLIT(0.5));

			x = FLIT(2.0) * FDIV(z, (FLIT(1.0) + z * z));
			}
 #endif /* FBITS <= 24 */

		else if (x < halfpln2)
			x = FLIT(1.0) - FDIV(FLIT(2.0), (FLIT(1.0) + FFUN(exp)(x + x)));
		else
			x = FLIT(1.0);	/* x large */

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
