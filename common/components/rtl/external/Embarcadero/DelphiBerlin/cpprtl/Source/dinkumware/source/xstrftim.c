/* _CStrftime function */
#include <stdlib.h>
#include <string.h>
#include "xtime.h"
#include "xwchar.h"
_STD_BEGIN

#define NSTACK	3	/* depth of format nesting stack */

size_t _CStrftime(char *buf, size_t bufsize, const char *fmt,
	const struct tm *t, const _Tinfo *tin)
	{	/* format time information */
	const char *fmtsav[NSTACK];
	size_t lensav[NSTACK];
	size_t nstack = 0;
	size_t len = strlen(fmt);
	const char *ibuf = buf;
	_Mbstinit(mbst);

	while (0 < len || 0 < nstack)
		{	/* parse format string */
		int n;
		wchar_t wc;

		if (len == 0)
			fmt = fmtsav[--nstack], len = lensav[nstack];
		if ((n = _Mbtowc(&wc, fmt, len, &mbst)) <= 0)
			n = *fmt == '\0' ? 0 : 1;	/* bad parse, eat one char */
		fmt += n, len -= n;
		if (wc != L'%' || len == 0)
			{	/* deliver literal format chars */
			if (bufsize < (size_t)n)
				return (0);
			memcpy(buf, fmt - n, n);
			buf += n, bufsize -= n;
			}
		else
			{	/* do the conversion */
			char ac[20];
			char qual = (char)(*fmt == 'E' || *fmt == 'O' ? *fmt++ : '\0');
			int m;
			const char *p = _Gentime(t, tin, qual, *fmt, &m, ac);

			if (qual != '\0')
				--len;
			++fmt, --len;
			if (0 < m)
				{	/* deliver converted chars */
				if (bufsize < (size_t)m)
					return (0);
				memcpy(buf, p, m);
				buf += m, bufsize -= m;
				}
			else if (len == 0 || NSTACK <= nstack)
				fmt = p, len = -m;	/* tail recursion or stack full */
			else
				{	/* add leftover format to stack */
				fmtsav[nstack] = fmt, fmt = p;
				lensav[nstack++] = len, len = -m;
				}
			}
		}
	if (bufsize == 0)
		return (0);
	*buf = '\0';
	return (buf - (char *)ibuf);
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
