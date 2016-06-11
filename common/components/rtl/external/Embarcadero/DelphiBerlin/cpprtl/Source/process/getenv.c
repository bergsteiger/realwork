/*---------------------------------------------------------------------------
 * filename - getenv.c
 *
 * function(s)
 *        getenv - get string from environment
 *        _wgetenv - get wide-character string from environment
 *--------------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1987, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 25063 $        */

#include <stdlib.h>
#include <string.h>
#include <_process.h>
#include <tchar.h>
#include <_tchar.h>
#include <_ostype.h>

/*--------------------------------------------------------------------------*

Name            getenv, _wgetenv - get string from environment

Usage           char *getenv(const char *envvar);
		whar_t *_wgetenv(const wchar_t *envvar);

Prototype in    stdlib.h

Description     The environment consists of a series of entries that
                are of the form:

                name=string\0

                The global variable environ points to an array of pointers
                to these entries.  The last pointer in the array is NULL.
                getenv searches the environment for the entry corresponding
                to envvar, then returns a pointer to string.

                The string  comparison is NOT case-sensitive.

Return value    On  success, getenv and _wgetenv return a pointer to the value
                associated with envvar.

*---------------------------------------------------------------------------*/

_TCHAR * _RTLENTRY _EXPFUNC _tgetenv_nolock(const _TCHAR *nameP)
{
#if defined(_UNICODE)
    if (_ostype & _WINNT)
    {
#endif
    _TCHAR  **envP;
    int   len;

    len = _tcslen(nameP);            /* save length of name */
    if (len == 0)
        return NULL;

    for (envP = _tenviron; *envP != NULL; envP++)
        if (_tcsnicmp(*envP,nameP,len) == 0 && (*envP)[len] == _TEXT('='))
            break;

    if (*envP)
        return ((*envP)+len+1);     /* point past the '=' */
    else
        return (NULL);
#if defined(_UNICODE)
    }
    else
        return NULL;
#endif
}

_TCHAR * _RTLENTRY _EXPFUNC _tgetenv(const _TCHAR *nameP)
{
    _TCHAR  *envP;

    _tlock_env();                    /* lock out other users of 'environ' */

    envP = _tgetenv_nolock(nameP);

    _tunlock_env();

    return envP;
}
