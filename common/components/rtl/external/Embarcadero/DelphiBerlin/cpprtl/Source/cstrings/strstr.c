/*-----------------------------------------------------------------------*
 * filename - strstr.c
 *
 * function(s)
 *        strstr - scans a string for the occurrence of a given string
 *        wcsstr - scans a wide-character string for the occurrence of a
 *        given wide-characterstring
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1987, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 24901 $        */

#include <string.h>
#include <tchar.h>

/*-----------------------------------------------------------------------*

Name            strstr, wcsstr - scans a string for the occurrence of a
                                 given string.

Usage           char *strstr(const char *str1, const char *str2);
        wchar_t *strstr(const wchar_t *str1, const wchar_t *str2);

Prototype in    string.h

Description     strstr and wcsstr scan str1 for the first occurrence of the
                substring str2.

Return value    strstr and wcsstr return a pointer to the element in str1
                that contains str2 (points to str2 in str1). If str2 does
                not occur in str1, strstr returns NULL.


*------------------------------------------------------------------------*/

#pragma option push -r

_TCHAR * _RTLENTRY _EXPFUNC _tcsstr(const _TCHAR *str1, const _TCHAR *str2)
{
    _TCHAR *c1, *c2, *s = (_TCHAR *)str1;
    _TCHAR sc, first = *str2;

    if (!first)
        return (_TCHAR *)str1;    /* return str1 if str2 is empty */

    if (!*s)
        return NULL;              /* return NULL if str1 is empty */

    str2++;                       /* increment once, to save the "inc" in the inner loop */
    while((sc = *s) != 0)
    {
        while (sc && sc != first) /* wait for the first matching char */
            sc = *++s;
        if (!sc)
            break;
        s++;                      /* move to next char */

                                  /* continue matching chars in the sub-str */
        c1 = s;
        c2 = (_TCHAR*)str2;

        while ((sc = *c2) != 0 && (sc == *c1))
        {
            c2++;
            c1++;
        }
        if (!sc)              /* if we've run off the end of str2 */
            goto Found;       /* then we've found the first substr match */
        if (!*c1)             /* if we've run off the end of str1 */
            break;            /* then str1 doesn't contain the substr */
    }

    return NULL;                  /* didn't find anything */
Found:
    return s - 1;                 /* s points to the next char */
}
#pragma option pop
