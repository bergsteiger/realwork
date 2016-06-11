#include <windows.h>

#define EXPORT __declspec(dllexport)

#ifdef BYPASS_WINDOWS
EXPORT int __CPPdebugHook = 2;
#else // !BYPASS_WINDOWS
EXPORT int __CPPdebugHook = 0;
#endif // !BYPASS_WINDOWS
