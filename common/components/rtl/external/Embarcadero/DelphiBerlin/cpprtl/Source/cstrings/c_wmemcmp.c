#define _UNICODE

#include <string.h>
#include <tchar.h>

int _EXPFUNC _tmemcmp(const wchar_t *s1, const wchar_t *s2, size_t n)
{
    _TUCHAR *p1, *p2;

    p1 = (_TUCHAR *)s1;
    p2 = (_TUCHAR *)s2;

    while(n--)
    {
        if (*p1 != *p2)
	  return (*p1 < *p2)? -1 : 1;
	p1++;
	p2++;
    }
    return 0;
}
