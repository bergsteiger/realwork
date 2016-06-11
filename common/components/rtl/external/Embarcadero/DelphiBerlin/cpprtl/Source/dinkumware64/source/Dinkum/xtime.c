/* xtime.c -- xtime functions */
#include <Dinkum/threads/xtimec.h>
#include <time.h>
#include <stdlib.h>

#define NSEC_PER_SEC 1000000000L
#define NSEC_PER_MSEC 1000000L
#define NSEC_PER_USEC 1000L
#define MSEC_PER_SEC 1000

static void xtime_normalize(xtime *xt)
	{	/* adjust so that 0 <= nsec < 1 000 000 000 */
	while (xt->nsec < 0)
		{	/* normalize target time */
		xt->sec -= 1;
		xt->nsec += NSEC_PER_SEC;
		}
	while (NSEC_PER_SEC <= xt->nsec)
		{	/* normalize target time */
		xt->sec += 1;
		xt->nsec -= NSEC_PER_SEC;
		}
	}

static xtime xtime_diff(const xtime *xt, const xtime *now)
	{	/* return xtime object holding difference between xt and now,
			treating negative difference as 0 */
	xtime diff = *xt;
	xtime_normalize(&diff);
	if (diff.nsec < now->nsec)
		{	// avoid underflow
		diff.sec -= now->sec + 1;
		diff.nsec += NSEC_PER_SEC - now->nsec;
		}
	else
		{	// no underflow
		diff.sec -= now->sec;
		diff.nsec -= now->nsec;
		}
	if (diff.sec < 0 || (diff.sec == 0 && diff.nsec <= 0))
		{	/* time is zero */
		diff.sec = 0;
		diff.nsec = 0;
		}
	return (diff);
	}

 #if _WIN32_C_LIB
#include <wrapwin.h>

 #if 0 < _MSC_VER
  #define EPOCH	0x19DB1DED53E8000i64
 #else /* 0 < _MSC_VER */
  #define EPOCH	0x19DB1DED53E8000LL

typedef time_t __time64_t;
 #endif /* 0 < _MSC_VER */

  #define NSEC100_PER_SEC	(NSEC_PER_SEC / 100)
  #define NSEC100_PER_MSEC	(NSEC_PER_MSEC / 100)

 #ifdef _WIN32_WCE
_LONGLONG _Xtime_get_ticks()
	{	/* get system time in 100-nanosecond intervals since the epoch */
		/* CAUTION: assumes that mktime returns time in seconds */
	SYSTEMTIME systime;
	TIME_ZONE_INFORMATION tz;
	struct tm ctime;
	time_t tt;

	GetLocalTime(&systime);
	ctime.tm_isdst =
		GetTimeZoneInformation(&tz) == TIME_ZONE_ID_DAYLIGHT;
	ctime.tm_sec = systime.wSecond;
	ctime.tm_min = systime.wMinute;
	ctime.tm_hour = systime.wHour;
	ctime.tm_mday = systime.wDay;
	ctime.tm_mon = systime.wMonth - 1;
	ctime.tm_year = systime.wYear - 1900;
	tt = mktime(&ctime);
	return (NSEC100_PER_SEC * (_LONGLONG)tt
		+ NSEC100_PER_MSEC * (_LONGLONG)systime.wMilliseconds);
	}

 #else /* _WIN32_WCE */
_LONGLONG _Xtime_get_ticks()
	{	/* get system time in 100-nanosecond intervals since the epoch */
	FILETIME ft;
	GetSystemTimeAsFileTime(&ft);
	return ((((_LONGLONG)ft.dwHighDateTime) << 32)
		+ (_LONGLONG)ft.dwLowDateTime - EPOCH);
	}
 #endif /* _WIN32_WCE */

static void sys_get_time(xtime *xt)
	{	/* get system time with nanosecond resolution */
	_ULONGLONG now = _Xtime_get_ticks();
	xt->sec = (__time64_t)(now / NSEC100_PER_SEC);
	xt->nsec = (long)(now % NSEC100_PER_SEC) * 100;
	}

long _Xtime_diff_to_millis2(const xtime *xt1, const xtime *xt2)
	{	/* convert time to milliseconds */
	xtime diff = xtime_diff(xt1, xt2);
	return ((long)(diff.sec * MSEC_PER_SEC
		+ (diff.nsec + NSEC_PER_MSEC - 1) / NSEC_PER_MSEC));
	}

long _Xtime_diff_to_millis(const xtime *xt)
	{	/* convert time to milliseconds */
	xtime now;
	xtime_get(&now, TIME_UTC);
	return (_Xtime_diff_to_millis2(xt, &now));
	}

 #elif _HAS_POSIX_C_LIB
#include <sys/time.h>

_LONGLONG _Xtime_get_ticks()
	{	/* get system time in 100-nanosecond intervals since the epoch */
	struct timeval tv;
	gettimeofday(&tv, 0);
	return ((_LONGLONG)1000000 * tv.tv_sec
		+ tv.tv_usec);	/* microseconds */
	}

static void sys_get_time(xtime *xt)
	{	/* get system time with nanosecond resolution */
	struct timeval tv;
	gettimeofday(&tv, 0);
	xt->sec = tv.tv_sec;
	xt->nsec = tv.tv_usec * NSEC_PER_USEC;
	}

struct timespec _Xtime_diff_to_ts(const xtime *xt)
	{	/* convert to timespec holding difference between xt and now */
	xtime now;
	xtime diff;
	struct timespec ts;
	xtime_get(&now, TIME_UTC);
	diff = xtime_diff(xt, &now);
	ts.tv_sec = (time_t)diff.sec;
	ts.tv_nsec = diff.nsec;
	return (ts);
	}

struct timespec _Xtime_to_ts(const xtime *xt)
	{	/* convert xtime to timespec */
	struct timespec ts;
	xtime tgt = *xt;
	xtime_normalize(&tgt);
	ts.tv_sec = (time_t)xt->sec;
	ts.tv_nsec = xt->nsec;
	return (ts);
	}

 #else /* library type */
  #error Unknown platform
 #endif	/* library type */

int xtime_get(xtime *xt, int type)
	{	/* get current time */
	if (type != TIME_UTC || xt == 0)
		type = 0;
	else
		sys_get_time(xt);
	return (type);
	}


/*
 * This file is derived from software bearing the following
 * restrictions:
 *
 * (c) Copyright William E. Kempf 2001
 *
 * Permission to use, copy, modify, distribute and sell this
 * software and its documentation for any purpose is hereby
 * granted without fee, provided that the above copyright
 * notice appear in all copies and that both that copyright
 * notice and this permission notice appear in supporting
 * documentation. William E. Kempf makes no representations
 * about the suitability of this software for any purpose.
 * It is provided "as is" without express or implied warranty.
 */

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
