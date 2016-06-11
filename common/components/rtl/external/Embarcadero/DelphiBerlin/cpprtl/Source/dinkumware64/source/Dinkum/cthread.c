/* cthread.c -- thread functions */
#include <Dinkum/threads/xthreads.h>
#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>

typedef struct
	{	/* bind function pointer and data to pass to thread entry point */
	_Thrd_start_t func;
	void *data;
	_Cnd_t *cond;
	_Mtx_t *mtx;
	int *started;
	} binder;

 #if _WIN32_C_LIB
#include <wrapwin.h>

  #if defined(_M_X64) || defined(_LP64) || defined(__x86_64)
typedef unsigned __int64 _Handle;
  #else /* defined(_M_X64), etc. */
 #if 1300 <= _MSC_VER
typedef __w64 unsigned _Handle;
 #else /* 1300 <= _MSC_VER */
typedef unsigned long _Handle;
 #endif /* 1300 <= _MSC_VER */
  #endif /* defined(_M_X64), etc. */

_CRTIMP _Handle _CDECL _beginthreadex(void *sec, unsigned int size,
	_Thrd_callback_t entry, void *arg,
	unsigned int init, unsigned int *id);
_CRTIMP void _CDECL _endthreadex(unsigned int res);

static unsigned int _STDCALL run(void *d)
	{	/* call thread function */
	unsigned res;
	binder b = *(binder *)d;
	_Mtx_lock(*b.mtx);
	*b.started = 1;
	_Cnd_signal(*b.cond);
	_Mtx_unlock(*b.mtx);
	res = (b.func)(b.data);
	_Tss_destroy();
	_Cnd_do_broadcast_at_thread_exit();
	return (res);
	}

void _Thrd_exit(int res)
	{	/* terminate execution of calling thread */
	_Tss_destroy();
	_endthreadex(res);
	}

int _Thrd_start(_Thrd_t *thr, _Thrd_callback_t func, void *b)
	{	/* start a thread */
	return ((thr->_Hnd =
		(HANDLE)_beginthreadex(0, 0, func, b, 0, &thr->_Id)) == 0
			? _Thrd_error : _Thrd_success);
	}

int _Thrd_join(_Thrd_t thr, int *code)
	{	/* return exit code when thread terminates */
	unsigned long res;
	if (WaitForSingleObjectEx(thr._Hnd, INFINITE, FALSE) == WAIT_FAILED
		|| GetExitCodeThread(thr._Hnd, &res) == 0)
		return (_Thrd_error);
	if (code)
		*code = (int)res;
	return (CloseHandle(thr._Hnd) == 0 ? _Thrd_error : _Thrd_success);
	}

int _Thrd_detach(_Thrd_t thr)
	{	/* tell OS to release thread's resources when it terminates */
	return (CloseHandle(thr._Hnd) == 0 ? _Thrd_error : _Thrd_success);
	}

void _Thrd_sleep(const xtime *xt)
	{	/* suspend thread until time xt */
	xtime now;
	xtime_get(&now, TIME_UTC);
	do  {	/* sleep and check time */
		Sleep(_Xtime_diff_to_millis2(xt, &now));
		xtime_get(&now, TIME_UTC);
		} while (now.sec < xt->sec
			|| now.sec == xt->sec && now.nsec < xt->nsec);
	}

void _Thrd_yield()
	{	/* surrender remainder of timeslice */
		Sleep(0);
	}

int _Thrd_equal(_Thrd_t thr0, _Thrd_t thr1)
	{	/* return 1 if thr0 and thr1 identify same thread */
	return (thr0._Id == thr1._Id);
	}

_Thrd_t _Thrd_current(void)
	{	/* return _Thrd_t identifying current thread */
	_Thrd_t thr;

#ifdef _WIN32_WCE
	thr._Hnd = (HANDLE)GetCurrentThreadId();
#else /* _WIN32_WCE */
	if (DuplicateHandle(GetCurrentProcess(), GetCurrentThread(),
		GetCurrentProcess(), &thr._Hnd,
		DUPLICATE_SAME_ACCESS, TRUE, 0))
		CloseHandle(thr._Hnd);
	else
		thr._Hnd = 0;
#endif /* _WIN32_WCE */

	thr._Id = GetCurrentThreadId();
	return (thr);
	}

_Thrd_id_t _Thrd_id(void)
	{	/* return unique id for current thread */
	return (GetCurrentThreadId());
	}


 #elif _HAS_POSIX_C_LIB
#include <pthread.h>
#include <errno.h>

static void *run(void *d)
	{	/* call thread function */
	void *res;
	binder b = *(binder *)d;
	_Mtx_lock(b.mtx);
	*b.started = 1;
	_Cnd_signal(b.cond);
	_Mtx_unlock(b.mtx);
	res = (void*)((char*)0 + (b.func)(b.data));
  #if _THREAD_EMULATE_TSS
	_Tss_destroy();
  #endif /* _THREAD_EMULATE_TSS */
	_Cnd_do_broadcast_at_thread_exit();
	return (res);
	}

int _Thrd_start(_Thrd_t *thr, _Thrd_callback_t func, void *b)
	{	/* start a thread */
	return (pthread_create(thr, 0, func, b)
		? _Thrd_busy : _Thrd_success);
	}

int _Thrd_join(_Thrd_t thr, int *code)
	{	/* return exit code when thread terminates */
	void *res;
	if (pthread_join(thr, &res) != 0)
		return (_Thrd_error);
	if (code)
		*code = (int)(uintptr_t)res;
	return (0);
	}

int _Thrd_detach(_Thrd_t thr)
	{	/* tell OS to release thread's resources when it terminates */
	return (pthread_detach(thr) ? _Thrd_error : _Thrd_success);
	}

void _Thrd_exit(int res)
	{	/* terminate execution of calling thread */
  #if _THREAD_EMULATE_TSS
	_Tss_destroy();
  #endif /* _THREAD_EMULATE_TSS */
	pthread_exit((void*)((char *)0 + res));
	}

void _Thrd_sleep(const xtime *xt)
	{	/* suspend thread until time xt */
  #if _THREAD_HAS_NANOSLEEP
	int nanosleep(const struct timespec*, struct timespec *);
	struct timespec ts = _Xtime_diff_to_ts(xt);
	struct timespec ts2;

	while (nanosleep(&ts, &ts2) == -1 && errno == EINTR)
		ts = ts2;

  #else /* _THREAD_HAS_NANOSLEEP */
	_Mtx_t mtx;
	_Cnd_t cond;
	if (_Mtx_init(&mtx, _Mtx_plain) != _Thrd_success)
		return;
	else if (_Cnd_init(&cond) == _Thrd_success)
		{	/* sleep and check time */
		_Mtx_lock(&mtx);
		_Cnd_timedwait(&cond, &mtx, xt);
		_Mtx_unlock(&mtx);
		_Cnd_destroy(&cond);
		}
	_Mtx_destroy(&mtx);
  #endif /* _THREAD_HAS_NANOSLEEP */
	}

void _Thrd_yield()
	{	/* surrender remainder of timeslice */
  #if _THREAD_HAS_SCHED_YIELD
	sched_yield();
  #else /* _THREAD_HAS_SCHED_YIELD */
	xtime now;
	xtime_get(&now, TIME_UTC);
	thrd_sleep(&now);
  #endif /* _THREAD_HAS_SCHED_YIELD */
	}

int _Thrd_equal(_Thrd_t thr0, _Thrd_t thr1)
	{	/* return 1 if thr0 and thr1 identify same thread */
	return (pthread_equal(thr0, thr1));
	}

_Thrd_t _Thrd_current(void)
	{	/* return thrd_t identifying current thread */
	return (pthread_self());
	}

_Thrd_id_t _Thrd_id(void)
	{	/* return unique id for current thread */
	return (_Thrd_current());
	}

 #else /* library type */
  #error Unknown platform
 #endif /* library type */

void _Thrd_abort(const char *msg)
	{	/* abort on precondition failure */
	fputs(msg, stderr);
	fputc('\n', stderr);
	abort();
	}

int _Thrd_create(_Thrd_t *thr, _Thrd_start_t func, void *d)
	{	/* create thread */
	int res;
	binder b;
	int started = 0;
	_Cnd_t cond;
	_Mtx_t mtx;
	_Cnd_init(&cond);
	_Mtx_init(&mtx, _Mtx_plain);
	b.func = func;
	b.data = d;
	b.cond = &cond;
	b.mtx = &mtx;
	b.started = &started;
	_Mtx_lock(_THR_ADDR mtx);
	if ((res = _Thrd_start(thr, run, &b)) == _Thrd_success)
		{	/* wait for handshake */
		while (!started)
			_Cnd_wait(_THR_ADDR cond, _THR_ADDR mtx);
		}
	_Mtx_unlock(_THR_ADDR mtx);
	_Cnd_destroy(_THR_ADDR cond);
	_Mtx_destroy(_THR_ADDR mtx);
	return (res);
	}

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
