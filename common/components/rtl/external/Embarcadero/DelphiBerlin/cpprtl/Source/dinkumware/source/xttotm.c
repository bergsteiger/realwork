/* _Ttotm and _Daysto functions */
#include "xtime.h"
#include "xtls.h"
_STD_BEGIN

		/* macros */
#define MONTAB(year)	\
	((year) & 03 || (year) == 0 ? mos : lmos)

		/* static data */
static const short lmos[] = {0, 31, 60, 91, 121, 152,
	182, 213, 244, 274, 305, 335};
static const short mos[] = {0, 31, 59, 90, 120, 151,
	181, 212, 243, 273, 304, 334};

_TLS_DATA_DEF(static, struct tm, ts, {0});

int _Daysto(int year, int mon)
	{	/* compute extra days to start of month */
	int days;

	if (0 < year)	/* correct for leap year: 1801-2099 */
		days = (year - 1) / 4;
	else if (year <= -4)
		days = 1 + (4 - year) / 4;
	else
		days = 0;
	return (days + MONTAB(year)[mon]);
	}

struct tm *_Ttotm(struct tm *t, time_t secsarg, int isdst)
	{	/* convert scalar time to time structure */
	int year;
	long days;
	unsigned long secs;

	secsarg += _TBIAS;	/* changed to (wraparound) time since 1 Jan 1900 */
	if (t == 0)
		t = _TLS_DATA_PTR(ts);
	t->tm_isdst = isdst;
	for (secs = (unsigned long)secsarg; ;
		secs = (unsigned long)secsarg + 3600)
		{	/* loop to correct for DST */
		days = secs / 86400;
		t->tm_wday = (days + WDAY) % 7;
		 {	/* determine year */
		long i;

		for (year = days / 365;
			days < (i = _Daysto(year, 0) + 365L * year); )
			--year;	/* correct guess and recheck */
		days -= i;
		t->tm_year = year;
		t->tm_yday = days;
		 }
		 {	/* determine month */
		int mon;
		const short *pm = MONTAB(year);

		for (mon = 12; days < pm[--mon]; )
			;
		t->tm_mon = mon;
		t->tm_mday = days - pm[mon] + 1;
		 }
		secs = secs % 86400;
		t->tm_hour = secs / 3600;
		secs %= 3600;
		t->tm_min = secs / 60;
		t->tm_sec = secs % 60;
		if (0 <= t->tm_isdst || (t->tm_isdst = _Isdst(t)) <= 0)
			return (t);	/* loop only if <0 => 1 */
		}
		}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
