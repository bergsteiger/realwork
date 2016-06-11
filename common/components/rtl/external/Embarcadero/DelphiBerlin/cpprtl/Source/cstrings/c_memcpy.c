#include <mem.h>
#include <tchar.h>

#if defined(_UNICODE)
wchar_t * _EXPFUNC wmemcpy(wchar_t *dest, const wchar_t *src, size_t n)
#else
void * _EXPFUNC memcpy(void *dest, const void *src, size_t n)
#endif
{
    return _tmemmove(dest, src, n);
}
