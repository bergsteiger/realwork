/* xxstod.h -- _[W]Sto[d f ld] common functionality */

#define D16TO7	FLIT(268435456.0)	/* 16^7 */
#define D10TO9	FLIT(1e9)			/* 10^9 */
#define NLONG	((FBITS + 27) / 28)	/* 7 * NLONG == max hexadecimal digits */

/*
FTYPE _Stodx(const CTYPE *s, CTYPE **endptr, long pten, int *perr)
 */
	{	/* convert string to FTYPE, with checking */
	FTYPE x;
	long lo[NLONG + 1];
	const CTYPE *s0 = s;
	int code = CNAME(Stopfx)(&s, endptr);
	const int neg = code & FL_NEG;

	extern FTYPE FNAME(Dtentox)(FTYPE, long, int *);

	if (perr != 0)
		*perr = 0;
	if ((code &= ~FL_NEG) == FL_DEC)
		{	/* parse decimal format */
		const int nlo = CNAME(Stoflt)(s0, s, endptr, lo, NLONG);
		int i;

		if (nlo == 0)
			x = FLIT(0.0);
		else
			for (i = 1, x = (FTYPE)lo[1]; i < nlo; )
				x = x * D10TO9 + (FTYPE)lo[++i];

		x = FNAME(Dtentox)(x, pten + lo[0], perr);
		}
	else if (code == FL_HEX)
		{	/* parse hexadecimal format */
		const int nlo = CNAME(Stoxflt)(s0, s, endptr, lo, NLONG);
		int i;

		if (nlo == 0)
			x = FLIT(0.0);
		else
			for (i = 1, x = (FTYPE)lo[1]; i < nlo; )
				x = x * D16TO7 + (FTYPE)lo[++i];

		FNAME(Dscale)(&x, lo[0]);
		x = FNAME(Dtentox)(x, pten, perr);
		}
	else if (code == FL_INF)
		x = FCONST(Inf);
	else if (code == FL_NAN)
		x = FCONST(Nan);
	else
		x = 0;	/* code == FL_ERR */
	return (neg != 0 ? -x : x);
	}

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
