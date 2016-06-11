/* thread support for Win32 */
#include <yvals.h>


 #if !_MULTI_THREAD || _WIN32_C_LIB && __EDG__ && !__INTEL_COMPILER

 #elif _WIN32_C_LIB
  #include <stdlib.h>
  #include "xtls.h"
  #include <wchar.h>
  #include "wrapwin.h"

 #if 1300 <= _MSC_VER

  #ifdef _WIN64
typedef unsigned __int64 _Handle;

  #else /* _WIN64 */
typedef __w64 unsigned _Handle;
  #endif /* _WIN64 */

 #else /* 1300 <= _MSC_VER */
typedef unsigned long _Handle;
 #endif /* 1300 <= _MSC_VER */

_STD_BEGIN

typedef struct
	{	/* thread start info */
	union
		{
		void (*start)(void*);
		unsigned int (__stdcall *startex)(void*);
		} st;
	void *arg;
	} thread_t;

void _endthread(void)
	{	/* end thread */
	_Destroytls();
	CloseHandle(GetCurrentThread());
	ExitThread(0);
	}

void _endthreadex(unsigned int res)
	{	/* end thread, extended */
	_Destroytls();
	ExitThread(res);
	}

static unsigned long WINAPI start(void *thr)
	{	/* run a thread */
	thread_t thr_data = *(thread_t*)thr;

	free(thr);
	thr_data.st.start(thr_data.arg);
	_endthread();
	return (0);	/* should never be executed */
	}

_Handle _beginthread(void (*entry)(void *),
	unsigned int size, void *arg)
	{	/* begin a new thread */
	thread_t *thr = (thread_t *)calloc(1, sizeof(thread_t));
	HANDLE hnd = 0;

	if (thr != 0)
		{	/* got storage for thread, start it */
		unsigned long dummy;

		thr->st.start = entry;
		thr->arg = arg;
		hnd = CreateThread(0, size, start, thr,	0, &dummy);

		if (hnd == 0)
			free(thr);
		}
	return ((_Handle)hnd);
	}

static unsigned long WINAPI startex(void *thr)
	{	/* run a thread, extended */
	thread_t thr_data = *(thread_t*)thr;

	free(thr);
	_endthreadex(thr_data.st.startex(thr_data.arg));
	return (0);	/* should never be executed */
	}

_Handle _beginthreadex(void *sec, unsigned int size,
	unsigned int (__stdcall *entry)(void*), void *arg,
	unsigned int init, unsigned int *id)
	{	/* begin a new thread, extended */
	thread_t *thr = (thread_t *)calloc(1, sizeof(thread_t));
	HANDLE hnd = 0;

	if (thr != 0)
		{	/* got storage for thread, start it */
		unsigned long tempid;
		thr->st.startex = entry;
		thr->arg = arg;
		hnd = CreateThread(sec, size, startex, thr,	init, &tempid);
		if (hnd == 0)
			free(thr);
		*id = (int)tempid;
		}
	return ((_Handle)hnd);
	}
_STD_END
 #endif /* !_MULTI_THREAD etc. */

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
