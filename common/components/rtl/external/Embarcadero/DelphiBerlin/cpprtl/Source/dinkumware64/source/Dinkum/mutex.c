/* mutex.c -- mutex functions */
/* NB: compile as C++ if _WIN32_CLIB && !defined(_M_CEE) */
#include <Dinkum/threads/threads.h>
#include <Dinkum/threads/xtimec.h>
#include <stdlib.h>

 #if _WIN32_C_LIB
#include <wrapwin.h>

struct _Mtx_internal_imp_t
	{	/* Win32 mutex */
	int type;
	LPCRITICAL_SECTION hnd;
	int count;
	thrd_t owner;
	};

int _Mtx_init(_Mtx_t *mtx, int type)
	{	/* initialize mutex */
	_Mtx_t mutex;
	*mtx = 0;

	if ((mutex = (mtx_t)calloc(1, sizeof (struct _Mtx_internal_imp_t))) == 0)
		return (_Thrd_nomem);	/* report alloc failed */
	else if ((type & ~_Mtx_recursive) == _Mtx_plain)
		{	/* allocate for plain mutex */
		if ((mutex->hnd =
			(LPCRITICAL_SECTION)malloc(sizeof(CRITICAL_SECTION))) == 0)
			{	/* report alloc failed */
			free(mutex);
			return (_Thrd_nomem);
			}
		InitializeCriticalSection(mutex->hnd);

		mutex->type = type;
		*mtx = mutex;
		return (_Thrd_success);
		}

	else if ((mutex->hnd = (LPCRITICAL_SECTION)CreateMutex(0, 0, 0)) == 0)
		{	/* report create failed */
		free(mutex);
		return (_Thrd_error);
		}
	else
		{	/* report success */
		mutex->type = type;
		*mtx = mutex;
		return (_Thrd_success);
		}
	}

void _Mtx_destroy(_Mtx_t mtx)
	{	/* destroy mutex */
	if (mtx)
		{	/* something to do, do it */
		_THREAD_ASSERT(mtx->count == 0, "mutex destroyed while busy");
		if ((mtx->type & ~_Mtx_recursive) == _Mtx_plain)
			{	/* free storage */
			DeleteCriticalSection(mtx->hnd);
			free(mtx->hnd);
			}
		else
			CloseHandle(mtx->hnd);
		free(mtx);
		}
	}

static int mtx_do_lock(_Mtx_t mtx, const xtime *target)
	{	/* lock mutex */
	if ((mtx->type & ~_Mtx_recursive) == _Mtx_plain)
		{	/* set the lock */
		EnterCriticalSection(mtx->hnd);
		mtx->owner = thrd_current();
		if (1 < ++mtx->count)
			LeaveCriticalSection(mtx->hnd);

		return (_Thrd_success);
		}
	else
		{	/* handle timed or recursive mutex */
		int res = WAIT_TIMEOUT;
		if (target == 0)
			{	/* no target --> plain wait (i.e. infinite timeout) */
			res = WaitForSingleObject(mtx->hnd, INFINITE);
			}
		else if (target->sec < 0 || target->sec == 0 && target->nsec <= 0)
			{	/* target time <= 0 --> plain trylock or timed wait for */
				/* time that has passed; try to lock with 0 timeout */
			res = WaitForSingleObject(mtx->hnd, 0);
			}
		else
			{	/* check timeout */
			xtime now;
			xtime_get(&now, TIME_UTC);
			while (now.sec < target->sec
				|| now.sec == target->sec && now.nsec < target->nsec)
				{	/* time has not expired */
				res = WaitForSingleObject(mtx->hnd,
					_Xtime_diff_to_millis2(target, &now));
				if (res != WAIT_TIMEOUT)
					break;

				xtime_get(&now, TIME_UTC);
				}
			}
		if (res != WAIT_OBJECT_0 && res != WAIT_ABANDONED)
			;

		else if (1 < ++mtx->count)
			{	/* check count */
			if ((mtx->type & _Mtx_recursive) != _Mtx_recursive)
				{	/* not recursive, fixup count */
				--mtx->count;
				res = WAIT_TIMEOUT;
				}
			ReleaseMutex(mtx->hnd);
			}
		else
			mtx->owner = thrd_current();

		switch (res)
			{
		case WAIT_OBJECT_0:
		case WAIT_ABANDONED:
			return (_Thrd_success);

		case WAIT_TIMEOUT:
			if (target == 0 || (target->sec == 0 && target->nsec == 0))
				return (_Thrd_busy);
			else
				return (_Thrd_timedout);

		default:
			return (_Thrd_error);
			}
		}
	}

int _Mtx_unlock(_Mtx_t mtx)
	{	/* unlock mutex */
	_THREAD_ASSERT(1 <= mtx->count
		&& _Thrd_equal(mtx->owner, thrd_current()),
		"unlock of unowned mutex");

	if (--mtx->count != 0)
		;
	else if ((mtx->type & ~_Mtx_recursive) == _Mtx_plain)
		LeaveCriticalSection(mtx->hnd);
	else
		ReleaseMutex(mtx->hnd);
	return (_Thrd_success);
	}

int _Mtx_lock(_Mtx_t mtx)
	{	/* lock mutex */
	return (mtx_do_lock(mtx, 0));
	}

int _Mtx_trylock(_Mtx_t mtx)
	{	/* attempt to lock try_mutex */
	xtime xt;
	_THREAD_ASSERT((mtx->type & (_Mtx_try | _Mtx_timed)) != 0,
		"trylock not supported by mutex");
	xt.sec = xt.nsec = 0;
	return (mtx_do_lock(mtx, &xt));
	}

int _Mtx_timedlock(_Mtx_t mtx, const xtime *xt)
	{	/* attempt to lock timed mutex */
	int res;

	_THREAD_ASSERT((mtx->type & _Mtx_timed) != 0,
		"timedlock not supported by mutex");
	res = mtx_do_lock(mtx, xt);
	return (res == _Thrd_busy ? _Thrd_timedout : res);
	}

int _Mtx_current_owns(_Mtx_t mtx)
	{	/* test if current thread owns mutex */
	return (mtx->count != 0
		&& thrd_equal(mtx->owner, thrd_current()));
	}

int _Save_state(struct _Mtx_internal_imp_t *mtx, _Mtx_state *state)
	{	/* save state */
	state->_Count = mtx->count;
	mtx->count = 1;
	return (mtx_unlock(&mtx));
	}

int _Restore_state(struct _Mtx_internal_imp_t *mtx, _Mtx_state *state)
	{	/* restore state */
	int res = mtx_do_lock(mtx, 0);
	mtx->count = state->_Count;
	return (res);
	}

 #elif _HAS_POSIX_C_LIB
#include <errno.h>
#include <stdio.h>

struct _Mtx_internal_imp_t
	{	/* POSIX mutex */
	int type;
	pthread_mutex_t mtx;
	pthread_cond_t cond;
	pthread_t owner;
	int count;
	};

int _Mtx_init(_Mtx_t *mtx, int type)
	{	/* initialize mutex */
	_Mtx_t mutex;
	*mtx = 0;

	if ((mutex = (mtx_t)calloc(1, sizeof (struct _Mtx_internal_imp_t))) == 0)
		return (_Thrd_nomem);	/* report alloc failed */
	else if ((type & (_Mtx_timed | _Mtx_recursive)) != 0
		&& pthread_cond_init(&mutex->cond, 0) != 0)
		{	/* report init failed */
		free(mutex);
		return (_Thrd_error);
		}
	else
		{	/* report success */
		pthread_mutex_init(&mutex->mtx, 0);
		mutex->type = type;
		*mtx = mutex;
		return (_Thrd_success);
		}
	}

void _Mtx_destroy(_Mtx_t *mtx)
	{	/* clean up */
	if (mtx && *mtx)
		{	/* something to do, do it */
		_THREAD_ASSERT((*mtx)->count == 0, "mutex destroyed while busy");
		pthread_mutex_destroy(&(*mtx)->mtx);
		if (((*mtx)->type & (mtx_timed | mtx_recursive)) != 0)
			pthread_cond_destroy(&(*mtx)->cond);
		free(*mtx);
		}
	}

int _Mtx_unlock(_Mtx_t *mtx)
	{	/* unlock mutex */
	_THREAD_ASSERT(1 <= (*mtx)->count
		&& _Thrd_equal((*mtx)->owner, thrd_current()),
		"unlock of unowned mutex");
	if (((*mtx)->type & (_Mtx_timed | _Mtx_recursive)) == 0)
		--(*mtx)->count;
	else if (pthread_mutex_lock(&(*mtx)->mtx) != 0)
		return (_Thrd_error);
	else if (--(*mtx)->count == 0)
		pthread_cond_signal(&(*mtx)->cond);
	pthread_mutex_unlock(&(*mtx)->mtx);
	return (_Thrd_success);
	}

int _Mtx_lock(_Mtx_t *mtx)
	{	/* lock mutex */
	int errcode = pthread_mutex_lock(&(*mtx)->mtx);

	if (errcode != 0)
		return (errcode == EDEADLK ? _Thrd_busy : _Thrd_error);
	else if (((*mtx)->type & (_Mtx_timed | _Mtx_recursive)) == 0)
		{	/* done, quit */
		++(*mtx)->count;
		(*mtx)->owner = pthread_self();
		return (_Thrd_success);
		}
	else if ((*mtx)->count != 0
		&& !pthread_equal((*mtx)->owner, pthread_self()))
		{	/* block until mutex available */
		while ((*mtx)->count != 0)
			pthread_cond_wait(&(*mtx)->cond, &(*mtx)->mtx);
		}
	++(*mtx)->count;
	(*mtx)->owner = pthread_self();
	pthread_mutex_unlock(&(*mtx)->mtx);
	return (_Thrd_success);
	}

int _Mtx_trylock(_Mtx_t *mtx)
	{	/* attempt to lock try_mutex */
	int res;
	_THREAD_ASSERT(((*mtx)->type & _Mtx_try) != 0,
		"trylock not supported by mutex");
	if (((*mtx)->type & (_Mtx_timed | _Mtx_recursive)) != 0)
		;
	else if ((res = pthread_mutex_trylock(&(*mtx)->mtx)) == 0)
		{	/* done, quit */
		(*mtx)->owner = pthread_self();
		++(*mtx)->count;
		return (_Thrd_success);
		}
	else if (res == EBUSY)
		return (_Thrd_busy);
	else
		return (_Thrd_error);
	if (pthread_mutex_lock(&(*mtx)->mtx) != 0)
		return (_Thrd_error);
	else if ((*mtx)->count != 0
		&& (((*mtx)->type & _Mtx_recursive) != _Mtx_recursive
			|| !pthread_equal((*mtx)->owner, pthread_self())))
		res = _Thrd_busy;
	else
		{	/* take ownership */
		(*mtx)->owner = pthread_self();
		++(*mtx)->count;
		res = _Thrd_success;
		}
	pthread_mutex_unlock(&(*mtx)->mtx);
	return (res);
	}

int _Mtx_timedlock(_Mtx_t *mtx, const xtime *xt)
	{	/* attempt to lock timed mutex */
	int res = _Thrd_success;
	_THREAD_ASSERT(((*mtx)->type & _Mtx_timed) != 0,
		"timedlock not supported by mutex");
	if (pthread_mutex_lock(&(*mtx)->mtx) != 0)
		return (_Thrd_error);
	else if ((*mtx)->count == 0)
		;
	else if (!pthread_equal((*mtx)->owner, pthread_self()))
		{	/* block until mutex available */
		struct timespec ts = _Xtime_to_ts(xt);
		while ((*mtx)->count != 0 && res != _Thrd_timedout)
			res = pthread_cond_timedwait(&(*mtx)->cond,
				&(*mtx)->mtx, &ts) == ETIMEDOUT
					? _Thrd_timedout : _Thrd_success;
		}
	else if (((*mtx)->type & _Mtx_recursive) != _Mtx_recursive)
		res = _Thrd_timedout;
	if (res == _Thrd_success)
		{	/* take ownership */
		(*mtx)->owner = pthread_self();
		++(*mtx)->count;
		}
	pthread_mutex_unlock(&(*mtx)->mtx);
	return (res);
	}

pthread_mutex_t *_Save_state(struct _Mtx_internal_imp_t *mtx,
	_Mtx_state *state)
	{	/* save mutex state while unlocked by condition variable */
	if ((mtx->type & (mtx_timed | mtx_recursive)) != 0)
		{	/* something to do, do it */
		pthread_mutex_lock(&mtx->mtx);
		state->_Count = mtx->count;
		mtx->count = 0;
		state->_Owner = mtx->owner;
		pthread_cond_signal(&mtx->cond);
		}
	else
		{	/* done, quit */
		state->_Count = mtx->count;
		mtx->count = 0;
		state->_Owner = mtx->owner;
		}
	return (&mtx->mtx);
	}

int _Restore_state(struct _Mtx_internal_imp_t *mtx, _Mtx_state *state)
	{	/* restore mutex state when relocked by condition variable */
	if ((mtx->type & (mtx_timed | mtx_recursive)) != 0)
		{	/* something to do, do it */
		while (mtx->count != 0)
			pthread_cond_wait(&mtx->cond, &mtx->mtx);
		mtx->count = state->_Count;
		mtx->owner = state->_Owner;
		pthread_mutex_unlock(&mtx->mtx);
		}
	else
		{	/* done, but save info */
		mtx->count = state->_Count;
		mtx->owner = state->_Owner;
		}
	return (_Thrd_success);
	}

int _Mtx_current_owns(_Mtx_t *mtx)
	{	/* test if current thread owns mutex */
	return ((*mtx)->count != 0
		&& thrd_equal((*mtx)->owner, thrd_current()));
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
