/*------------------------------------------------------------------------
 * filename - timefunc.c
 *
 * function(s)
 *        _isDst    - determines whether daylight savings is in effect
 *        _totalsec - converts a date to seconds since 1970
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1987, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 28880 $        */

#if defined(__WIN32__)
#include <ntbc.h>
#endif
#include <time.h>
#include <_time.h>

#define Thursday        4
#define March           3
#define April           4
#define October         10
#define November        11

/* _PREFER_END_STANDARD_TIME determines which version of a time in the
   overlapping hour at end of DST is selected.  Prior versions selected the
   earlier one (DST) but the consensus seems to be to select the standard
   time version.
*/
unsigned char _RTLENTRY _EXPDATA _PREFER_END_STANDARD_TIME = 1;

/* _PREFER_START_DAYLIGHT_TIME determines what time is returned for time
   that don't exist in the transition to DST.  We were treating the time
   from 2:00-2:59 on a DST transition (which doesn't exist) as requests for
   an hour ealier.  This was compatible with Microsoft VC but differs from
   Linux and Mac. We now act like the wall clock and jump forward into DST.
 */
unsigned char _RTLENTRY _EXPDATA _PREFER_START_DAYLIGHT_TIME = 1;

/*--------------------------------------------------------------------------*

Name            _isDST  -  determines whether daylight savings is in effect

Usage           int  _isDST (unsigned hour,  unsigned yday,
                     unsigned month, unsigned year);

Prototype in    _io.h

Description     Returns non-zero if daylight savings is in effect for
                the given date.

                If month is 0, yday is the day of the year; otherwise yday is
                the day of the month, where month is 1 for Jan, 2 for Feb, etc.
                In either case, yday is zero based.  year is the number of
                years since 1970.

                It is assumed that the caller has called tzset() to fill in
                the timezone info.

Return value    Non-zero if DST is in effect for the given date.  Greater than
                1 if the time doesn't exist in DST.

*---------------------------------------------------------------------------*/
int _isDSTx (unsigned hour, unsigned yday, unsigned month, unsigned year)
{
    unsigned  temp, sunday;
    unsigned  startMonth, endMonth;

    if (month == 0)                 /* if only day of year given    */
    {
        temp = yday;
        if (yday >= 31+28 && ( ((year+70) & 3) == 0))
            temp--;
        for (month = 0; temp >= (unsigned)_YDays[month]; month++)
            ;
    }
    else                            /* if month+day of month given  */
    {
        yday += _YDays[month-1];
        if (month > 2 && ( ((year+70) & 3) == 0))   /* leap year, Mar-Dec */
            yday++;
    }

    /* Weed out months other than transition months.
     */
    startMonth = (year > 36) ? March : April;
    endMonth = (year > 36) ? November : October;

    if (month < startMonth || month > endMonth)
        return (0);
    if (month > startMonth && month < endMonth)
        return (1);

    /* Up through 1986, the starting day for DST is the last Sunday in
     * April; after that it is the first Sunday in April until 2007
     * when it changes to the second Sunday in March.
     *
     * The last day of DST is the last Sunday in October up until 2007
     * when it changes to the first Sunday in November.
     */
    if (year > 36)
    {
        if (month == startMonth)
            sunday = _YDays[month-1] + 14;  /* day = 14th day in month */
        else
            sunday = _YDays[month-1] + 7;   /* day = 7th day in month */
    }
    else if (year > 16 && month == April)   /* if April and year > 1986 */
        sunday = _YDays[month-1] + 7;       /* day = 7th day in month */
    else
        sunday = _YDays[month];             /* day = last day in month */
    if ((year + 70) & 3)                    /* leap year ? */
        sunday--;                           /* no --> adjust */

    /* Adjust the threshold day downward to the preceding Sunday.
     */
    temp = sunday + ((year + 1) >> 2)   /* add leap days since 1970 */
           + (year * 365)               /* add years since 1970 */
           + Thursday;                  /* 01-01-70 was Thursday */
    sunday -= temp % 7;                 /* back up to Sunday */

    /* Check if the day falls within the limit.
     */
    if (month == startMonth)
    {
        if (yday > sunday)
            return (1);
        if (yday < sunday)
            return (0);
        if (_PREFER_START_DAYLIGHT_TIME && hour == 2)
            return 2;
        return (hour >= 2);             /* DST started at 2:00 AM */
    }
    else
    {
        if (yday < sunday)
            return (1);
        if (yday > sunday)
            return (0);
        if (_PREFER_END_STANDARD_TIME)
            return (hour < 1);          /* DST ended at 2:00 AM but assume
                                           1:00-1:59 has already switched */
        else
            return (hour <= 1);         /* DST ended at 2:00 AM */
    }
}


/* Allow for custom behavior */
typedef int (*isDST_t)(unsigned hour, unsigned yday, unsigned month, unsigned year);
static isDST_t isDST_hook = 0;

void _RTLENTRY _EXPFUNC __isDST_hook(isDST_t dstfunc)
{
    isDST_hook = dstfunc;
}

int _isDST (unsigned hour, unsigned yday, unsigned month, unsigned year)
{
    if (isDST_hook)
        return isDST_hook(hour, yday, month, year);
    else
        return _isDSTx(hour, yday, month, year);
}


/*------------------------------------------------------------------------*
Name            _totalsec - convert a date to seconds since 1970

Usage           #include <_io.h>
                unsigned long _totalsec
                    (int year, int month, int day, int hour, int min, int sec,
                     int dst_flag);

Protype         _io.h

Description     Converts a broken-down date to the number of seconds elapsed
                since year 70 (1970) in calendar time.  All arguments are
                zero based, except for the year, which is the number of years
                since 1900.
                dst_flag is usually passed in from the tm_isdst member of a
                struct tm.  0 means never preform the DST adjustment, 1
                means always perform the DST adjustment, and -1 means DST is
                unknown (and this function will figure it out based on the
                isDST func and _daylight).

Return value    The time in seconds since 1/1/1970 GMT.

*---------------------------------------------------------------------------*/

unsigned long _totalsec
(int year, int month, int day, int hour, int min, int sec, int dst_flag)
{
    int leaps;
    time_t days, secs;

    if (year < 70 || year > 138)
        return ((time_t) -1);

    min += sec / 60;
    sec %= 60;              /* Seconds are normalized */
    hour += min / 60;
    min %= 60;              /* Minutes are normalized */
    day += hour / 24;
    hour %= 24;             /* Hours are normalized   */

    year += month / 12;     /* Normalize month (not necessarily final) */
    month %= 12;

    while (day >= _Days[month])
    {
        if (!(year & 3) && (month ==1))
        {
            if (day > 28)
            {
                day -= 29;
                month++;
            }
            else
                break;
        }
        else
        {
            day -= _Days[month];
            month++;
        }

        if (month >= 12)    /* Normalize month */
        {
            month -= 12;
            year++;
        }
    }

    year -= 70;
    leaps = (year + 2) / 4;

    if (!((year+70) & 3) && (month < 2))
        --leaps;

    days = year*365L + leaps + _YDays[month] + day;

    secs = days*86400L + hour*3600L + min*60L + sec + _timezone;

    if (dst_flag == -1)
    {
        int dst = _isDST(hour, day, month+1, year);
        if (_daylight && dst)
            if (dst == 1)
                secs -= 3600;
    }
    else
        secs -= (dst_flag ? 3600 : 0);

    return(secs > 0 ? secs : (time_t) -1);
}
