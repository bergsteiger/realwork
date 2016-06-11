#include <_defs.h>

#if defined(_WIN64)
void __declspec(naked) _RTLENTRY _EXPFUNC access()  
{
    asm("jmp __access");
}

void __declspec(naked) _RTLENTRY _EXPFUNC fcloseall()
{
  asm("jmp _fcloseall");
}

void __declspec(naked) _RTLENTRY _EXPFUNC fgetchar()
{
  asm("jmp _fgetchar");
}

void __declspec(naked) _RTLENTRY _EXPFUNC fileno()
{
  asm("jmp _fileno");
}

void __declspec(naked) _RTLENTRY _EXPFUNC fputchar()
{
  asm("jmp _fputchar");
}

void __declspec(naked) _RTLENTRY _EXPFUNC getw()
{
  asm("jmp _getw");
}

void __declspec(naked) _RTLENTRY _EXPFUNC mkdir()
{
  asm("jmp _mkdir");
}

void __declspec(naked) _RTLENTRY _EXPFUNC mktemp()
{
  asm("jmp _mktemp");
}

void __declspec(naked) _RTLENTRY _EXPFUNC rmdir()
{
  asm("jmp _rmdir");
}

void __declspec(naked) _RTLENTRY _EXPFUNC rmtmp()
{
  asm("jmp _rmtmp");
}

void __declspec(naked) _RTLENTRY _EXPFUNC sopen()
{
  asm("jmp _sopen");
}

#if 0
void __declspec(naked) _RTLENTRY _EXPFUNC stat()
{
  asm("jmp _stat");
}
#endif

void __declspec(naked) _RTLENTRY _EXPFUNC tempnam()
{
  asm("jmp _tempnam");
}

#if 0
void __declspec(naked) _RTLENTRY _EXPFUNC unlink()
{
  asm("jmp _unlink");
}
#endif

void __declspec(naked) _RTLENTRY _EXPFUNC utime()
{
  asm("jmp _utime");
}

void __declspec(naked) _RTLENTRY _EXPFUNC chsize()
{
  asm("jmp __ftruncate");
}

#if 0
void __declspec(naked) _RTLENTRY _EXPFUNC close()
{
  asm("jmp __close");
}
#endif

void __declspec(naked) _RTLENTRY _EXPFUNC fdopen()
{
  asm("jmp _fdopen");
}

void __declspec(naked) _RTLENTRY _EXPFUNC flushall()
{
  asm("jmp _flushall");
}

void __declspec(naked) _RTLENTRY _EXPFUNC fnsplit()
{
  asm("jmp _fnsplit");
}

void __declspec(naked) _RTLENTRY _EXPFUNC _ftruncate()
{
  asm("jmp __ftruncate");
}

#if 0
void __declspec(naked) _RTLENTRY _EXPFUNC isatty()
{
  asm("jmp __isatty");
}
#endif

void __declspec(naked) _RTLENTRY _EXPFUNC lseek()
{
  asm("jmp __lseek");
}

#if 0
void __declspec(naked) _RTLENTRY _EXPFUNC open()
{
  asm("jmp __open");
}
#endif

void __declspec(naked) _RTLENTRY _EXPFUNC _open()
{
  asm("jmp __open");
}

#if 0
void __declspec(naked) _RTLENTRY _EXPFUNC read()
{
  asm("jmp __read");
}
#endif

#if 0
void __declspec(naked) _RTLENTRY _EXPFUNC remove()
{
  asm("jmp _unlink");
}
#endif

void __declspec(naked) _RTLENTRY _EXPFUNC umask()
{
  asm("jmp _umask");
}

void __declspec(naked) _RTLENTRY _EXPFUNC wopen()
{
  asm("jmp __wopen");
}

void __declspec(naked) _RTLENTRY _EXPFUNC _wopen()
{
  asm("jmp __wopen");
}

#if 0
void __declspec(naked) _RTLENTRY _EXPFUNC write()
{
  asm("jmp __write");
}
#endif

#endif
