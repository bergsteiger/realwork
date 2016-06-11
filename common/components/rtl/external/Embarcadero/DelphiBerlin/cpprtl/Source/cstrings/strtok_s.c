/*-----------------------------------------------------------------------*
 * filename - strtok_s.c
 *
 * function(s)
 *        strtok_s, wcstok_s - searches one string for tokens, which are
 *                   separated by delimiters defined in a second string
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 2009, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision$        */

#include <string.h>
#include <tchar.h>
#include <_secure.h>

_TCHAR * _RTLENTRYF _EXPFUNC _tcstok_s(_TCHAR * _RESTRICT s1,
				       rsize_t * _RESTRICT s1max,
				       const _TCHAR * _RESTRICT s2,
				       _TCHAR ** _RESTRICT ptr)
{
    register const _TCHAR *sp;
    register _TCHAR sc1, spc;
    _TCHAR *tok;
    errno_t err = 0;

    /* Constraints */
    if (s2 == 0 || ptr == 0)
	err = EINVAL;
    else if (s1 == 0 && *ptr == 0)
	err = EINVAL;
    else if (*s1max > RSIZE_MAX)
	err = ERANGE;
    if (err)
    {
	__invoke_constraint_handler_s(__func__, 0, err);
	return 0;
    }

    /* Body */
    if (s1 == NULL)
        s1 = *ptr;

    /* First skip separators
     */
    while ((sc1 = *s1) != 0)
    {
        for (sp = s2; (spc = *sp) != 0; sp++)
            if (spc == sc1)
                break;
        if (spc == 0)
            break;
        s1++;
	(*s1max)--;
	if (*s1max == 0)
	{
	    __invoke_constraint_handler_s(__func__, 0, ERANGE);
	    return 0;
	}
    }
    if (sc1 == 0)
    {
        *ptr = s1;
        return 0;
    }
    tok = s1;
    while ((sc1 = *s1) != 0)
    {
        for (sp = s2; (spc = *sp) != 0; sp++)
            if (spc == sc1)
                goto Found;
        s1++;
	(*s1max)--;
	if (*s1max == 0)
	    __invoke_constraint_handler_s(__func__, 0, ERANGE);
    }
    *ptr = s1;
    return (tok);
Found:
    *s1++ = 0;
    (*s1max)--;
    *ptr = s1;
    return tok;
}
