/* xxconj.h -- common conj[fl] functionality */
#include <complex.h>
_STD_BEGIN

FCTYPE (FFUN(conj))(FCTYPE x)
	{	/* find conjugate of complex */
	FTYPE ans[2];

	ans[0] = FFUN(creal)(x);
	ans[1] = -FFUN(cimag)(x);
	return (*(FCTYPE *)&ans[0]);
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
