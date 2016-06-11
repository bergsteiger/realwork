/* xxxcaddcr.h -- common _[FL]Caddcr functionality */
#include <complex.h>
#include "xmath.h"
_STD_BEGIN

FCTYPE (FNAME(Caddcr))(FCTYPE x, FTYPE y)
	{	/* find complex and real sum */
	return (FNAME(Cbuild)(FFUN(creal)(x) + y, FFUN(cimag)(x)));
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
