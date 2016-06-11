/*------------------------------------------------------------------------
 * filename - gmtime.c
 *
 * function(s)
 *    comtime   - converts long timedate to a structure
 *    gmtime    - converts date and time to Greenwich Mean Time
 *    localtime - converts date and time to a structure
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1987, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 25082 $        */

#ifdef _MT
#include <_thread.h>
#endif
#include <time.h>
#include <_time.h>
#include <stdlib.h>

/*---------------------------------------------------------------------*

Name            comtime

Usage           static struct tm *comtime(unsigned long time, int dst);

Prototype in    local to this module

Description     fills the time structure tm by translating the long
                time.

Return value    the broken down time structure. This structure is
                a static which is overwritten with each call.

*---------------------------------------------------------------------*/
struct  tm * __comtime_helper(struct tm *tmPtr, time_t ltime, int dst)
{
    unsigned long time;
    unsigned hpery;
    unsigned i;
    unsigned cumdays;
    struct tm tmX;

    /* Perform all calculations using local tm structure (tmX), then
     * copy it to the thread's private tm structure before returing.
     */
    time = (unsigned long)ltime;
    tmX.tm_sec = (int)(time % 60);
    time /= 60;                             /* Time in minutes */
    tmX.tm_min = (int)(time % 60);
    time /= 60;                             /* Time in hours */
    i = (unsigned)(time / (1461L * 24L));   /* Number of 4 year blocks */
    tmX.tm_year = (i << 2);
    tmX.tm_year+= 70;
    cumdays = 1461 * i;
    time %= 1461L * 24L;        /* Hours since end of last 4 year block */

    for (;;)
    {
        hpery = 365 * 24;
        if ((tmX.tm_year & 3) == 0)
            hpery += 24;
        if (time < hpery)
            break;
        cumdays += hpery / 24;
        tmX.tm_year++;
        time -= hpery;
    }   /* at end, time is number of hours into current year */

    if  (dst && _daylight &&
             _isDST( (int)(time % 24), (int)(time / 24), 0, tmX.tm_year-70))
    {
        time++;
        tmX.tm_isdst = 1;
    }
    else
        tmX.tm_isdst = 0;

    tmX.tm_hour = (int)(time % 24);
    time /= 24;             /* Time in days */
    tmX.tm_yday = (int)time;
    cumdays += (int)time + 4;
    tmX.tm_wday = cumdays % 7;
    time++;

    if ((tmX.tm_year & 3) == 0)
    {
        if (time > 60)
            time--;
        else
            if (time == 60)
            {
                tmX.tm_mon = 1;
                tmX.tm_mday = 29;
		*tmPtr = tmX;
		return tmPtr;
            }
    }

    for (tmX.tm_mon = 0; _Days[tmX.tm_mon] < time; tmX.tm_mon++)
        time -= _Days[tmX.tm_mon];

    tmX.tm_mday = (int)(time);
    *tmPtr = tmX;
    return tmPtr;
}

static  struct  tm *comtime(time_t ltime, int dst)
{
#ifdef _MT
    THREAD_TIME *tt;

    /* Allocate a tm structure for this thread, if necessary.
     */
    if ((tt = (THREAD_TIME*)THREAD_BUF(time, sizeof(THREAD_TIME))) == NULL)
        return (NULL);
    return __comtime_helper(&tt->thread_tm, ltime, dst);
#else
    static struct tm tmX;
    return __comtime_helper(&tmX, ltime, dst);
#endif
}


/*------------------------------------------------------------------------*

Name            gmtime    - converts date and time to Greenwich Mean Time
                localtime - converts date and time to a structure

Usage           #include <time.h>
                struct tm *gmtime(long *clock);
                struct tm *localtime(long *clock);

Prototype in    time.h

Description     localtime   and  gmtime   return  pointers   to  structures
                containing the broken-down time. localtime corrects for the
                time  zone  and  possible  daylight  savings  time;  gmtime
                converts directly to GMT.

Return value    gmtime and localtime return the broken down time structure.
                This structure is  a static which is overwritten  with each
                call.

*---------------------------------------------------------------------------*/

struct tm * _RTLENTRY _EXPFUNC gmtime(const time_t *clock)
{
    return(comtime(*clock, 0));
}

struct tm * _RTLENTRY _EXPFUNC localtime(const time_t *clock)
{
    if (*clock < _timezone)
        return NULL;
    else
        return(comtime(*clock - _timezone, 1));
}
