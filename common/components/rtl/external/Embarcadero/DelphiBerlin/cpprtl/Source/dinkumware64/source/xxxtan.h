/* xxxtan.h -- common _[FL]Tan[fl] functionality */
#include "xmath.h"
_C_LIB_DECL

unsigned int _CDECL FNAME(Quad)(FTYPE *px, int retcode);

	/* coefficients */

 #if   FBITS <= 25
  #define CPOLY(x)	(c[0] * x + c[1])
  #define SPOLY(x)	(s[0])

_STATIC_CONST FTYPE c[] = {	/* s3/c4, |x| < pi/4 (100.0%) */
	FLIT( 0.0097099364),
	FLIT(-0.4291161787),
	};
_STATIC_CONST FTYPE s[] = {
	FLIT(-0.0957822992),
	};

 #elif FBITS <= 54
  #define CPOLY(x)	((c[0] * x + c[1]) * x + c[2])
  #define SPOLY(x)	((s[0] * x + s[1]) * x + s[2])

_STATIC_CONST FTYPE c[] = {	/* s7/c6, |x| < pi/4 (100.0%) */
	FLIT(-0.00020844956382258822),
	FLIT( 0.02334489464693293380),
	FLIT(-0.46161689768996201755),
	};
_STATIC_CONST FTYPE s[] = {
	FLIT(-0.00000748373924372997),
	FLIT( 0.00280592875035233052),
	FLIT(-0.12828356435663158978),
	};

 #elif FBITS <= 65
  #define CPOLY(x)	(((c[0] * x + c[1]) * x + c[2]) * x + c[3])
  #define SPOLY(x)	((s[0] * x + s[1]) * x + s[2])

_STATIC_CONST FTYPE c[] = {	/* s7/c8, |x| < pi/4 (100.0%) */
	FLIT( 0.0000004982155748201469973),
	FLIT(-0.0003118197048739718596888),
	FLIT( 0.0256639305740064946020274),
	FLIT(-0.4667170495229229421344638),
	};
_STATIC_CONST FTYPE s[] = {
	FLIT(-0.0000178621483399276882542),
	FLIT( 0.0034249140663654322654332),
	FLIT(-0.1333837161895896063094998),
	};

 #elif FBITS <= 122
  #define CPOLY(x)	(((((c[0] * x + c[1]) * x + c[2]) * x + c[3]) * x \
		+ c[4]) * x + c[5])
  #define SPOLY(x)	(((((s[0] * x + s[1]) * x + s[2]) * x + s[3]) * x \
		+ s[4]) * x + s[5])

_STATIC_CONST FTYPE c[] = {	/* s13/c12, |x| < pi/4 (100.0%) */
	FLIT( 0.0000000000115609621956528865273653190745),
	FLIT(-0.0000000152282257707155133503259641727415),
	FLIT( 0.0000052362461617507082702365563783865073),
	FLIT(-0.0006628415426839907049976317509687715401),
	FLIT( 0.0318890553302089929317034042452254748273),
	FLIT(-0.4800104942477280723430750249033451924731),
	};
_STATIC_CONST FTYPE s[] = {
	FLIT( 0.0000000000001272546759264684873261426622),
	FLIT(-0.0000000005196106495025209303140153897877),
	FLIT( 0.0000003233844616565437096178594026037773),
	FLIT(-0.0000663016973907677862049130215087603811),
	FLIT( 0.0052188905809663021506783959441132263779),
	FLIT(-0.1466771609143947390097416915700118926095),
	};

 #else /* FBITS */
  #error tan has insufficient precision
 #endif /* FBITS */

static FTYPE FNAME(Tan_approx)(FTYPE x, unsigned int invert)
	{	/* compute tan(x), |x| <= 1 */
	const FTYPE z = x * x;
	const FTYPE xd = FLIT(1.0) + z * CPOLY(z);

	x += x * z * SPOLY(z);

	if (invert)
		return (FDIV(-xd, x));
	else
		return (FDIV(x, xd));
	}

 #if FBITS == 24
_STATIC_CONST FTYPE atan7_8 = FLIT(0.71882999962162450541701415152590464);
 #endif /* FBITS == 24 */

FTYPE (_CDECL FNAME(Tan))(FTYPE x, int retcode)
	{	/* compute tan(x) */
	switch (FNAME(Dtest)(&x))
		{
	case _NANCODE:
		return (x);

	case _INFCODE:
		_Feraise(_FE_INVALID);
		return (FCONST(Nan));

	case 0:
		return (x);

	default:	/* finite */
		 {	/* finite */
		unsigned int invert = FNAME(Quad)(&x, retcode) & 0x1;
		unsigned int negate = 0;

		if (x < FLIT(0.0))
			{	/* negate and set flag */
			FNEGATE(x);
			negate = 1;
			}

		if (x < FCONST(Rteps))
			{	/* tan(tiny)==tiny, |cot(tiny)|==Inf */
			if (invert)
				{	/* invert and test for overflow */
				short xexp;

				FNAME(Dunscale)(&xexp, &x);
				x = -FINVERT(x);
				if (0 < FNAME(Dscale)(&x, -xexp))
					_Feraise(_FE_OVERFLOW);

				invert = 0;	/* just negate at end */
				}
			}

 #if FBITS == 24
		else if (FLIT(0.7) < x)
			{	/* close to pi/4 */
			FTYPE eps = x - atan7_8;
			FTYPE tanb = FNAME(Tan_approx)(eps, 0);

			x = FDIV(tanb + FLIT(0.875), FLIT(1.0) - FLIT(0.875) * tanb);
			}
 #endif /* FBITS == 24 */

		else
			{	/* approximate, inverting as needed */
			x = FNAME(Tan_approx)(x, invert);
			invert = 0;
			}

		if (invert)
			x = -FINVERT(x);
		if (negate)
			FNEGATE(x);
		return (x);
		 }
		}
	}
_END_C_LIB_DECL

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
