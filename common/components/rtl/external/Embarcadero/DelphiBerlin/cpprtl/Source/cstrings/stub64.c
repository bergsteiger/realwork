#include <string.h>
#include <tchar.h>

#if !defined(_UNICODE)
_EXPFUNC char *_stpcpy(char *dest, const char *src)
{
  while (*src)
    *dest++ = *src++;
  *dest = 0;
  return dest;
}

_EXPFUNC char *stpcpy(char *dest, const char *src)
{
  return _stpcpy(dest, src);
}

_EXPFUNC char *strcat(char *dest, const char *src)
{
  char *p = dest + strlen(dest);

  do
  {
    *p++ = *src;
  }
  while(*src++);

  return dest;
}

_EXPFUNC char * strcpy(char *dest, const char *src)
{
  char *dest_ptr = dest;
  while (*src)
    *dest++ = *src++;
  *dest = 0;
  return dest_ptr;
}

_EXPFUNC size_t strlen(const char *s)
{
  size_t len = 0;
  while (*s++)
    len++;
  return len;
}
#endif

_EXPFUNC int _tcscmp(const _TCHAR *str1, const _TCHAR *str2)
{
    const _TUCHAR *p1, *p2;

    p1 = (const _TUCHAR *)str1;
    p2 = (const _TUCHAR *)str2;

    while(*p1 || *p2)
    {
        if (*p1 != *p2)
	  return (*p1 < *p2)? -1 : 1;
	p1++;
	p2++;
    }
    return 0;
}

#if defined(_UNICODE)
_EXPFUNC int _tmemcmp(const wchar_t *s1, const wchar_t *s2, size_t n)
#else
_EXPFUNC int _tmemcmp(const void *s1, const void *s2, size_t n)
#endif
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

#if defined(_UNICODE)
_EXPFUNC _TCHAR *_tcschr(const _TCHAR *str, wchar_t c)
#else
_EXPFUNC _TCHAR *_tcschr(const _TCHAR *str, int c)
#endif
{
  while (*str && *str != c)
    str++;
  return (*str == c)? str : 0;
}

#if defined(_UNICODE)
_EXPFUNC wchar_t * _tmemchr(const wchar_t *s, int val, size_t n)
#else
_EXPFUNC void * _tmemchr(const void *s, int val, size_t n)
#endif
{
  const _TUCHAR *p = (const _TUCHAR *)s;

    while(n--)
    {
        if (*p == val)
	  return (void *)p;
	p++;
    }
    return 0;
}
