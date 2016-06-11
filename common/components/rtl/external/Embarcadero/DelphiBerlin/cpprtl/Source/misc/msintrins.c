#include <windows.h>

_EXPFUNC PVOID
InterlockedExchangePointer(
    __inout __drv_interlocked PVOID volatile *Target,
    __in_opt PVOID Value
    )
{
    return (PVOID)InterlockedExchange((PLONG)(Target), (LONG)(Value));
}
