/* _Getloc function */
#include <string.h>
#include "xlocale.h"
#include "xmtx.h"
_STD_BEGIN

static _Once_t freeallreg_o = _ONCE_T_INIT;

static void freeall(void)
	{	/* free all constructed locales */
	_Linfo *p, *q;

	for (p = _Clocale._Next; p != 0; p = q)
		{	/* free a locale */
		q = p->_Next;
		_Freeloc(p);
		free(p);
		}
	_Freeloc(&_Clocale);
	_Clocale._Next = 0;
	}

static void freeallreg(void)
	{	/* register freeall with _Atexit */
	_Atexit(&freeall);
	}

_Linfo *_Getloc(const char *nmcat, const char *lname)
	{	/* get locale pointer, given category and name */
	const char *ns, *s;
	size_t nl;
	_Linfo *p;

	 {	/* find category component of name */
	size_t n;

	for (ns = 0, s = lname; ; s += n + 1)
		{	/* look for exact match or LC_ALL */
		if (s[n = strcspn(s, ":;")] == '\0' || s[n] == ';')
			{	/* memorize first LC_ALL */
			if (ns == 0 && 0 < n)
				ns = s, nl = n;
			if (s[n] == '\0')
				break;
			}
		else if (memcmp(nmcat, s, ++n) == 0)
			{	/* found exact category match */
			ns = s + n, nl = strcspn(ns, ";");
			break;
			}
		else if (s[n += strcspn(s + n, ";")] == '\0')
			break;
		}
	if (ns == 0)
		return (0);	/* invalid name */
	 }

	_Locksyslock(_LOCK_LOCALE);
	for (p = &_Clocale; p != 0; p = p->_Next)
		if (memcmp(p->_Name, ns, nl) == 0
			&& p->_Name[nl] == '\0')
			break;
	_Unlocksyslock(_LOCK_LOCALE);

	if (p == 0)
		{	/* look for locale in file */
		p = _Findloc(ns, nl);
		_Once(&freeallreg_o, freeallreg);
		}
	return (p);
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
