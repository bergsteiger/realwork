#include <windows.h>
#include <tchar.h>

extern __cdecl int FMXmain(void);

#pragma argsused
WINAPI _FMXmainThunk(HINSTANCE _unused1, HINSTANCE _unused2, LPSTR _unused3, int _unused4)
{
    return FMXmain();
}
