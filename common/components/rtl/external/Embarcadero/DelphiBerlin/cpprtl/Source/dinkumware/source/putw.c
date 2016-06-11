/* putw traditional function */
#include "xstdio.h"
_STD_BEGIN

int (putw)(int word, FILE *str)
	{	/* put an int to stream */
	int ans, n;
	unsigned char *s = (unsigned char *)&word;

	ans = 0;
	_Lockfileatomic(str);
	for (n = 0; n < sizeof (int); ++n, ++s)
		if (fputc(*s, str) == EOF)
			{	/* write failed, give up */
			ans = EOF;
			break;
			}
	_Unlockfileatomic(str);
	return (ans);
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
