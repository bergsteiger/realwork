/* once.c -- once functions */
#include <Dinkum/threads/xthreads.h>
#include <stdlib.h>

 #if _WIN32_C_LIB
#include <wrapwin.h>


static long once_state;
static CRITICAL_SECTION mtx;

static void cleanup(void)
	{	/* free resources at program termination */
	DeleteCriticalSection(&mtx);
	}

static void init_mutex(void)
	{	/* initialize once */
	long old;
	if (once_state == 2)
		;
	else if ((old = InterlockedExchange(&once_state, 1)) == 0)
		{	/* execute _Func, mark as executed */
		InitializeCriticalSection(&mtx);
		atexit(cleanup);
		once_state = 2;
		}
	else if (old == 2)
		once_state = 2;
	else
		while (once_state != 2)
			Sleep(1);
	}

void _Call_once(_Once_flag *cntrl, void (*func)(void))
	{	/* execute func exactly one time */
	init_mutex();
	EnterCriticalSection(&mtx);
	if (*cntrl == _ONCE_FLAG_INIT)
		{	/* call func and mark as called */
		func();
		*cntrl = !_ONCE_FLAG_INIT;
		}
	LeaveCriticalSection(&mtx);
	}

 #elif _HAS_POSIX_C_LIB
void _Call_once(_Once_flag *cntrl, void (*func)(void))
	{	/* execute func exactly one time */
	pthread_once(cntrl, func);
	}

 #else /* library type */
  #error Unknown platform
 #endif /* library type */

/*
 * This file is derived from software bearing the following
 * restrictions:
 *
 * (c) Copyright William E. Kempf 2001
 *
 * Permission to use, copy, modify, distribute and sell this
 * software and its documentation for any purpose is hereby
 * granted without fee, provided that the above copyright
 * notice appear in all copies and that both that copyright
 * notice and this permission notice appear in supporting
 * documentation. William E. Kempf makes no representations
 * about the suitability of this software for any purpose.
 * It is provided "as is" without express or implied warranty.
 */

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
