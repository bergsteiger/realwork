/* xnotify.c -- thread exit notification functions */
#include <Dinkum/threads/xthreads.h>
#include <stdlib.h>

#define NITEMS	20

typedef struct
	{	/* data for condition-variable slot */
	_Thrd_t id;
	_Mtx_t _THR_INDIR mtx;
	_Cnd_t _THR_INDIR cnd;
	int *res;
	} at_thread_exit_data;

typedef struct at_thread_exit_block
	{	/* block of condition-variable slots */
	at_thread_exit_data data[NITEMS];
	int num_used;
	struct at_thread_exit_block *next;
	} at_thread_exit_block;

static at_thread_exit_block thread_exit_data;

static _Mtx_t at_thread_exit_mutex;
static _Once_flag at_thread_exit_flag = _ONCE_FLAG_INIT;

static void destroy_at_thread_exit_mutex(void)
	{	/* destroy local mutex */
	_Mtx_destroy(_THR_ADDR at_thread_exit_mutex);
	}

static void init_at_thread_exit_mutex(void)
	{	/* initialize local mutex */
	if (_Mtx_init(&at_thread_exit_mutex, _Mtx_plain) != _Thrd_success)
		abort();
	atexit(destroy_at_thread_exit_mutex);
	}

_EXTERN_C void _Lock_at_thread_exit_mutex(void)
	{ // lock the at-thread-exit mutex
	_Call_once(&at_thread_exit_flag, init_at_thread_exit_mutex);
	_Mtx_lock(_THR_ADDR at_thread_exit_mutex);
	}

_EXTERN_C void _Unlock_at_thread_exit_mutex(void)
	{ // unlock the at-thread-exit mutex
	_Mtx_unlock(_THR_ADDR at_thread_exit_mutex);
	}

void _Cnd_register_at_thread_exit(_Cnd_t _THR_INDIR cnd,
	_Mtx_t _THR_INDIR mtx, int *p)
	{	/* register condition variable and mutex for cleanup at thread exit */
	/* find block with available space */
	at_thread_exit_block *block = &thread_exit_data;

	_Lock_at_thread_exit_mutex();
	while (block != 0)
		{	/* loop through list of blocks */
		if (block->num_used == NITEMS)
			{	/* block is full; move to next block and allocate */
			if (block->next == 0)
				block->next = (at_thread_exit_block *)calloc(1,
					sizeof (at_thread_exit_block));
			block = block->next;
			}
		else
			{	/* found block with available space */
			int i;

			for (i = 0; i < NITEMS; ++i)
				{	/* find empty slot */
				if (block->data[i].mtx == 0)
					{	/* store into empty slot */
					block->data[i].id = _Thrd_current();
					block->data[i].mtx = mtx;
					block->data[i].cnd = cnd;
					block->data[i].res = p;
					++block->num_used;
					break;
					}
				}
			block = 0;
			}
		}
	_Unlock_at_thread_exit_mutex();
	}

void _Cnd_unregister_at_thread_exit(_Mtx_t _THR_INDIR mtx)
	{	/* unregister condition variable/mutex for cleanup at thread exit */
	/* find condition variables waiting for this thread to exit */
	at_thread_exit_block *block = &thread_exit_data;

	_Lock_at_thread_exit_mutex();
	while (block != 0)
		{	/* loop through list of blocks */
		int i;
		for (i = 0; block->num_used != 0 && i < NITEMS; ++i)
			if (block->data[i].mtx == mtx)
				{	/* release slot */
				block->data[i].mtx = 0;
				--block->num_used;
				}
		block = block->next;
		}
	_Unlock_at_thread_exit_mutex();
	}

void _Cnd_do_broadcast_at_thread_exit(void)
	{	/* notify condition variables waiting for this thread to exit */
	/* find condition variables waiting for this thread to exit */
	at_thread_exit_block *block = &thread_exit_data;
	_Thrd_t cur_thr;

	_Lock_at_thread_exit_mutex();
	cur_thr = _Thrd_current();
	while (block != 0)
		{	/* loop through list of blocks */
		int i;
		for (i = 0; block->num_used != 0 && i < NITEMS; ++i)
			if (block->data[i].mtx != 0
				&& _Thrd_equal(block->data[i].id, cur_thr))
				{	/* notify and release slot */
				if (block->data[i].res)
					*block->data[i].res = 1;
				_Mtx_unlock(block->data[i].mtx);
				_Cnd_broadcast(block->data[i].cnd);
				block->data[i].mtx = 0;
				--block->num_used;
				}
		block = block->next;
		}
	_Unlock_at_thread_exit_mutex();
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
