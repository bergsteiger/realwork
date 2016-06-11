#include <string.h>
#include <tchar.h>

#if !defined(_WIN64)
#error Only for Win64
#endif

#define jumpx(target) #target
#define jump(target) asm("jmp " jumpx(target))

namespace std
{

#if defined(_UNICODE)
const wchar_t * _EXPFUNC _wmemchr(const wchar_t *s, int c, size_t n)
#else
const void * _EXPFUNC _tmemchr(const void *s, int c, size_t n)
#endif
{
    const _TUCHAR *p = (const _TUCHAR *)s;

    while(n--)
    {
        if (*p == c)
#if defined(_UNICODE)
	    return (const wchar_t *)p;
#else
	    return (const void *)p;
#endif
	p++;
    }
    return 0;
}

#if defined(_UNICODE)
wchar_t * _EXPFUNC _wmemchr(wchar_t *s, int c, size_t n)
#else
void * _EXPFUNC _tmemchr(void *s, int c, size_t n)
#endif
{
    const _TUCHAR *p = (const _TUCHAR *)s;

    while(n--)
    {
        if (*p == c)
#if defined(_UNICODE)
	    return (wchar_t *)p;
#else
	    return (void *)p;
#endif
	p++;
    }
    return 0;
}

}
