/* iswpunct function */
#include <wctype.h>
_STD_BEGIN

int (iswpunct)(wint_t wc)
	{	/* test for punctutation wide character */
	return (_Iswctype(wc, 8));
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
