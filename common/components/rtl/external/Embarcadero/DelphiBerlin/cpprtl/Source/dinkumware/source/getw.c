/* getw traditional function */
#include "xstdio.h"
_STD_BEGIN

int (getw)(FILE *str)
	{	/* get an int from stream */
	int ch, n, word;
	unsigned char *s = (unsigned char *)&word;

	_Lockfileatomic(str);
	for (n = 0; n < sizeof (int); ++n)
		if ((ch = fgetc(str)) != EOF)
			*s++ = (unsigned char)ch;
		else
			{	/* not enough characters, give up */
			word = EOF;
			break;
			}
	_Unlockfileatomic(str);
	return (word);
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
