/*---------------------------------------------------------------------------
 * filename - fstati64.c
 *
 * function(s)
 *        _fstati64      - gets open file information
 *--------------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 2008, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 23293 $        */

#define INCL_ERROR_H

#include <ntbc.h>

#include <sys/types.h>
#include <sys/stat.h>
#include <io.h>
#include <_io.h>
#include <string.h>
#include <fcntl.h>

/* The following helper function is in statcvt.c.
 */
extern void _statcvt_i64 (
    struct stati64 *bufP,   /* stati64 structure to be filled in */
    DWORD attr,             /* NT file attributes */
    FILETIME *ctime,        /* NT time of file creation */
    FILETIME *atime,        /* NT time of last access */
    FILETIME *wtime,        /* NT time of last write */
    DWORD    fsize_high,    /* NT high word file size */
    DWORD    fsize_low);    /* NT low word file size */

/*--------------------------------------------------------------------------*

Name            _fstati64 - gets open file information

Usage           #include <sys/stat.h>
                int _fstati64(int handle, struct stati64 *buff)

Prototype in    sys/stat.h

Description     Gather statistics about the nominated file and place
                them in the buffer *bufP.

                Not all of the fields are relevant to NT.
                The fields are set thus:

                    st_dev      set to fildes if device, else set to
                                drive holding the file.
                    st_ino      0
                    st_mode     Unix-style flag bits for file access rights
                    st_nlink    1
                    st_uid      0
                    st_gid      0
                    st_rdev     same as st_dev
                    st_size     file size (0 if device).
                    st_atime    time file last changed (seconds since 1970)
                    st_mtime    same as st_atime
                    st_ctime    same as st_atime

                The file access rights flags may contain S_IFCHR or S_IFREG.
                S_IREAD is always set and S_IWRITE is set only for devices,
                since there is no method in PCDOS of inspecting the file
                attributes without knowing the file name.  Programs which
                need this information should use stat().

                The file time fields are not available on MSDOS versions
                prior to 2.0, or if the file is a character stream (S_IFCHR),
                and will be set to zero in such cases.

Return value    The return value is 0 if the call was successful, otherwise
                -1 is returned and errno contains the reason.

*---------------------------------------------------------------------------*/

int _RTLENTRY _EXPFUNC _fstati64 (int fd, struct stati64 *bufP)
{
    int         rc;
    HANDLE      h;
    BY_HANDLE_FILE_INFORMATION fi;

    if ((unsigned)fd >= _nfile)
        return __IOerror(ERROR_INVALID_HANDLE);

    _lock_handle(fd);
    h = (HANDLE)_handles[fd];

    memset(bufP, 0, sizeof(struct stati64));   /* Zero the structure   */

    /* Convert NT file type to POSIX file type.
     */
    switch (GetFileType(h))
    {
    case FILE_TYPE_CHAR:
        bufP->st_mode = S_IFCHR;
        break;

    case FILE_TYPE_DISK:
        /* Get the NT file times.
         */
        if (!GetFileInformationByHandle(h, &fi))
            RETURN (__NTerror());

        /* Convert the file attributes, times, and size to a struct stati64.
         */
        _statcvt_i64(bufP, 
                     fi.dwFileAttributes, 
                     &fi.ftCreationTime, &fi.ftLastAccessTime, &fi.ftLastWriteTime, 
                     fi.nFileSizeHigh, fi.nFileSizeLow);
        break;

    case FILE_TYPE_PIPE:
        bufP->st_mode = S_IFIFO;
        break;
    }

    rc = 0;

exit:
    _unlock_handle(fd);
    return (rc);
}
