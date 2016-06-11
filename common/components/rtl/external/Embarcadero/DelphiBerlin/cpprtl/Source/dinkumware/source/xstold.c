/* _Stold function */
#include <yvals.h>	/* include first, for native shared */
#include <stdlib.h>
#include "xmath.h"
#include "xxcctype.h"
#include "xxlftype.h"
_STD_BEGIN

_CRTIMP2 FTYPE _Stoldx(const CTYPE *s, CTYPE **endptr, long pten, int *perr)

	#include "xxstod.h"

_CRTIMP2 FTYPE _Stold(const CTYPE *s, CTYPE **endptr, long pten)
	{	/* convert string, discard error code */
	return (_Stoldx(s, endptr, pten, 0));
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
