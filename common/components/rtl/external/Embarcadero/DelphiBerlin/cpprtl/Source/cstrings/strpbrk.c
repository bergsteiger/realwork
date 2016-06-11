/*-----------------------------------------------------------------------*
 * filename - strpbrk.c
 *
 * function(s)
 *        strpbrk, wspbrk - scans an ASCII/wide_character  string for the first
 *                  occurrence of any ASCII/wide-character a given set
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1987, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 24901 $        */

//#pragma inline

#include <string.h>
#include <tchar.h>

/*---------------------------------------------------------------------*

Name            strpbrk, wcspbrk - scans an ASCII/wide_character string for
			the first occurrence of any ASCII/wide-character
			in a given set

Usage           char *strpbrk(const char *str1, const char *str2);
		wchar_t *wcspbrk(const wchar_t *str1, const wchar_t *str2);

Prototype in    string.h

Description     strpbrk and wcspbrk scan an ASCII/wide-character string, str1,
		for the first occurrence of any character appearing in str2.

Return value    strpbrk and wcspbrk return a pointer to the first occurrence of
		any of the characters in str2; if none of the str2 characters
		occurs in str1, it returns NULL.

*---------------------------------------------------------------------*/

_TCHAR * _RTLENTRY _EXPFUNC _tcspbrk(const _TCHAR *s1, const _TCHAR *s2)
{
     register const _TCHAR *srchs2;
     register _TCHAR c, sc;

     while ((c = *s1) != 0)
     {
             srchs2 = s2;
             while ((sc = *srchs2++) != 0)
                    if (c == sc)
                            goto Found;
             s1++;
     }
     return (0);
Found:
     return (_TCHAR*)s1;
}
