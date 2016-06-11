/* tmpfile function */
#include <stdlib.h>
#include <string.h>
#include "xstdio.h"
_STD_BEGIN

FILE *(tmpfile)(void)
	{	/* open a temporary file */
	FILE *str;
	char fn[L_tmpnam], *s;

	str = fopen((const char *)tmpnam(fn), "wb+");
	_Lockfileatomic(str);
	if (str == 0)
		;
	else if ((s = (char *)malloc(sizeof (fn) + 1)) == 0)
		fclose(str), str = 0;
	else
		str->_Tmpnam = strcpy(s, fn);
	_Unlockfileatomic(str);
	return (str);
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
