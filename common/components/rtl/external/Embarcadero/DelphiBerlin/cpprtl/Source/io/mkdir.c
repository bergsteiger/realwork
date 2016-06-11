/*-----------------------------------------------------------------------*
 * filename - mkdir.c
 *
 * function(s)
 *        _mkdir - creates a directory
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1991, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 23293 $        */

#define INCL_ERROR_H
#include <ntbc.h>

#include <dir.h>
#include <_io.h>
#include <errno.h>
#include <_tchar.h>

/*-----------------------------------------------------------------------*

Name            _tmkdir used as _mkdir and _wmkdir
                _mkdir   - creates a directory
                _wmkdir - creates a directory

Usage           int _mkdir(const char *pathname);
                int _wmkdir(const wchar_t *pathname);

Prototype in    dir.h

Description     _tmkdir takes the given pathname and creates a new
                directory with that name (which must not already exist).

Return value    _tmkdir returns the value 0 if the new directory was
                created.

                With either function, a return value of -1 indicates an error,
                and errno is set to one of the following values:

                        EACCES  Permission denied
                        EEXIST  Directory already exists
                        ENOENT  Path or file name not found

*------------------------------------------------------------------------*/

int _RTLENTRY _EXPFUNC _tmkdir(const _TCHAR *pathP)
{
    if (CreateDirectory(pathP,NULL) != TRUE)
        return (__NTerror());
    else
        return (0);
}
