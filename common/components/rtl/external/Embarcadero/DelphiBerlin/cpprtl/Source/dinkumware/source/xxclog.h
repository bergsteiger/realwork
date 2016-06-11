/* xxclog.h -- common clog[fl] functionality */
#include <complex.h>
#include "xmath.h"
_STD_BEGIN

FTYPE FFUN(log1p)(FTYPE x);

 #if FBITS < 24
  #error clog has too much precision
 #endif /* FBITS < 24 */

FCTYPE (FFUN(clog))(FCTYPE x)
	{	/* compute complex logarithm */
	FTYPE re = FFUN(creal)(x);
	FTYPE im = FFUN(cimag)(x);
	short errx = FNAME(Dtest)(&re);
	short erry = FNAME(Dtest)(&im);
	FTYPE theta;

	if (errx == _NANCODE)
		if (erry == _INFCODE)
			return (FNAME(Cbuild)(FCONST(Inf), re));	/* (NaN, +/-INF) */
		else
			return (FNAME(Cbuild)(re, re));	/* (NaN, finite or NaN) */
	else if (erry == _NANCODE)
		if (errx == _INFCODE)
			return (FNAME(Cbuild)(FCONST(Inf), im));	/* (+/-INF, NaN) */
		else
			return (FNAME(Cbuild)(im, im));	/* (finite, NaN) */

	theta = FFUN(atan2)(im, re);	/* get phase */

	if (errx == _INFCODE || erry == _INFCODE)
		return (FNAME(Cbuild)(FCONST(Inf), theta));	/* real is Inf */
	else
		{	/* compute log of zero/finite magnitude for real part */
		if (re < FLIT(0.0))
			re = -re;
		if (im < FLIT(0.0))
			im = -im;

		if (re < im)
			{	/* ensure that 0 <= im <= re */
			FTYPE temp = re;

			re = im;
			im = temp;
			}

		if (re == FLIT(0.0))
			{	/* magnitude is zero, raise zero divide */
			_Feraise(_FE_DIVBYZERO);
			return (FNAME(Cbuild)(-FCONST(Inf), theta));
			}
		else if (re <= FLIT(0.9) && FLIT(0.4) <= im)
			{	/* compute near unit circle carefully */
			FTYPE re0 = re;
			FTYPE im0 = im;
			FTYPE norm1;

			FNAME(Dint)(&re0, (FBITS - 1) / 2);	/* get high bits of re, im */
			FNAME(Dint)(&im0, (FBITS - 1) / 2);
			norm1 = (re0 * re0 - FLIT(1.0)) + im0 * im0;
			norm1 += (re - re0) * (re + re0) + (im - im0) * (im + im0);
			return (FNAME(Cbuild)(FLIT(0.5) * FFUN(log1p)(norm1), theta));
			}
		else
			{	/* compute log(x^2*(1+(y/x)^2))/2 carefully */
			FTYPE eps = im / re;	/* eps in [0, 1] */

			return (FNAME(Cbuild)(FFUN(log)(re)
				+ FLIT(0.5) * FFUN(log1p)(eps * eps), theta));
			}
		}
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
