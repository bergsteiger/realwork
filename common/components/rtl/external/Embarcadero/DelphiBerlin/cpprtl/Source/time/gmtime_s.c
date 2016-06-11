/*------------------------------------------------------------------------
 * filename - gmtime_s.c
 *
 * function(s)
 *    gmtime_s    - converts date and time to Greenwich Mean Time
 *    localtime_s - converts date and time to a structure
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 2009, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision$        */

#include <time.h>
#include <_time.h>
#include <_secure.h>
#include <stdlib.h>

/*------------------------------------------------------------------------*

Name            gmtime_s    - converts date and time to Greenwich Mean Time
                localtime_s - converts date and time to a structure

Usage           #include <time.h>
                struct tm *gmtime_s(long *clock, struct tm * result);
                struct tm *localtime_s(long *clock, struct tm * result);

Prototype in    time.h

Description     localtime_s and gmtime_s  return  pointers   to  structures
                containing the broken-down time. localtime corrects for the
                time  zone  and  possible  daylight  savings  time;  gmtime
                converts directly to GMT.

Return value    gmtime and localtime return the broken down time structure.

*---------------------------------------------------------------------------*/

struct tm * _RTLENTRY _EXPFUNC gmtime_s(const time_t * _RESTRICT clock,
					struct tm * _RESTRICT result)
{
    /* Constraints */
    if (clock == 0 || result == 0)
    {
	__invoke_constraint_handler_s(__func__, 0, EINVAL);
	return 0;
    }

    /* Body */
    return(__comtime_helper(result, *clock, 0));
}

struct tm * _RTLENTRY _EXPFUNC localtime_s(const time_t * _RESTRICT clock,
					   struct tm * _RESTRICT result)
{
    /* Constraints */
    if (clock == 0 || result == 0)
    {
	__invoke_constraint_handler_s(__func__, 0, EINVAL);
	return 0;
    }

    /* Body */
    if (*clock < _timezone)
        return NULL;
    else
        return(__comtime_helper(result, *clock - _timezone, 1));
}
