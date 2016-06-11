/* xxxcbuild.h -- common _[FL]Cbuild functionality */
#include <complex.h>
#include "xmath.h"
_STD_BEGIN

FCTYPE (FNAME(Cbuild))(FTYPE re, FTYPE im)
	{	/* build complex from real components */
	FTYPE ans[2];

	ans[0] = re;
	ans[1] = im;
	return (*(FCTYPE *)&ans[0]);
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
