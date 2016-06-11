/* iswupper function */
#include <wctype.h>
_STD_BEGIN

int (iswupper)(wint_t wc)
	{	/* test for upper space wide character */
	return (_Iswctype(wc, 10));
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
