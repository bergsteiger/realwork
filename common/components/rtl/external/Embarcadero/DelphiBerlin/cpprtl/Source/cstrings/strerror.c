/*-----------------------------------------------------------------------*
 * filename - strerror.c
 *
 * function(s)
 *    strerror   - returns pointer to error message string
 *    _strerror  - builds a customized error message
 *    _maperror  - internal function
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1987, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 25070 $        */

#ifdef _MT
#include <_thread.h>
#endif
#include <_tchar.h>
#include <string.h>
#include <errno.h>
#include <stdlib.h>

#define MAXUSERLEN 94

/* Local buffer for constructed error messages:
 *
 * 94 bytes  Max User string
 *  2 bytes  semicolon and space
 * 64 bytes  Max sys_errlist string
 *  2 bytes  \n and NULL terminator
 */
#define STRBUFSIZE ((MAXUSERLEN + 2 + 64 + 1)*sizeof(_TCHAR))

#ifdef _MT

#ifdef _UNICODE
#define strbuf (_TCHAR *)THREAD_BUF(wstrbuf,STRBUFSIZE)
#else
#define strbuf (_TCHAR *)THREAD_BUF(strbuf,STRBUFSIZE)
#endif

#else

static _TCHAR strbuf[STRBUFSIZE];

#endif

/*---------------------------------------------------------------------*

Name            _tmaperror - builds a customized error message

Usage           char *_maperror(int errnum, const char *str);
Usage           wchar_t *_wmaperror(int errnum, const wchar_t *str);

Prototype in    local

Description     _tmaperror is a helper function for _tcserror and __tcserror
                that is used to construct an error message; it returns a
                pointer to a null-terminated string containing an error message.

                If str is NULL, the return value contains the system error
                message corresponding to the error code errnum; this string
                is null-terminated.

                If str is not NULL, the return value contains str (the
                customized error message), a colon, a space, the system error
                message corresponding to the error code errnum, and a newline.

                The length of str should be 94 characters or less.

Return value    _tmaperror returns a pointer to a constructed error
                string. The error message string is constructed in a static
                buffer that is overwritten with each call to _tmaperror.

*---------------------------------------------------------------------*/

static _TCHAR * _tmaperror(int errnum, const _TCHAR *s)
{
    char    *cp;   /* Ptr to the system error string: always narrow */
    _TCHAR  *buf;  /* Ptr to the static or TLS string */

    if (errnum < _sys_nerr && errnum >= 0)
        cp = _sys_errlist[errnum];
    else
        cp = "Unknown error";

    buf = strbuf;

    if (s && *s)
    {
        /* Copy the user's string (up to the max len) into the buffer */
        _tcsncpy(buf, s, MAXUSERLEN);

        /* Ensure that buf is null terminated in case the max length was
           exceeded.
         */
        buf[MAXUSERLEN] = _T('\0');

        /* Append a colon and space to seperate the user string
           from the error string.
         */
        _tcscat(buf, _T(": "));
    }
    else
    {
        /* No user string, so ensure that buf starts empty */
        buf[0] = _T('\0');
    }

#ifdef _UNICODE
    {
        /* When in _UNICODE, convert the error string from narrow to wide */
        wchar_t *wcp;
        int count = (strlen(cp) + 1);

        /* Alloc some space for the conversion */
        wcp = (_TCHAR*)malloc(count * sizeof(wchar_t));

        if(wcp && mbstowcs(wcp, cp, count) != (size_t)-1)
        {
            /* Copy the wide version of the error string into the buffer */
            wcscat(buf,wcp);
        }

        /* Free the conversion space */
        free(wcp);
    }
#else
    /* Copy the error string into the buffer */
    strcat(buf,cp);
#endif

    /* Append a newline to the buffer */
    _tcscat(buf,_T("\n"));

    /* Return the address of the static or TLS allocated string */
    return buf;
}


/*---------------------------------------------------------------------*

Name            __tcserror - builds a customized error message

Usage           char *_strerror(const char *str);
Usage           wchar_t *__wcserror(const wchar_t *str);

Prototype in    string.h

Description     __tcserror allows you to generate customized error
                messages; it returns a pointer to a null-terminated string
                containing an error message.

                If str is NULL, the return value contains the most recently
                generated system error message; this string is null-terminated.

                If str is not NULL, the return value contains str (your
                customized error message), a colon, a space, the most recently
                generated system error message, and a newline.

                The length of str should be 94 characters or less.

                __tcserror is different from perror in that it does not print
                error messages.

                For accurate error handling, __tcserror should be called as
                soon as a library routine generates an error return.

Return value    __tcserror returns a pointer to a constructed error
                string. The error message string is constructed in a static
                buffer that is overwritten with each call to __tcserror
                or _tcserror.

*---------------------------------------------------------------------*/

_TCHAR * _RTLENTRY _EXPFUNC __tcserror(const _TCHAR *s)
{
    return _tmaperror(errno, s);
}

/*---------------------------------------------------------------------*

Name            _tcserror - returns pointer to error message string

Usage           char *strerror(int errnum);
Usage           wchar_t *_wcserror(int errnum);

Prototype in    string.h

Description     _tcserror takes an int parameter errnum, and returns a
                pointer to an error message string associated with errnum.

Return value    _tcserror returns a pointer to a constructed error
                string. The error message string is constructed in a static
                buffer that is overwritten with each call to _tcserror
                or __tcserror.

*---------------------------------------------------------------------*/

_TCHAR * _RTLENTRY _EXPFUNC _tcserror(int errnum)
{
    return  _tmaperror(errnum, NULL);
}
