#include <mem.h>
#include <tchar.h>

#if defined(_UNICODE)
wchar_t * _EXPFUNC wmemmove(wchar_t *dest, const wchar_t *src, size_t n)
#else
void * _EXPFUNC memmove(void *dest, const void *src, size_t n)
#endif
{
    int overlap = 0;
    _TUCHAR *s = (_TUCHAR *) src;
    _TUCHAR *d = (_TUCHAR *) dest;

    if (d > s && d < s+n)
    {
	// overlap
	s = s + n-1;
	d = d + n-1;
	while (n--)
	    *d-- = *s--;
    }
    else
    {
	while (n--)
	    *d++ = *s++;
    }
    return dest;
}
