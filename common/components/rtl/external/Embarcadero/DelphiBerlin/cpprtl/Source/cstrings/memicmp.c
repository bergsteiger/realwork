/*-----------------------------------------------------------------------*
 * filename - memicmp.c
 *
 * function(s)
 *        memicmp - compares two memory areas
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1987, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 28609 $        */

#include <mem.h>
#include <ctype.h>
#include <_locale.h>

/*------------------------------------------------------------------------*

Name            memicmp - compares two memory areas

Usage           int memicmp(const void *s1, const void *s2, size_t n);

Prototype in    mem.h & string.h

Description     memicmp compares the  first n bytes of s1  and s2, ignoring
                character case (upper or lower).

Return value    < 0 if s1 is less than s2
                = 0 if s1 is the same as s2
                > 0 if s1 is greater than s2

*---------------------------------------------------------------------------*/

int _RTLENTRY _EXPFUNC memicmp(const void *s1, const void *s2, size_t n)
{
    int dif;
    unsigned char *p1 = (unsigned char *)s1;
    unsigned char *p2 = (unsigned char *)s2;
    int clocale;

    _lock_locale();
    clocale = __locale->isCLocale;
    _unlock_locale();

    // inline the totupper() function for __locale->isCLocale == true
    if (clocale)
    {
        for (; n-- >0; p1++, p2++ )
        {
            dif = _upper[*p1] - _upper[*p2];
            if (dif != 0)
                return(dif);
        }
        return(0);
    }
    else
    {
        for (; n-- >0; p1++, p2++ )
        {
            dif = toupper(*p1) - toupper(*p2);
            if (dif != 0)
                return(dif);
        }
        return(0);
    }
}
