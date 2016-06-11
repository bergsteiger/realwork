/* _Isdst function */
#include <stdlib.h>
#include "xmtloc.h"
#include "xtls.h"
#include "xtime.h"
_STD_BEGIN

typedef const char *dst_t;
typedef Dstrule *rules_t;

static void free_tls(void *ptr)
	{	/* free any storage pointed at by thread-local rules */
	rules_t *prules = (rules_t *)ptr;

	free(*prules);
	}

_TLS_DATA_DEF(static, dst_t, olddst, 0);
_TLS_DATA_DEF_DT(static, rules_t, rules, 0, free_tls);

int _Isdst(const struct tm *t)
	{	/* test whether Daylight Savings Time in effect */
	Dstrule *pr;
	dst_t *polddst = _TLS_DATA_PTR(olddst);
	rules_t *prules = _TLS_DATA_PTR(rules);
	_Tinfo *ptimes = _TLS_DATA_PTR(_Times);

	if (*polddst != ptimes->_Isdst)
		{	/* find current dst_rules */
		if (ptimes->_Isdst[0] == '\0')
			{	/* look beyond time_zone info */
			int n;

			if (ptimes->_Tzone[0] == '\0')
				ptimes->_Tzone = _Getzone();
			ptimes->_Isdst = _Gettime(ptimes->_Tzone, 3, &n);
			if (ptimes->_Isdst[0] != '\0')
				--ptimes->_Isdst;	/* point to delimiter */
			}
		if ((pr = _Getdst(ptimes->_Isdst)) == 0)
			return (-1);

		free(*prules);
		*prules = pr;
		*polddst = ptimes->_Isdst;
		}

	 {	/* check time against rules */
	int ans = 0;
	const int d0 = _Daysto(t->tm_year, 0);
	const int hour = t->tm_hour + 24 * t->tm_yday;
	const int wd0 = (365L * t->tm_year + d0 + WDAY) % 7 + 14;

	for (pr = *prules; pr->wday != (unsigned char)-1; ++pr)
		if (pr->year <= t->tm_year)
			{	/* found early enough year */
			int rday = _Daysto(t->tm_year, pr->mon) - d0
				 + pr->day;

			if (0 < pr->wday)
				{	/* shift to specific weekday */
				int wd = (rday + wd0 - pr->wday) % 7;

				rday += wd == 0 ? 0 : 7 - wd;
				if (pr->wday <= 7)
					rday -= 7;	/* strictly before */
				}
			if (hour < rday * 24 + pr->hour)
				return (ans);
			ans = pr->year == (pr + 1)->year ? !ans : 0;
			}
	return (ans);
	 }
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
