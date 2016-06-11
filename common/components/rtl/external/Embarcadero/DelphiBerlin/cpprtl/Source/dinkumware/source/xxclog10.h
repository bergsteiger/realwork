/* xxclog10.h -- common clog10[fl] functionality */
#include <complex.h>
_STD_BEGIN

FCTYPE (FFUN(clog10))(FCTYPE x)
	{	/* compute complex base-10 logarithm */
	return (FNAME(Cmulcr)(FFUN(clog)(x),
		FLIT(0.43429448190325182765112891891660507)));
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
