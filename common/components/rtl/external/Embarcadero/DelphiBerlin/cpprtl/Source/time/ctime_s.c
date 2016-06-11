/*------------------------------------------------------------------------
 * filename - ctime_s.c
 *
 * function(s)
 *    asctime   - converts date and time to ASCII
 *    ctime     - converts date and time to a string
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 2009, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision$        */

#include <ctype.h>
#include <time.h>
#include <stdio.h>
#include <stdlib.h>
#include <_tchar.h>
#include <_time.h>
#include <_secure.h>

static int tm_normalized(const struct tm *tmPtr)
{
    if ((unsigned)tmPtr->tm_sec > 61 ||
	(unsigned)tmPtr->tm_min > 59 ||
	(unsigned)tmPtr->tm_hour > 23 ||
	(unsigned)tmPtr->tm_mday > 31 ||
	(unsigned)tmPtr->tm_mon > 11 ||
	(unsigned)tmPtr->tm_year > 9999)
	return 0;

    return 1;
}

/*------------------------------------------------------------------------*

Name            _tasctime and _tctime, used as:
                  asctime - converts date and time to ASCII
                _wasctime - converts date and time to wide character
                  ctime   - converts date and time to a string
                _wctime   - converts date and time to a wide char string

Usage           #include <time.h>
                char    *   asctime(struct tm *tmX);
                wchar_t * _wasctime(struct tm *tmX);
                char    *   ctime(long *clock);
                wchar_t * _wctime(long *clock);

Prototype in    time.h

Description     asctime and _wasctime convert a time stored as a structure
                to a 26 (wide) character string in the following form:

                Mon Nov 21 11:31:54 1983\n\0

                All the fields have a constant width.

                ctime and _wctime convert a time pointed to by clock (such
                as returned by the function time) to a 26 (wide) character
                string of the form described above.

Return value    asctime, _wasctime, ctime and _wctime return a pointer to
                the (wide) character string containing the date and time.
                This string is a static which is overwritten with each call.

*---------------------------------------------------------------------------*/

errno_t _RTLENTRY _EXPFUNC _tasctime_s(_TCHAR *s, rsize_t maxsize, const struct tm *tmPtr)
{
    errno_t err = 0;

    /* Constraints */
    if (s == 0 || tmPtr == 0)
	err = EINVAL;
    else if (maxsize < 26 || maxsize > RSIZE_MAX)
	err = ERANGE;
    else if (!tm_normalized(tmPtr))
	err = ERANGE;
    if (err)
    {
	if (s && maxsize && maxsize <= RSIZE_MAX)
	  s[0] = 0;
	__invoke_constraint_handler_s(__func__, 0, err);
	return err;
    }

    /* Body */
    _tatime(s, tmPtr, _TEXT("\n"));  /* ASCII time + terminating newline */
    return 0;
}

errno_t _RTLENTRY _EXPFUNC _tctime_s(_TCHAR *s, rsize_t maxsize, const time_t *timer)
{
    struct tm *p;
    errno_t err = 0;

    /* Constraints */
    if (s == 0 || timer == 0)
	err = EINVAL;
    else if (maxsize < 26 || maxsize > RSIZE_MAX)
	err = ERANGE;
    if (err)
    {
	if (s && maxsize && maxsize <= RSIZE_MAX)
	    s[0] = 0;
	__invoke_constraint_handler_s(__func__, 0, err);
	return err;
    }

    /* Body */
    p = localtime(timer);
    if (p == 0)
	return EINVAL;

    _tatime(s, p, _TEXT("\n"));  /* ASCII time + terminating newline */
    return 0;
}
