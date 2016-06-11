#include <string.h>
#include <tchar.h>

#if defined(_UNICODE)
wchar_t *_EXPFUNC wcsncat(wchar_t *dest, const wchar_t *src, size_t maxlen)
#else
char * _EXPFUNC strncat(char *dest, const char *src, size_t maxlen)
#endif
{
  size_t srclen, destlen;

    if (maxlen <= 0)
	return dest;
    srclen = _tcslen(src);
    destlen = _tcslen(dest);
    if (srclen < maxlen)
	_tmemmove(dest+destlen, src, srclen+1);
    else
    {
	_tmemmove(dest+destlen, src, maxlen);
	dest[destlen+maxlen] = 0;
    }
    return dest;
}
