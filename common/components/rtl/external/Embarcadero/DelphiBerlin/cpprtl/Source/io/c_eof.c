/*---------------------------------------------------------------------------
 * filename - c_eof.c
 *
 * function(s)
 *        eof - detects end-of-file
 *--------------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 2015, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 23293 $        */

#include <errno.h>
#include <fcntl.h>
#include <io.h>
#include <_io.h>

/*--------------------------------------------------------------------------*

Name            eof - detects end-of-file

Usage           int eof(int handle);

Prototype in    io.h

Description     determines whether the file associated with handle has
                reached end-of-file

Return value    1 on end of file; otherwise 0.  A return value of -1
                indicates an error; and errno is set to:

                        EBADF  Bad file number

*---------------------------------------------------------------------------*/

int _RTLENTRY _EXPFUNC eof(int fd)
{
    return __eof(fd);
}
