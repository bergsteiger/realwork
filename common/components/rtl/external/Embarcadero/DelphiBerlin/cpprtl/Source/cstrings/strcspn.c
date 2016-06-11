/*-----------------------------------------------------------------------*
 * filename - strcspn.c
 *
 * function(s)
 *        strcspn - scans a string for the first segment not containing
 *                  any subset of a given set of characters
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

/*---------------------------------------------------------------------*

Name            strcspn, wcscspn - scans a string for the first segment
                          not containing any subset of a given set of
                          characters

Usage           size_t strcspn(const char *str1, const char *str2);
		size_t wcscspn(const wchar_t *str1, const wchar_t *str2);

Prototype in    string.h

Description     strcspn and wcscspn return the length of the initial segment
                of string str1 that consists entirely of characters not
                from string str2.

Return value    strcspn and wcscspn return the length of the initial segment
                of string str1 that consists entirely of characters not
                from string str2.

*---------------------------------------------------------------------*/

size_t _RTLENTRY _EXPFUNC _tcscspn(const _TCHAR *s1, const _TCHAR *s2)
{
    register const _TCHAR *srchs1, *srchs2;
    register sc1, sc2;

    for (srchs1 = s1; (sc1 = *srchs1) != 0; srchs1++)
        for (srchs2 = s2; (sc2 = *srchs2) != 0; srchs2++)
            if (sc1 == sc2) goto bye;
bye:
    return srchs1 - s1;
}

