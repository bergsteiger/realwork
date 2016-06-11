/*------------------------------------------------------------------------
 * filename - gets.c
 *
 * function(s)
 *        gets - gets a string from a stream
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 2009, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 23293 $        */

#include <stdio.h>
#include <_stdio.h>
#include <_tchar.h>
#include <_secure.h>

/*---------------------------------------------------------------------*

Name            _getts_s used as gets and _getws
                gets_s   - gets a string from a stream
                _getws_s - gets a wide string from a stream

Usage           char *gets_s(char *string, rsize_t n);
                wchar_t *_getws_s(wchar_t *string, rsize_t n);

Prototype in    stdio.h

Description     _getts_s reads a string into string from the
                standard input stream stdin. The string is terminated by a
                newline character, which is replaced in @i{string} by a null
                character (\0).

Return value    on success, returns the string argument string;
                else returns NULL on end-of-file or error.

*---------------------------------------------------------------------*/

_TCHAR * _RTLENTRY _EXPFUNC _getts_s(_TCHAR *s, rsize_t n)
{
    register _TINT   c;
    register _TCHAR *P;
    errno_t err = 0;

     /* Constraints */
    if (!s)
	err = EINVAL;
    else if (!n || n > RSIZE_MAX)
	err = ERANGE;

    if (!err)
    {
	/* Body */
	_lock_stream(stdin);

	s[0] = 0;
	P = s;

	while (--n && (c = _gettc (stdin)) != _TEOF && c != _TEXT('\n'))
	    *P++ = c;
	*P = 0;

	if (n == 0)
	{
	    /* newline doesn't count againt the number of characters */
	    c = _gettc (stdin);
	    if (c != _TEXT('\n'))
		err = ERANGE;
	}

	if (err || (_TEOF == c && P == s))
	    P = NULL;
	else
	    P = ferror (stdin) ? NULL : s;

	_unlock_stream(stdin);
    }

    if (err)
    {
	if (s)
	    s[0] = 0;
	_lock_stream(stdin);
	while ((c = _gettc (stdin)) != _TEOF && c != _TEXT('\n'))
	    ;
	_unlock_stream(stdin);
	__invoke_constraint_handler_s(__func__, 0, err);
	return 0;
    }

    return (P);
}
