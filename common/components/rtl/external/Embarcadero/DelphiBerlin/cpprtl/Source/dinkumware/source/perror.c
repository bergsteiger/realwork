/* perror function */
#include <errno.h>
#include <string.h>
#include "xstdio.h"
_STD_BEGIN

char *_Strerror(int errcode, char *buf);

void (perror)(const char *s)
	{	/* put error string to stderr */
	if (s != 0 && *s != '\0')
		{	/* put user-supplied prefix */
		fputs(s, stderr);
		fputs(": ", stderr);
		}
	fputs(_Strerror(errno, 0), stderr);
	fputc('\n', stderr);
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
