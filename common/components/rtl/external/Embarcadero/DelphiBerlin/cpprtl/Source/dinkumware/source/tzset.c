/* tzset function -- nonstandard addition (Posix) */
#include "xtime.h"
_STD_BEGIN

#define NAMESIZE	8	/* size of timezone name */

static char tz0[NAMESIZE] = "";
static char tz1[NAMESIZE] = "";

long timezone = 0;	/* seconds from GMT */
int daylight = 0;	/* nonzero if DST observed */
char *tzname[2] = {	/* names of standard and daylight timezones */
	tz0, tz1};

void (tzset)()
	{	/* convert local time structure to scalar time */
	time_t tod = time(0);	/* get current time */
	time_t t1 = mktime(gmtime(&tod));	/* convert without timezone */
	struct tm *st2 = localtime(&tod);	/* convert with timezone */
	time_t t2 = mktime(st2);

	timezone = (long)difftime(t1, t2);	/* compute difference in seconds */
	daylight = 0 <= st2->tm_isdst ? 1 : 0;

	st2->tm_isdst = 0;	/* generate standard timezone name */
	if (strftime(tz0, NAMESIZE, "%Z", st2) == 0)
		tz0[0] = '\0';
	st2->tm_isdst = 1;	/* generate daylight timezone name */
	if (strftime(tz1, NAMESIZE, "%Z", st2) == 0)
		tz1[0] = '\0';
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
