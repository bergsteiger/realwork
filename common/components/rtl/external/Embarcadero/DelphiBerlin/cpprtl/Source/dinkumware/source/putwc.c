/* putwc function */
#include "xwstdio.h"
_STD_BEGIN

wint_t (putwc)(wchar_t c, FILE *str)
	{	/* put character to wide stream */
	return (fputwc(c, str));
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
