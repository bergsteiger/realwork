/* time function */
#include "xtime.h"

 #ifdef _WIN32_WCE
  #include "wrapwin.h"
_STD_BEGIN

time_t (time)(time_t *t)
	{	/* get system time */
	SYSTEMTIME systime;
	TIME_ZONE_INFORMATION tz;
	struct tm ctime;
	time_t tt;

	GetLocalTime(&systime);
	ctime.tm_isdst =
		GetTimeZoneInformation(&tz) == TIME_ZONE_ID_DAYLIGHT;
	ctime.tm_sec = systime.wSecond
		+ (systime.wMilliseconds + 500) / 1000;
	ctime.tm_min = systime.wMinute;
	ctime.tm_hour = systime.wHour;
	ctime.tm_mday = systime.wDay;
	ctime.tm_mon = systime.wMonth - 1;
	ctime.tm_year = systime.wYear - 1900;
	tt = mktime(&ctime);
	if (t != 0)
		*t = tt;
	return (tt);
	}
_STD_END

 #elif _DUMMY_C_LIB
_STD_BEGIN

time_t (time)(time_t *t)
	{
	return (-1);
	}
_STD_END

 #else /* _LIB version */
	/* revert to system library */
 #endif /* _LIB version */

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
