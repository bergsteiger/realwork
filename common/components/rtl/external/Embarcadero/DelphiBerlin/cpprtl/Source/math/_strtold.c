#include <stdlib.h>

#if !defined(_UNICODE)
long double   _RTLENTRY _strtold(const char * s, char * *endptr)
{
    return strtold(s, endptr);
}
#else
long double   _RTLENTRY _wcstold(const wchar_t * s, wchar_t * *endptr)
{
    return wcstold(s, endptr);
}
#endif
