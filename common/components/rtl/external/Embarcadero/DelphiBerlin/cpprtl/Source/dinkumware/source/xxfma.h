/* xxfma.h -- common fma[fl] functionality */
#include "xmath.h"
_STD_BEGIN

extern FTYPE FNAME(Xp_getw)(FTYPE *, int);
extern FTYPE *FNAME(Xp_setw)(FTYPE *, int, FTYPE);
extern FTYPE *FNAME(Xp_mulh)(FTYPE *, int, FTYPE);
extern FTYPE *FNAME(Xp_addx)(FTYPE *, int, FTYPE *, int);

#define ACSIZE	4
#define XSIZE	2

FTYPE (FFUN(fma))(FTYPE x, FTYPE y, FTYPE z)
	{	/* compute x*y+z */
	FTYPE xp = x, yp = y, zp = z;
	short errx, erry, errz;
	short expx, expy, expz;

	if ((errx = FNAME(Dunscale)(&expx, &xp)) == _NANCODE)
		return (x);
	else if ((erry = FNAME(Dunscale)(&expy, &yp)) == _NANCODE)
		return (y);
	else if ((errz = FNAME(Dunscale)(&expz, &zp)) == _NANCODE)
		return (z);
	else if (errx == _INFCODE || erry == _INFCODE)
		if (errx != 0 && erry != 0
			&& (errz != _INFCODE || (FISNEG(x) ^ FISNEG(y)) == FISNEG(z)))
			return (x * y + z);
		else
			{	/* 0*INF, INF*0, INF-INF are invalid */
			_Feraise(_FE_INVALID);
			return (FCONST(Nan));
			}
	else if (errz == _INFCODE)
		return (z);
	else if (errx == 0 || erry == 0 || errz == 0)
		return (x * y + z);
	else
		{	/* all finite */
		long expw = (long)expx + expy;

		expz -= expw;
		if ((FISNEG(x) ^ FISNEG(y) ^ FISNEG(z)) == 0
			|| expz < -2 || 2 < expz)
			return (x * y + z);	/* x*y same sign as z, or different size */
		else
			{	/* compute x*y+z to double precision */
			FTYPE xpx[ACSIZE], xpy[XSIZE], xpz[XSIZE];

			FNAME(Dscale)(&zp, expz);
			FNAME(Xp_setw)(xpx, ACSIZE, xp);
			FNAME(Xp_setw)(xpy, XSIZE, yp);
			FNAME(Xp_setw)(xpz, XSIZE, zp);
			FNAME(Xp_mulh)(xpx, ACSIZE, xpy[0]);
			if (xpy[1] != FLIT(0.0))
				{	/* add in product with lesser word */
				FTYPE xpw[ACSIZE];

				FNAME(Xp_setw)(xpw, ACSIZE, xp);
				FNAME(Xp_mulh)(xpw, ACSIZE, xpy[1]);
				FNAME(Xp_addx)(xpx, ACSIZE, xpw, ACSIZE);
				}
			FNAME(Xp_addx)(xpx, ACSIZE, xpz, XSIZE);
			zp = FNAME(Xp_getw)(xpx, ACSIZE);
			FNAME(Dscale)(&zp, expw);
			return (zp);
			}
		}
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
