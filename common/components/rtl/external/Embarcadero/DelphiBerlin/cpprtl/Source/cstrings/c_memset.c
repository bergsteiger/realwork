#include <tchar.h>

#if defined(_UNICODE) || !defined(_WIN64) 

#if defined(_UNICODE)
wchar_t * _EXPFUNC _tmemset(wchar_t *s, int c, size_t n)
#else
void * _EXPFUNC  _tmemset(void *s, int c, size_t n)
#endif
{
    _TCHAR *p = (_TCHAR *)s;
    while (n--)
	*p++ = c;
    return s;
}

#else

#include <stdint.h>

void * _EXPFUNC  _tmemset(void *s, int c, size_t n)
{
    uint8_t b;
    uint8_t *bp;
    uint64_t qv;
    uint64_t *qp;

    if (n && s)
    {
        b = c;

        /* copy until pointer is aligned */
        bp = (uint8_t *)s;
        while (n && ((unsigned long)bp & 0x08))
        {
            *bp++ = b;
            n--;
        }

        qv = b;
        qv |= qv << 8;
        qv |= qv << 16;
        qv |= qv << 32;

        /* eight byte copies */
        qp = (uint64_t *)bp;
        while (n/8)
        {
            *qp++ = qv;
            n -= 8;
        }

        /* finish off remainder */
        bp = (uint8_t *)qp;
        while(n--)
        {
            *bp++ = b;
        }
    }
    return s;
}
#endif
