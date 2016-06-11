/* xxxlgamma.h -- common _[FL]Tgamma functionality */
#include "xmath.h"
_STD_BEGIN

	/* coefficients */

 #if   FBITS <= 30
  #define DECLARE(w, xinv)
  #define POLY(xinv, w)	(c[0] * xinv)

static const FTYPE c[] = {	/* Stirling fixup order 0, Gamma_big < x */
	FLIT( 0.0833333333),
	};

 #elif FBITS <= 53
  #define DECLARE(w, xinv)	FTYPE w = xinv * xinv;
  #define POLY(xinv, w)	(((c[0] * w + c[1]) * w + c[2]) * xinv)

static const FTYPE c[] = {	/* Stirling fixup order 2, Gamma_big < x */
	FLIT( 0.00079365079365079364),
	FLIT(-0.00277777777777777777),
	FLIT( 0.08333333333333333333),
	};

 #elif FBITS <= 71
  #define DECLARE(w, xinv)	FTYPE w = xinv * xinv;
  #define POLY(xinv, w)	(((((c[0] * w + c[1]) * w + c[2]) * w + c[3]) * w \
	+ c[4]) * xinv)

static const FTYPE c[] = {	/* Stirling fixup order 4, Gamma_big < x */
	FLIT( 0.0008417508417508417508417),
	FLIT(-0.0005952380952380952380951),
	FLIT( 0.0007936507936507936507938),
	FLIT(-0.0027777777777777777777777),
	FLIT( 0.0833333333333333333333333),
	};

 #elif FBITS <= 117
  #define DECLARE(w, xinv)	FTYPE w = xinv * xinv;
  #define POLY(xinv, w)	(FNAME(Poly)(w, c, \
	sizeof (c) / sizeof (c[0]) - 1) * xinv)

static const FTYPE c[] = {	/* Stirling fixup order 10, Gamma_big < x */
	FLIT(13.40286404416839199447895100069013111),
	FLIT(-1.39243221690590111642743221690590111),
	FLIT( 0.17964437236883057316493849001588940),
	FLIT(-0.02955065359477124183006535947712417),
	FLIT( 0.00641025641025641025641025641025642),
	FLIT(-0.00191752691752691752691752691752691),
	FLIT( 0.00084175084175084175084175084175085),
	FLIT(-0.00059523809523809523809523809523810),
	FLIT( 0.00079365079365079365079365079365079),
	FLIT(-0.00277777777777777777777777777777777),
	FLIT( 0.08333333333333333333333333333333333),
	};

 #else /* FBITS */
  #error _Lgamma has insufficient precision
 #endif /* FBITS */

/* extern const */ FTYPE FNAME(Gamma_big) = FLIT(35.0);
static const FTYPE half_lntwopi = FLIT(0.91893853320467274178032973640561765);

FTYPE FNAME(Lgamma)(FTYPE x)
	{	/* compute ln(gamma(x)), Gamma_big < x */
	FTYPE xinv = FLIT(1.0) / x;
	FTYPE y = FNAME(Log)(x, 0);
	FTYPE z = x;
	DECLARE(w, xinv)
	short xexp;

	FNAME(Dunscale)(&xexp, &z);
	z *= y - FLIT(1.0);
	if (FNAME(Dscale)(&z, xexp) < 0)
		z += half_lntwopi - FLIT(0.5) * y + POLY(xinv, w);
	return (z);
	}
_STD_END

/*
 * Copyright (c) 1992-2003 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V4.02:1422 */
