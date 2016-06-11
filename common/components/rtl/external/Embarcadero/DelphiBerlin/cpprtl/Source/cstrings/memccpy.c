/*-----------------------------------------------------------------------*
 * filename - memccpy.c
 *
 * function(s)
 *        memccpy - copy bytes from src to dst
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1987, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 24901 $        */

#include <mem.h>

/*-----------------------------------------------------------------------*

Name            memccpy - copy bytes from src to dst

Usage           void *memccpy(void *dst, const void *src,
                              int val, size_t n);

Prototype in    string.h & mem.h

Description     memccpy copies characters  from src to dst, until  either n
                characters are  moved or the  character val is  matched and
                copied,  without checks  and as  fast as  possible. If  the
                source  and  target  arrays  overlap,  the  effect  is  not
                defined.

Return value    If val  was matched then the  return value is a  pointer to
                the character  position following val in  dst, otherwise it
                is NULL.

*------------------------------------------------------------------------*/

void * _RTLENTRY _EXPFUNC memccpy(void *dst, const void *src, int val, size_t n)
{
    char *ps = (char *)src;
    char *pd = (char *)dst;
    if (!n)
       return 0;
    while ( n-- )
    {
        if ((*pd++ = *ps++) == (char)val)
            goto Found;
    }
    return 0;
Found:
    return pd;
}
