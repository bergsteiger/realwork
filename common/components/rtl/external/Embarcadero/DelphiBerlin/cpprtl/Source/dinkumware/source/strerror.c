/* strerror function */
#include <errno.h>
#include <string.h>
_STD_BEGIN

char *_Strerror(int errcode, char *buf);

char *(strerror)(int errcode)
	{	/* find error message corresponding to errcode */
	return (_Strerror(errcode, 0));
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
