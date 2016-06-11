/* tss.c -- thread specific storage support */
#include <Dinkum/threads/xthrcommon.h>
#include <Dinkum/threads/xthreads.h>

 #if _THREAD_EMULATE_TSS
 #if _WIN32_C_LIB
#include <wrapwin.h>

  #define OUT_OF_INDEXES	0xffffffff
  #define TSS_ALLOC	TlsAlloc()
  #define TSS_FREE	TlsFree
  #define TSS_GET	TlsGetValue
  #define TSS_SET	TlsSetValue

typedef DWORD sys_key_t;

static int sys_tss_create(sys_key_t *key)
	{	/* create TSS */
	return ((*key = TSS_ALLOC) == OUT_OF_INDEXES
		? _Thrd_error : _Thrd_success);
	}

static int sys_tss_destroy(sys_key_t key)
	{	/* destroy TSS */
	return (TSS_FREE(key) == 0
		? _Thrd_error : _Thrd_success);
	}

static void **sys_tss_get(sys_key_t key)
	{	/* get TSS pointer */
	return ((void **)TSS_GET(key));
	}

static int sys_tss_set(sys_key_t key, const void *value)
	{	/* set TSS value */
	return (TSS_SET(key, (void *)value) == 0
		? _Thrd_error : _Thrd_success);
	}

 #elif _HAS_POSIX_C_LIB
#include <pthread.h>

typedef pthread_key_t sys_key_t;

static int sys_tss_create(sys_key_t *key)
	{	/* create TSS */
	return (pthread_key_create(key, 0) != 0
		? _Thrd_error : _Thrd_success);
	}

static int sys_tss_destroy(sys_key_t key)
	{	/* destroy TSS */
	return (pthread_key_delete(key)
		? _Thrd_error : _Thrd_success);
	}

static void **sys_tss_get(sys_key_t key)
	{	/* get TSS pointer */
	return ((void **)pthread_getspecific(key));
	}

static int sys_tss_set(sys_key_t key, const void *value)
	{	/* set TSS value */
	return (pthread_setspecific(key, value)
		? _Thrd_error : _Thrd_success);
	}

 #else /* library type */
  #error Unknown platform
 #endif /* library type */

 #include <stddef.h>
 #include <stdlib.h>

#define TSS_MAX_SLOTS	50	/* adjust as necessary */

typedef struct
	{	/* storage control */
	char inuse;
	_Tss_dtor_t dtor;
	} tss_ctrl_t;

static tss_ctrl_t tss_ctrl[TSS_MAX_SLOTS];

static _Once_flag tss_o = _ONCE_FLAG_INIT;
static int nextkey;
static _Mtx_t mtx;

static sys_key_t data_k;
static int initialized = 0;
static _Tss_t min_key = 0;

static void cleanup(void)
	{	/* tidy thread storage */
	_Tss_destroy();
	_Mtx_destroy(_THR_ADDR mtx);
	if (initialized)
		sys_tss_destroy(data_k);
	}

static void init(void)
	{	/* initialize thread storage */
	if (sys_tss_create(&data_k) != _Thrd_success
		|| _Mtx_init(&mtx, _Mtx_plain) != _Thrd_success
		|| atexit(&cleanup) != 0)
		abort();
	initialized = 1;
	}

static void **getTssData(_Tss_t key)
	{	/* return pointer to thread storage for key */
	void **data = 0;
	if (key < min_key || TSS_MAX_SLOTS <= key)
		;
	else if ((data = sys_tss_get(data_k)) != 0)
		;
	else if ((data = (void **)calloc(TSS_MAX_SLOTS, sizeof (void *))) == 0
		|| sys_tss_set(data_k, data) != _Thrd_success)
		free(data), data = 0;
	return (data);
	}

static int alloc_tss(_Tss_t *key, _Tss_dtor_t dtor)
	{	/* allocate thread-local storage slot */
	int res = _Thrd_error;
	if (_Mtx_lock(_THR_ADDR mtx) != _Thrd_success)
		return (res);
	while (nextkey < TSS_MAX_SLOTS && tss_ctrl[nextkey].inuse)
		++nextkey;
	if (nextkey != TSS_MAX_SLOTS)
		{	/* key slot available, allocate it */
		*key = nextkey++;
		tss_ctrl[*key].inuse = 1;
		tss_ctrl[*key].dtor = dtor;
		res = _Thrd_success;
		}
	if (_Mtx_unlock(_THR_ADDR mtx) != _Thrd_success)
		res = _Thrd_error;
	return (res);
	}

void _Tss_destroy(void)
	{	/* destroy thread storage */
	int j = 0;
	int rpt = 1;
	void **data = sys_tss_get(data_k);
	if (data == 0)
		return;
	while (rpt && j++ < _TSS_DTOR_ITERATIONS)
		{	/* try several times, just in case */
		int i;
		rpt = 0;
		for (i = 0; i < TSS_MAX_SLOTS; ++i)
			if (tss_ctrl[i].inuse && tss_ctrl[i].dtor
				&& (data[i]) != 0)
				{	/* destroy a datum */
				void *tmp = data[i];
				data[i] = 0;
				tss_ctrl[i].dtor(tmp);
				rpt = 1;
				}
		}
	}

int _Tss_create(_Tss_t *key, _Tss_dtor_t dtor)
	{	/* allocate thread-local storage */
	_Call_once(&tss_o, init);
	return (alloc_tss(key, dtor));
	}

int _Tss_delete(_Tss_t key)
	{	/* free thread-local storage */
	if (key < min_key || TSS_MAX_SLOTS <= key)
		return (_Thrd_error);
	if (_Mtx_lock(_THR_ADDR mtx) != _Thrd_success)
		return (_Thrd_error);
	tss_ctrl[key].inuse = 0;
	if (key < nextkey)
		nextkey = key;
	if (_Mtx_unlock(_THR_ADDR mtx) != _Thrd_success)
		return (_Thrd_error);
	return (_Thrd_success);
	}

int _Tss_set(_Tss_t key, void *value)
	{	/* store value in thread-local storage */
	void **data = getTssData(key);
	if (data != 0)
		{	/* store value */
		data[key] = value;
		return (_Thrd_success);
		}
	return (_Thrd_error);
	}

void *_Tss_get(_Tss_t key)
	{	/* get value from thread-local storage */
	void **data = getTssData(key);
	return (data != 0 ? data[key] : 0);
	}

 #elif _HAS_POSIX_C_LIB

int (_Tss_create)(_Tss_t *key, _Tss_dtor_t dtor)
	{	/* allocate thread-local storage */
	return (pthread_key_create(key, dtor));
	}

int (_Tss_delete)(_Tss_t key)
	{	/* free thread-local storage */
	return (pthread_key_delete(key));
	}

int (_Tss_set)(_Tss_t key, void *value)
	{	/* store value in thread-local storage */
	return (pthread_setspecific(key, value));
	}

void *(_Tss_get)(_Tss_t key)
	{	/* get value from thread-local storage */
	return (pthread_getspecific(key));
	}
 #endif	/* _THREAD_EMULATE_TSS */

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
