// -----------------------------------------------------------------------
//
// Name           strncmp, wcsncmp - compare one string to another
//
// Usage          int strncmp(const char *str1, const char *str2, size_t maxlen)
// 		  int wcsncmp(const wchar_t *str1, const wchar_t *str2, size_t maxlen)
//
// Prototype in   string.h
//
//
// Description    Compare *str1  with *str2, returning  a negative, zero,  or
//                positive integer  according to whether *str1  is less than,
//                equal, or greater than *str2, respectively.
//
//                At most "maxlen" characters will be compared. A "maxlen" of zero
//                results in an equal compare, i.e. returns a zero.
//
// Return value   strncmp and wcsncmp return an integer value as follows:
//                    < 0 if str1 is less than str2
//                    = 0 if str1 is the same as str2
//                    > 0 if str2 is greater than str2
//
// -----------------------------------------------------------------------

#include <stdio.h>
#include <tchar.h>

_EXPFUNC int _tcsncmp(const _TCHAR *str1, const _TCHAR *str2, size_t maxlen)
{
#if defined(_UNICODE)
    wchar_t *p1, *p2;
    p1 = str1;
    p2 = str2;
#else
    const unsigned char *p1, *p2;
    p1 = (const unsigned char *)str1;
    p2 = (const unsigned char *)str2;
#endif

    while(maxlen-- && (*p1 || *p2))
    {
        if (*p1 != *p2)
	  return (*p1 < *p2)? -1 : 1;
	p1++;
	p2++;
    }
    return 0;
}
