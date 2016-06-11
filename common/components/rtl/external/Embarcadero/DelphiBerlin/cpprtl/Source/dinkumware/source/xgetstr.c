/* _Getstr function */
#include <ctype.h>
#include <string.h>
#include "xwchar.h"
#include "xstdio.h"
_STD_BEGIN

static int ranmatch(const char *s, int c, size_t n)
	{	/* look for c in [] with ranges */
	const unsigned char uc = (unsigned char)c;
	const unsigned char *su = (const unsigned char *)s;

	while (3 <= n)
		if (su[1] == '-')
			if (su[0] <= uc && uc <= su[2])
				return (1);
			else
				su += 3, n -= 3;
		else if (su[0] == uc)
			return (1);
		else
			++su, --n;
	for (; 0 < n; ++su, --n)
		if (su[0] == uc)
			return (1);
	return (0);
	}

int _Getstr(_Sft *px, int sfl)
	{	/* convert %[] (sfl < 0), %c (sfl == 0), else %s */
	char comp, *s;
	char range = 0;
	char seen = 0;
	const char *pset, *t;
	int ch, nset;
	int wfl = px->qual == 'l';
	wchar_t *p;
	_Mbstinit(mbst);

	if (sfl < 0)
		{	/* parse [] in format */
		comp = (char)(*++px->s == '^' ? *px->s++ : '\0');
		t = strchr(*px->s == ']' ? px->s + 1 : px->s, ']');
		if (t == 0)
			return (0);
		nset = t - px->s;
		pset = px->s;
		px->s = t;
		if (3 <= nset && memchr(pset + 1, '-', nset - 2))
			range = 1;
		}
	px->nget = 0 < px->width ? px->width :
		sfl != 0 ? INT_MAX : 1;

	if (px->noconv)
		;
	else if (wfl)
		p = va_arg(px->ap, wchar_t *);
	else
		s = va_arg(px->ap, char *);

	 {	/* deliver characters */
	int nc = 0;

	while ((ch = GETN(px)) != EOF)
		if (0 < sfl && isspace(ch) || sfl < 0
			&& (!range && (!comp && !memchr(pset, ch, nset)
					|| comp && memchr(pset, ch, nset))
				|| range && (!comp && !ranmatch(pset, ch, nset)
					|| comp && ranmatch(pset, ch, nset))))
			break;
		else if (!wfl)
			{	/* deliver a single byte */
			if (px->noconv)
				;
			else if (px->prec == 0)
				{	/* no room to store character, fail */
				seen = 1;
				break;
				}
			else
				{	/* enough room, store and count char */
				*s++ = (char)ch;
				px->stored = 1;
				--px->prec;
				}
			seen = 2;
			}
		else
			{	/* build a wchar_t */
			char buf[MB_LEN_MAX];
			int n;
			wchar_t wc;

			buf[nc++] = (char)ch;
			switch (n = _Mbtowc(&wc, buf, nc, &mbst))
				{	/* try to build a wchar_t */
			case -2:
				seen |= 1;	/* partial wchar_t */
				if (nc < sizeof (buf))
					break;	/* try again with more chars */

			case -1:
				for (; 0 < nc; )
					{	/* stop on conversion error */
					int ch = buf[--nc];
					UNGETN(px, ch);
					}
				return (seen ? 0 : EOF);

			case 0:
				if (wc == L'\0')	/* may be null wide char */
					n = strlen(buf) + 1;

			default:	/* fall through */
				if (n == -3)
					n = 0;
				for (; n < nc; )	/* got a wchar_t, count and deliver */
					{	/* return unused chars */
					int ch = buf[--nc];
					UNGETN(px, ch);
					}

				if (px->noconv)
					;
				else if (px->prec == 0)
					{	/* no room to store character, fail */
					seen = 1;
					break;
					}
				else
					{	/* enough room, store and count char */
					*p++ = wc;
					px->stored = 1;
					--px->prec;
					}
				--px->width;
				seen = 2;	/* whole wchar_t */
				nc = 0;
				}
			}
	 }
	UNGETN(px, ch);
	if (sfl != 0 && seen == 2)
		;	/* store terminating nul */
	else if (seen == 2)
		return (1);	/* success, delivered a character */
	else if ((seen & 1) != 0 || ch == EOF)
		return (EOF);	/* conversion or input failure */
	else
		return (0);	/* matching failure */

	if (px->noconv)
		;
	else if (px->prec == 0)
		return (0);	/* no room to store nul, fail */
	else if (wfl)
		*p = L'\0';
	else
		*s = '\0';
	return (1);
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
