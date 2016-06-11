/* xxcimag.h -- common cimag[fl] functionality */
#include <complex.h>
_STD_BEGIN

FTYPE (FFUN(cimag))(FCTYPE x)
	{	/* extract imaginary component of complex */
	return (((FTYPE *)&x)[1]);
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
