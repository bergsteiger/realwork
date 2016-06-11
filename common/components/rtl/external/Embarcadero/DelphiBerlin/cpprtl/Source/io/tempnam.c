/*-----------------------------------------------------------------------*
 * filename - tempnam.c
 *
 * function(s)
 *        _tempnam   - builds a unique file name in any directory
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1991, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 23293 $        */

#include <io.h>
#include <_io.h>
#include <errno.h>
#include <stdio.h>
#include <_stdio.h>
#include <string.h>
#include <stdlib.h>
#include <_tchar.h>

/*---------------------------------------------------------------------*

Name            _ttempnam used as _tempnam and _wtempnam
                _tempnam   - builds a unique file name
                _wtempnam - builds a unique wide file name

Usage           char *_tempnam(const char *dir, const char *prefix);
                wchar_t *_wtempnam(const wchar_t *dir, const wchar_t *prefix);

Prototype in    stdio.h

Description     The _ttempnam function creates a unique filename
                in arbitrary directories.  It attempts to use the following
                directories, in order, when creating the file:

                1. The directory specified by the TMP environment variable.
                2. The dir argument.
                3. The P_tmpdir definition in stdio.h.
                4. The current working directory.

                The prefix parameter specifies the first part
                of the filename; it cannot be longer than 5 characters.
                A unique filename is created by concatenating the directory,
                the prefix, and 6 unique characters.  Space for the
                resulting filename is allocated with malloc; the caller
                must free this filename by calling free().  The unique
                file is not actually created; _tempnam only verifies that
                it does not current exist.

Return value    a pointer to the unique temporary file name, which the
                caller may pass to free() when no longer needed; or NULL if a
                no unique filename can be created.

*---------------------------------------------------------------------*/

_TCHAR * _RTLENTRY _EXPFUNC _ttempnam(const _TCHAR *dir, const _TCHAR *prefix)
{
    const _TCHAR *empty = _TEXT("");
    const _TCHAR *dirs[4];
    int tries;

    /* Set up the four directories we'll try searching.
     */
    dirs[0] = _tgetenv(_TEXT("TMP"));   /* TMP enviroment variable */
    dirs[1] = dir;                      /* dir parameter */
    dirs[2] = _TEXT(P_tmpdir);          /* stdio.h temp dir */
    dirs[3] = _TEXT("");                /* current directory */

    /* test for the existance of prefix */
    if (!prefix)
        prefix = empty;

    /* test length of prefix */
    if(_tcslen(prefix) > 5)
        return(NULL);

    /* Search the four directories.
     */
    for (tries = 0; tries < 4; tries++)
    {
        const _TCHAR *dir;
        _TCHAR *p, *buf;
        unsigned num, len;

        /* Allocate a buffer big enough for the complete filename.
        /* Put the directory name in the buffer, then repeatedly use
         * __tmkname to append a weird name until we get one that
         * gives a filename that doesn't exist.
         */
        if ((dir = dirs[tries]) == NULL)
            continue;           /* skip NULL directory */
        len = (_tcslen(dir) + _tcslen(prefix) + 8) * sizeof(_TCHAR);
        if ((buf = malloc(len)) == NULL)
            continue;           /* can't allocate space for dir\preXXXXXX */
        p = _tcspcpy(buf,dir);
#if defined(_MBCS) && !defined(_UNICODE)
        if (p != buf && ((*(p-1) != _TEXT('/')  &&
                          *(p-1) != _TEXT('\\') &&
                          *(p-1) != _TEXT(':')) ||
                          _mbsbtype((const unsigned char *)buf, (p-1)-buf) == _MBC_TRAIL))
#else
        if (p != buf && *(p-1) != _TEXT('/')  &&
                        *(p-1) != _TEXT('\\') &&
                        *(p-1) != _TEXT(':'))
#endif
            *p++ = _TEXT('\\');        /* add trailing slash */

        for (num = 0; num != TMP_MAX; num++)
        {
            _ultot((unsigned long)num, _tcspcpy(p, prefix), 10);
            if (_tcslen(p) > 8)
            {
              memmove(p + 9 * sizeof(_TCHAR), p + 8 * sizeof(_TCHAR), (_tcslen(p) + 1 - 8) * sizeof(_TCHAR));
              p[8] = _TEXT('.');
            }

            if (_taccess(buf,0) == -1)  /* can't access this filename? */
            {
                if (errno == ENOENT)    /* file does not exist? */
                {
                    errno = 0;
                    return (buf);       /* return unique name */
                }
                else                    /* some other error */
                    break;              /* give up on this directory */
            }
        }
        free(buf);                      /* try next directory */
    }
    return (NULL);              /* all four directories failed */
}
