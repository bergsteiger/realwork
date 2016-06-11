/*-----------------------------------------------------------------------*
 * filename - tlsstat.c
 *
 * function(s)
 *
 *   ___CRTL_TLS_Alloc
 *   ___CRTL_TLS_Free
 *   ___CRTL_TLS_GetValue
 *   ___CRTL_TLS_SetValue
 *
 *   These functions simply pass through to the System API versions, and are
 *   linked in only when linking with the static RTL lib (not the RTLDLL).
 *
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1998, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 34070 $        */

#include <_defs.h>
#include <windows.h>

DWORD WINAPI _EXPFUNC ___CRTL_TLS_Alloc (void)
{
    return TlsAlloc ();
}

BOOL WINAPI _EXPFUNC ___CRTL_TLS_Free (DWORD id)
{
    return TlsFree (id);
}

LPVOID WINAPI _EXPFUNC ___CRTL_TLS_GetValue (DWORD id)
{
    return TlsGetValue (id);
}

BOOL WINAPI _EXPFUNC ___CRTL_TLS_SetValue (DWORD id, LPVOID value)
{
    return TlsSetValue (id, value);
}

#pragma argsused
void WINAPI _EXPFUNC ___CRTL_TLS_InitThread (DWORD id)
{
}

#pragma argsused
void WINAPI _EXPFUNC ___CRTL_TLS_ExitThread (DWORD id)
{
}

int _RTLENTRY _EXPFUNC __CRTL_TLS_GetInfo (void)
/*
  This function in used for internal testing.  It returns the number of
  Alloc's that have been made.
*/
{
    return 0;
}

#if defined(_WIN64)

DWORD __TLS_index = 0;

extern int __tls_size(void);

void __init_tls_data()
{
  void *p;
  int tls_size = __tls_size();
  if (!tls_size)
      return;

  p = HeapAlloc(GetProcessHeap(), HEAP_ZERO_MEMORY, tls_size);
  ___CRTL_TLS_SetValue(__TLS_index, p);
}

void __init_tls_index()
{
#pragma startup __init_tls_index 0

  void *p;
  int tls_size = __tls_size();
  if (!tls_size)
      return;

  __TLS_index =  ___CRTL_TLS_Alloc();
  __init_tls_data();
}

void *__tls_get_addr(int offset)
{
  char *p = ___CRTL_TLS_GetValue(__TLS_index);
  if (!p)
  {
    __init_tls_data();
    p = ___CRTL_TLS_GetValue(__TLS_index);
  }
  return p + offset;
}
#endif
