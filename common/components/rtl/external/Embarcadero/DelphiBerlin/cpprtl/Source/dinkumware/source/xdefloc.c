/* _Defloc function */
#include <string.h>
#include "xlocale.h"
#include "xmtx.h"
_STD_BEGIN

const char *_Defloc(void)
	{	/* find name of default locale */
	char *s;

	if ((s = getenv("LOCALE")) == 0)
		s = "C";
	return (s);
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
