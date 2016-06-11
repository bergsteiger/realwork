/* fileno function */
#include <stdio.h>
_STD_BEGIN

int (fileno)(FILE *str)
	{	/* return file descriptor from FILE object */
	return (str != 0 && _FD_VALID(str->_Handle) ? _FD_NO(str) : -1);
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
