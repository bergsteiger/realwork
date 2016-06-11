#include <string.h>
#include <tchar.h>

#if !defined(_WIN64)
#error Only for Win64
#endif

namespace std
{

#if defined(_UNICODE)
_EXPFUNC const _TCHAR *_tcschr(const _TCHAR *str, wchar_t c)
#else
_EXPFUNC const _TCHAR *_tcschr(const _TCHAR *str, int c)
#endif
{
    while (*str && *str != c)
	str++;
    return (*str == c)? str : 0;
}

#if defined(_UNICODE)
_EXPFUNC _TCHAR *_tcschr(_TCHAR *str, wchar_t c)
#else
_EXPFUNC _TCHAR *_tcschr(_TCHAR *str, int c)
#endif
{
    while (*str && *str != c)
	str++;
    return (*str == c)? str : 0;
}

}
