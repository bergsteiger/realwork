/*---------------------------------------------------------------------------
 * filename - getenv_s.c
 *
 * function(s)
 *        getenv_s - get string from environment
 *        _wgetenv_s - get wide-character string from environment
 *--------------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 2009, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision$        */

#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <_process.h>
#include <tchar.h>
#include <_tchar.h>
#include <_ostype.h>
#include <_secure.h>

/*--------------------------------------------------------------------------*

Name            getenv_s, _wgetenv_s - get string from environment

Usage           char *getenv_s(size_t * restrict len, char * restrict value,
                               rsize_t maxsize, const char * restrict name);
		char *_wgetenv_s(size_t * restrict len, wchar_t * restrict value,
		                 rsize_t maxsize, const wchar_t * restrict name);

Prototype in    stdlib.h

Description     The environment consists of a series of entries that
                are of the form:

                name=string\0

                The global variable environ points to an array of pointers
                to these entries.  The last pointer in the array is NULL.
                getenv_s searches the environment for the entry corresponding
                to name, then copies it's value into the value paramaterx.

                The string  comparison is NOT case-sensitive.

Return value    On  success, getenv_s and _wgetenv_s return zero.

*---------------------------------------------------------------------------*/

errno_t _RTLENTRY _EXPFUNC _tgetenv_s(size_t * _RESTRICT len, _TCHAR * _RESTRICT value,
				      rsize_t maxsize, const _TCHAR * _RESTRICT name)
{
    _TCHAR  *envP;
    size_t slen;
    errno_t retval = 0;

    /* Set on success/failure/constraints violation */
    if (len)
	*len = 0;

    /* Constraints

       Note: The latest version states that maxsize "shall neither
       equal zero nor be greater than RSIZE_MAX.  If maxisize is not
       equal to zero then value shall not be a null pointer".  This
       implies that value shall never be a null pointer, but then why
       the qualification?

       The Draft version mode more sense where it just listed the
       conditions explicitly in a list form.  The undefined condition
       there was "maxsize > 0 && value == NULL".

       Behavior: TBD
     */
    if (name == 0 || maxsize > RSIZE_MAX || (maxsize && !value))
    {
	__invoke_constraint_handler_s(__func__, 0, EINVAL);
	return EINVAL;
    }
    else
    {
	_tlock_env();  /* lock out other users of 'environ' */

	envP = _tgetenv_nolock(name);
	if (envP)
	{
	    /* Found in environ */
	    slen = _tcslen(envP);
	    if (len)
		*len = slen;
	    /* Store if buffer is large enough */
	    if (slen < maxsize)
		_tcscpy(value, envP);
	    else
		retval = ERANGE;
	}
	else /* Not found */
	{
	    /* maxsize already validated > 0 in new version wording */
	    if (maxsize)
		value[0] = 0;
	    retval = EINVAL;
	}

	_tunlock_env(); /* finished with environ */
    }
    return retval;
}
