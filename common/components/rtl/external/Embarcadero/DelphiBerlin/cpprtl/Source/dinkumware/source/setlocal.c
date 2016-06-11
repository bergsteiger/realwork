/* setlocale function */
#include <ctype.h>
#include <stdlib.h>
#include <string.h>
#include "xlocale.h"
#include "xmtloc.h"
#include "xstrxfrm.h"
#include "xwchar.h"
#include "xwctype.h"
_STD_BEGIN

 #if _LC_COLLATE != 1 || _LC_CTYPE != 2 || _LC_MONETARY != 3 \
	|| _LC_NUMERIC != 4 || _LC_TIME != 5 || _LC_MESSAGES != 6 \
	|| _NCAT != 7
  #error LOCALE CATEGORIES INCONSISTENT
 #endif /* locale categories */

		/* type definitions */
struct _Locprofile {
	_Linfo *_Array[_NCAT];
	};

		/* static data */
typedef char *name_t;

static void free_tls(void *ptr)
	{	/* free any storage pointed at by thread-local namalloc */
	name_t *pnamalloc = (name_t *)ptr;

	free(*pnamalloc);
	}

_TLS_DATA_DEF(static, name_t, curname, "C");
_TLS_DATA_DEF_DT(static, name_t, namalloc, 0, free_tls);

_Linfo _Clocale = {"C"};
static const char *const nmcats[_NCAT] = {
	0, "collate:", "ctype:", "monetary:", "numeric:", "time:",
	"messages:"};

_TLS_DEFINE_INIT(static, struct _Locprofile, profile) =
	{{
	&_Clocale, &_Clocale, &_Clocale, &_Clocale,
	&_Clocale, &_Clocale, &_Clocale}};
_TLS_DEFINE_NO_INIT(static, struct _Locprofile, profile);
static _Once_t cloc_o = _ONCE_T_INIT;

static void initcloc(void)
	{	/* initialize pointer to "C" locale */
	_Clocale._Costate = *_Getpcostate();
	_Clocale._WCostate = *_Getpwcostate();
	_Clocale._Ctype = _Getpctype();
	_Clocale._Tolotab = _Getptolower();
	_Clocale._Touptab = _Getptoupper();
	_Clocale._Mbstate = *_Getpmbstate();
	_Clocale._Wcstate = *_Getpwcstate();
	_Clocale._Wctrans = _Getpwctrtab();
	_Clocale._Wctype = _Getpwctytab();
	_Clocale._Mbcurmax = (char)MB_CUR_MAX;
	_Clocale._Lc = *localeconv();
	_Clocale._Times = *_Getptimes();
	}

_Linfo *_Getcloc(void)
	{	/* get pointer to "C" locale */
	_Once(&cloc_o, initcloc);
	return (&_Clocale);
	}

int _Getnloc(_Linfo **pc, int cat, const char *locname)
	{	/* map locale name to profile */
	_Linfo *p;
	int changed = 0;
	size_t i;

	if ((cat & _M_ALL) != cat)
		return (-1);	/* bad category mask */
	if (locname[0] == '\0')
		locname = _Defloc();
	for (i = 0; ++i < _NCAT; )
		if ((_CATMASK(i) & cat) != 0)
			{	/* set a category */
			if ((p = _Getloc(nmcats[i], locname)) == 0)
				return (-1);
			if (p != pc[i])
				changed = 1;
			pc[i] = p;
			}
	if (cat == _M_ALL && (p = _Getloc("", locname)) != 0
		&& p != pc[0])
		pc[0] = p, changed = 1;
	return (changed);
	}

char *_Getlname(_Linfo **pc, int cat, const char **pn)
	{	/* build a locale name */
	char *s;
	int based;
	size_t i, len, n;

	for (based = 0, len = 0, n = 0, i = 0; ++i < _NCAT; )
		if ((_CATMASK(i) & cat) == 0)
			;
		else if (pc[i] == pc[0])
			based = 1;
		else
			{	/* count a changed subcategory */
			len += strlen(nmcats[i])
				+ strlen(pc[i]->_Name) + 1;
			++n;
			}
	if (n == 0)
		{	/* uniform or vacuous locale */
		free((void *)*pn), *pn = 0;
		return (based ? (char *)pc[0]->_Name : 0);
		}
	if (based)
		len += strlen(pc[0]->_Name);
	else
		--len;
	if ((s = (char *)malloc(len + 1)) == 0)
		return (0);
	else
		{	/* build complex name */
		free((void *)*pn), *pn = s;
		if (based)
			s += strlen(strcpy(s, pc[0]->_Name));
		for (i = 0; ++i < _NCAT; )
			if ((_CATMASK(i) & cat) != 0 && pc[i] != pc[0])
				{	/* add a component */
				if (based)
					*s++ = ';';
				based = 1;
				s += strlen(strcpy(s, nmcats[i]));
				s += strlen(strcpy(s, pc[i]->_Name));
				}
		return ((char *)*pn);
		}
	}

char *(setlocale)(int cat, const char *locname)
	{	/* set new locale */
	name_t *pcurname = _TLS_DATA_PTR(curname);

	if (locname != 0)
		{	/* set categories */
		struct _Locprofile prof = *_TLS_DATA_PTR(profile);
		int changed;

		_Getcloc();
		changed = _Getnloc(prof._Array, cat, locname);
		if (changed < 0)
			pcurname = 0;
		else if (0 < changed)
			{	/* change to new locale */
			char *name = _Getlname(prof._Array, _M_ALL,
				(const char **)_TLS_DATA_PTR(namalloc));
			size_t i;

			if (name == 0)
				pcurname = 0;
			else
				{	/* valid locale, set each category */
				struct _Locprofile *pprof = _TLS_DATA_PTR(profile);

				*pcurname = name;
				for (i = 0; i < _NCAT; ++i)
					if (pprof->_Array[i] != prof._Array[i])
						pprof->_Array[i] = _Setloc(i, prof._Array[i]);
				}
			}
	 	}
	return (pcurname != 0 ? *pcurname : 0);
		}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
