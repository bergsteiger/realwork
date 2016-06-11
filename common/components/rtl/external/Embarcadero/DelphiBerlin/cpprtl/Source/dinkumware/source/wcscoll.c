/* wcscoll function */
#include <wchar.h>
 #include "xwcsxfrm.h"
 #include "xmtloc.h"

_STD_BEGIN

		/* type definitions */
typedef struct {
	wchar_t buf[32];
	const wchar_t *s1;
	const wchar_t *s2;
	const wchar_t *sout;
	mbstate_t state;
	} _WSctl;

static size_t getwxfrm(_WSctl *p, _Statab *pcostate)
	{	/* get transformed wchar_ts */
	size_t i;

	do	{	/* loop until wchar_t's delivered */
		p->sout = (const wchar_t *)p->buf;
		i = _CWcsxfrm(p->buf, &p->s1,
			sizeof (p->buf) / sizeof (wchar_t), &p->state, pcostate);
		if (0 < i && p->buf[i - 1] == L'\0')
			break;
		else if (*p->s1 == L'\0')
			p->s1 = p->s2;	/* rescan */
		} while (i == 0);
	return (i);
	}

int _Wcscollx(const wchar_t *s1, const wchar_t *s2, _Statab *pcostate)
	{	/* compare s1[], s2[] using given locale-dependent rule */
	size_t n1, n2;
	_WSctl st1, st2;
	static const mbstate_t initial = {0};

	st1.s1 = st1.s2 = (const wchar_t *)s1;
	st1.state = initial;
	st2.s1 = st2.s2 = (const wchar_t *)s2;
	st2.state = initial;
	for (n1 = n2 = 0; ; )
		{	/* compare transformed wchar_ts */
		int ans;
		size_t n;

		if (n1 == 0)
			n1 = getwxfrm(&st1, pcostate);
		if (n2 == 0)
			n2 = getwxfrm(&st2, pcostate);
		n = n1 < n2 ? n1 : n2;
		if (n == 0)
			return (n1 == n2 ? 0 : 0 < n2 ? -1 : +1);
		else if ((ans = wmemcmp(st1.sout, st2.sout, n)) != 0
			|| n1 == n2 && st1.sout[n - 1] == L'\0')
			return (ans);
		st1.sout += n, n1 -= n;
		st2.sout += n, n2 -= n;
		}
	}

int (wcscoll)(const wchar_t *s1, const wchar_t *s2)
	{	/* compare s1[], s2[] using global locale-dependent rule */
	return (_Wcscollx(s1, s2, _TLS_DATA_PTR(_WCostate)));
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
