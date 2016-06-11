/*-----------------------------------------------------------------------*
 * filename - _lseeki64.c
 *
 * function(s)
 *        _lseeki64 - moves read/write file pointer
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 2007, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 27483 $        */

#define INCL_ERROR_H

#include <ntbc.h>

#include <_io.h>
#include <io.h>
#include <fcntl.h>

/*-----------------------------------------------------------------------*

Name            _lseeki64 - moves read/write file pointer

Usage           #include <io.h>
                __int64 _lseeki64(int handle, __int64 offset, int fromwhere);

Related
functions usage __int64 _lseeki64(int handle);

Prototype in    io.h

Description     _lseeki64 sets the file pointer associated with handle
                to a new position that is offset bytes beyond the file
                location given by fromwhere. fromwhere must be one of the
                values 0, 1 or 2, which represent three symbolic constants
                (defined in stdio.h) as follows:

                fromwhere       File Location
                SEEK_SET (0)    file beginning
                SEEK_CUR (1)    current file pointer position
                SEEK_END (2)    end-of-file

Return value    _lseeki64 returns the offset of the pointer's new
                position, measured in bytes from the file beginning. __lseek
                returns -1L on error, and errno is set to one of the following:

                    EBADF   Bad file number
                    EINVAL  Invalid argument

                On devices incapable of seeking (such as terminals and
                printers), the return value is undefined.

                tell returns the current file pointer position. A return of -1
                (long) indicates an error, and errno is set to:

                    EBADF   Bad file number

*------------------------------------------------------------------------*/
__int64 _RTLENTRY _EXPFUNC _lseeki64(int fd, __int64 offset, int kind)
{
    LARGE_INTEGER loffset;
    DWORD  method;

    if ((unsigned)fd >= _nfile)
        return __IOerror(ERROR_INVALID_HANDLE);

    loffset.QuadPart = offset;

    /* Translate the POSIX seek type to the NT method.
     */
    switch (kind)
    {
    case SEEK_SET:
        method = FILE_BEGIN;
        break;
    case SEEK_CUR:
        method = FILE_CURRENT;
        break;
    case SEEK_END:
        method = FILE_END;
        break;
    default:
        return (__IOerror(ERROR_INVALID_FUNCTION));
    }

    _lock_handle(fd);

    _openfd[fd] &= ~_O_EOF;      /* forget about ^Z      */

    loffset.LowPart = SetFilePointer((HANDLE)_handles[fd], loffset.LowPart, &loffset.HighPart, method);
    if (loffset.LowPart == INVALID_SET_FILE_POINTER && GetLastError() != NO_ERROR)
    {
        __NTerror();        /* set errno */
	loffset.QuadPart = -1;
    }

    _unlock_handle(fd);

    return loffset.QuadPart;
}
