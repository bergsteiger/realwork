/* _Stod function */
#include <yvals.h>	/* include first, for native shared */
#include <stdlib.h>
#include "xmath.h"
#include "xxcctype.h"
#include "xxdftype.h"
_C_LIB_DECL

_CRTIMP2P FTYPE _PCDECL _Stodx(const CTYPE *s, CTYPE **endptr, long pten,
	int *perr)
	#include "xxstod.h"

_CRTIMP2P FTYPE _PCDECL _Stod(const CTYPE *s, CTYPE **endptr, long pten)
	{	/* convert string, discard error code */
	return (_Stodx(s, endptr, pten, 0));
	}
_END_C_LIB_DECL

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
