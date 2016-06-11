/* xxxlog.h -- common _[FL]Log functionality */
#include "xmath.h"
_C_LIB_DECL

	/* coefficients */

 #if   FBITS <= 29
  #define POLY(x)	((p[0] * x + p[1]) * x + p[2])

_STATIC_CONST FTYPE p[] = {	/* 7th-order, |x| < 3-sqrt(8) (100.6%) */
	FLIT(0.2988439998),
	FLIT(0.3997655209),
	FLIT(0.6666679125),
	};

 #elif FBITS <= 58
  #define POLY(x)	((((((p[0] * x + p[1]) * x + p[2]) * x + p[3]) * x \
		+ p[4]) * x + p[5]) * x + p[6])

_STATIC_CONST FTYPE p[] = {	/* 15th-order, |x| < 3-sqrt(8) (100.6%) */
	FLIT(0.14821919759901168116),
	FLIT(0.15310988435285788981),
	FLIT(0.18183706393900951476),
	FLIT(0.22222195289721309521),
	FLIT(0.28571428781619503202),
	FLIT(0.39999999999190497071),
	FLIT(0.66666666666667803987),
	};

 #elif FBITS <= 65
  #define POLY(x)	FNAME(Poly)(x, p, sizeof (p) / sizeof (p[0]) - 1)

_STATIC_CONST FTYPE p[] = {	/* 17th-order, |x| < 3-sqrt(8) (100.0%) */
	FLIT(0.1327680826338742192908640),
	FLIT(0.1324674536632767899145529),
	FLIT(0.1538727259804757955356993),
	FLIT(0.1818177053520575356615782),
	FLIT(0.2222222272759802071931758),
	FLIT(0.2857142856838784420880559),
	FLIT(0.4000000000000923019955483),
	FLIT(0.6666666666666665630936037),
	};

 #elif FBITS <= 115
  #define POLY(x)	FNAME(Poly)(x, p, sizeof (p) / sizeof (p[0]) - 1)

_STATIC_CONST FTYPE p[] = {	/* 31st-order, |x| < 3-sqrt(8) (100.0%) */
	FLIT(0.08086268728765501677683874803969752),
	FLIT(0.06712825304193905811323134158334079),
	FLIT(0.07419560304066842238308203240242130),
	FLIT(0.07999466041970284454952996883845959),
	FLIT(0.08695668687203596906044460986919951),
	FLIT(0.09523809153405189173540786520947686),
	FLIT(0.10526315795583998099709572203087774),
	FLIT(0.11764705882278624569246631763969077),
	FLIT(0.13333333333333994908363270326605944),
	FLIT(0.15384615384615380379461608521885420),
	FLIT(0.18181818181818181837110062153574782),
	FLIT(0.22222222222222222222165982060412269),
	FLIT(0.28571428571428571428571531211897084),
	FLIT(0.39999999999999999999999999900274571),
	FLIT(0.66666666666666666666666666666703732),
	};

 #else /* FBITS */
  #error log has insufficient precision
 #endif /* FBITS */

_STATIC_CONST FTYPE loge2hi = (FTYPE)(5814539.0 / 8388608.0);
_STATIC_CONST FTYPE loge2lo = FLIT(1.1730463525082348212145817656807550e-7);

_STATIC_CONST FTYPE logx2hi = (FTYPE)(2525222.0 / 8388608.0);
_STATIC_CONST FTYPE logx2lo = FLIT(7.5085978265526238894724493026768190e-8);

_STATIC_CONST FTYPE logxehi = (FTYPE)(3643126.0 / 8388608.0);
_STATIC_CONST FTYPE logxelo = FLIT(1.9699272335463628918916605082294398e-8);
_STATIC_CONST FTYPE logxe = FLIT(0.43429448190325182765112891891660507);

_STATIC_CONST FTYPE log2ehi = (FTYPE)(12102203.0 / 8388608.0);
_STATIC_CONST FTYPE log2elo = FLIT(1.9259629911266174681001892137426646e-8);
_STATIC_CONST FTYPE log2e = FLIT(1.4426950408889634073599246810018922);

_STATIC_CONST FTYPE rthalf = FLIT(0.70710678118654752440084436210484905);

FTYPE _CDECL FNAME(Log)(FTYPE x, int baseflag)
	{	/* compute ln(x) */
	short xexp;

	switch (FNAME(Dunscale)(&xexp, &x))
		{	/* test for special codes */
	case _NANCODE:
		return (x);

	case 0:
		_Feraise(_FE_DIVBYZERO);
		return (-FCONST(Inf));

	case _INFCODE:
		if (!FISNEG(x))
			return (x);

	default:	/* finite, can fall through */
		if (FISNEG(x))
			{	/* ln(negative) undefined */
			_Feraise(_FE_INVALID);
			return (FCONST(Nan));
			}
		else
			{	/* 1/2 <= x < 1 */
			FTYPE x1, w, z;

			if (x < rthalf)
				{	/* x <= sqrt(1/2) */
				x += x;
				--xexp;
				}
			x1 = x - FLIT(1.0);
			z = FDIV(x1, x + FLIT(1.0));
			w = z * z;
			z *= x1 - w * POLY(w);

			w = xexp;
			if (baseflag == 0)
				z = x1 - (z - loge2lo * w)
					+ loge2hi * w;	/* ln */
			else if (0 < baseflag)
				z = logxehi * x1
					+ (logxelo * x1 - (logxe * z - logx2lo * w))
						+ logx2hi * w;	/* log10 */
			else
				z = log2ehi * x1
					+ (log2elo * x1 - log2e * z)
						+ w;	/* log2 */
			return (z);
			}
		}
	}

FTYPE FNAME(Logpoly)(FTYPE w)
	{	/* compute log(1+x) - x, rt(1/2) <= 1+x <= rt(2) */
	return (POLY(w));
	}

_END_C_LIB_DECL

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
