/*-----------------------------------------------------------------------*
 * filename - telli64.c
 *
 * function(s)
 *        _telli64 - gets current position of file pointer
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 2007, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 23348 $        */

#include <io.h>
#include <_io.h>

/*---------------------------------------------------------------------*

Name            _telli64 - gets current position of file pointer

Usage           __int64 _telli64(int handle);

Prototype in    io.h

Description     gets the current position of the file pointer associated
                with handle and expresses it as the number of bytes from
                the beginning of the file.

Return value    the current file pointer position.  A return of -1L
                indicates an error, and errno is set to:

                        EBADF   Bad file number

*---------------------------------------------------------------------*/

__int64 _RTLENTRY _EXPFUNC _telli64(int handle)
{
        return (_lseeki64 (handle, 0i64, SEEK_CUR));
}
