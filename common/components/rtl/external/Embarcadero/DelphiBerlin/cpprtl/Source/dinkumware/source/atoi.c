/* atoi function */
#include <stdlib.h>
_STD_BEGIN

int (atoi)(const char *s)
	{	/* convert string to int */
	return ((int)_Stoul(s, 0, 10));
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
