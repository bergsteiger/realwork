/* imaxdiv function */
#include <inttypes.h>
_STD_BEGIN

imaxdiv_t (imaxdiv)(intmax_t numer, intmax_t denom)
	{	/* compute intmax_t quotient and remainder */
	imaxdiv_t val;
	static const int fixneg = -1 / 2;

	val.quot = numer / denom;
	val.rem = numer - denom * val.quot;
	if (fixneg < 0 && val.quot < 0 && val.rem != 0)
		{	/* fix incorrect truncation */
		val.quot += 1;
		val.rem -= denom;
		}
	return (val);
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
