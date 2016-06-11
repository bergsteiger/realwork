/* xxtan.h -- common tan[fl] functionality */
#include "xmath.h"
_STD_BEGIN

unsigned int FNAME(Quad)(FTYPE *px);

	/* coefficients */

 #if   FBITS <= 25
  #define CPOLY(x)	(c[0] * x + c[1])
  #define SPOLY(x)	(s[0])

static const FTYPE c[] = {	/* s3/c4, |x| < pi/4 (100.0%) */
	FLIT( 0.0097099364),
	FLIT(-0.4291161787),
	};
static const FTYPE s[] = {
	FLIT(-0.0957822992),
	};

 #elif FBITS <= 54
  #define CPOLY(x)	((c[0] * x + c[1]) * x + c[2])
  #define SPOLY(x)	((s[0] * x + s[1]) * x + s[2])

static const FTYPE c[] = {	/* s7/c6, |x| < pi/4 (100.0%) */
	FLIT(-0.00020844956382258822),
	FLIT( 0.02334489464693293380),
	FLIT(-0.46161689768996201755),
	};
static const FTYPE s[] = {
	FLIT(-0.00000748373924372997),
	FLIT( 0.00280592875035233052),
	FLIT(-0.12828356435663158978),
	};

 #elif FBITS <= 65
  #define CPOLY(x)	(((c[0] * x + c[1]) * x + c[2]) * x + c[3])
  #define SPOLY(x)	((s[0] * x + s[1]) * x + s[2])

static const FTYPE c[] = {	/* s7/c8, |x| < pi/4 (100.0%) */
	FLIT( 0.0000004982155748201469973),
	FLIT(-0.0003118197048739718596888),
	FLIT( 0.0256639305740064946020274),
	FLIT(-0.4667170495229229421344638),
	};
static const FTYPE s[] = {
	FLIT(-0.0000178621483399276882542),
	FLIT( 0.0034249140663654322654332),
	FLIT(-0.1333837161895896063094998),
	};

 #elif FBITS <= 122
  #define CPOLY(x)	(((((c[0] * x + c[1]) * x + c[2]) * x + c[3]) * x \
		+ c[4]) * x + c[5])
  #define SPOLY(x)	(((((s[0] * x + s[1]) * x + s[2]) * x + s[3]) * x \
		+ s[4]) * x + s[5])

static const FTYPE c[] = {	/* s13/c12, |x| < pi/4 (100.0%) */
	FLIT( 0.0000000000115609621956528865273653190745),
	FLIT(-0.0000000152282257707155133503259641727415),
	FLIT( 0.0000052362461617507082702365563783865073),
	FLIT(-0.0006628415426839907049976317509687715401),
	FLIT( 0.0318890553302089929317034042452254748273),
	FLIT(-0.4800104942477280723430750249033451924731),
	};
static const FTYPE s[] = {
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

_CRTIMP2 FTYPE (FFUN(tan))(FTYPE x)
	{	/* compute tan(x) */
	unsigned int quad;

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
		quad = FNAME(Quad)(&x);
		if (-FCONST(Rteps) < x && x < FCONST(Rteps))
			{	/* tan(tiny)==tiny, |cot(tiny)|==Inf */
			if ((quad & 0x1) != 0)
				{	/* invert and test for overflow */
				short xexp;

				FNAME(Dunscale)(&xexp, &x);
				x = -FLIT(1.0) / x;
				if (0 < FNAME(Dscale)(&x, -xexp))
					_Feraise(_FE_OVERFLOW);
				}
			return (x);
			}
		else
			{	/* x*x worth computing */
			const FTYPE z = x * x;
			const FTYPE xd = FLIT(1.0) + z * CPOLY(z);

			x += x * z * SPOLY(z);
			return ((quad & 0x1) != 0 ? -xd / x : x / xd);
			}
		}
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
