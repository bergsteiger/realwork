/*-----------------------------------------------------------------------*
 * filename - _fdopen.c
 *
 * function(s)
 *        _fdopen        - associates a stream with a file handle
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1987, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 24947 $        */

#include <stdio.h>
#include <_stdio.h>
#include <_io.h>
#include <_tchar.h>

/*---------------------------------------------------------------------*

Name            _tfdopen used as _fdopen and _wfdopen
                _fdopen  -  associates a stream with a file handle
                _wfdopen -  associates a stream with a file handle

Usage           FILE *_fdopen(int handle, const char *type);
                FILE *_wfdopen(int handle, const wchar_t *type);

Prototype in    _stdio.h (fdopen declared in stdio.h)

Description     This is the internal entry point for fdopen.
                See fopen for details.

*---------------------------------------------------------------------*/

#ifdef _UNICODE
FILE * _RTLENTRY _EXPFUNC _wfdopen (int handle, const wchar_t *type)
#else
FILE * _RTLENTRY _EXPFUNC _fdopen (int handle, const char *type)
#endif
{
    register FILE   *fp;

    _lock_all_streams();

    if (handle < 0 || handle >= _nfile || _openfd[handle] == 0 )
        fp = NULL;
    else if ((fp = __getfp()) != NULL)
    {
        fp->fd = handle;
        fp = __topenfp (fp, NULL, type, 0);
    }

    _unlock_all_streams();
    return (fp);
}
