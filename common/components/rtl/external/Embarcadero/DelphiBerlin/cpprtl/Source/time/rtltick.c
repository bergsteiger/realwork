/*
    rtltick.c

    _rtl_mstick - returns a millisecond resolution tick value
    _rtl_ustick - returns a microsecond resolution tick value
*/

#include <windows.h>
#include <dos.h>

unsigned long _RTLENTRY _EXPFUNC _rtl_mstick(void)
{
    return (unsigned long) GetTickCount();
}

unsigned __int64 _RTLENTRY _EXPFUNC _rtl_ustick(void)
{
    unsigned __int64 ret;
    FILETIME ft;

    GetSystemTimeAsFileTime(&ft);

    /* ret now represents 100-nanosecond intervals */
    ret = ((unsigned __int64)ft.dwHighDateTime) << 32 + ft.dwLowDateTime;

    /* convert ret into microseconds */
    ret = ret / 10;

    return ret;
}
