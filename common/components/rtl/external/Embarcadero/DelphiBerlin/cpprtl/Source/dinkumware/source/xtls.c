/* thread-local storage support for Win32 */
#include <yvals.h>


 #if !_MULTI_THREAD || _WIN32_C_LIB && __EDG__ && !__INTEL_COMPILER

 #elif _WIN32_C_LIB
  #include <stdlib.h>
  #include "xtls.h"
  #include "wrapwin.h"
_STD_BEGIN

  #define TLS_MAX_SLOTS		50	/* adjust as necessary for library's data */
  #define WIN_TLS_BAD_KEY	0xffffffff

  #if _COMPILER_TLS
typedef void (*dtor_t)(void);

  #else /* _COMPILER_TLS */
typedef _Tlsdtor_t dtor_t;
  #endif /* _COMPILER_TLS */

typedef struct
	{	/* storage control */
	char inuse;
	dtor_t dtor;
	} tls_ctrl_t;

static tls_ctrl_t tls_ctrl[TLS_MAX_SLOTS];

static _Once_t tls_o = _ONCE_T_INIT;
static int nextkey;
static _Rmtx mtx;

static int alloc_tls(_Tlskey_t *key, dtor_t dtor)
	{	/* allocate thread-local storage slot */
	int res = 1;

	_Mtxlock(&mtx);
	while (nextkey < TLS_MAX_SLOTS && tls_ctrl[nextkey].inuse)
		++nextkey;

	if (nextkey != TLS_MAX_SLOTS)
		{	/* key slot available, allocate it */
		*key = nextkey++;
		tls_ctrl[*key].inuse = 1;
		tls_ctrl[*key].dtor = dtor;
		res = 0;
		}
	_Mtxunlock(&mtx);
	return (res);
	}

  #if _COMPILER_TLS
static void cleanup(void)
	{	/* tidy thread storage */
	_Destroytls();
	_Mtxdst(&mtx);
	}

static void init(void)
	{	/* initialize thread storage */
	_Mtxinit(&mtx);
	_Atexit(&cleanup);
	}

int _Atthreadexit(dtor_t dtor)
	{	/* register thread-exit cleanup */
	_Tlskey_t key;

	_Once(&tls_o, init);
	return (alloc_tls(&key, dtor));
	}

void _Destroytls(void)
	{	/* destroy thread storage */
	int i;

	for (i = 0; i < TLS_MAX_SLOTS; ++i)
		if (tls_ctrl[i].inuse && tls_ctrl[i].dtor)
			tls_ctrl[i].dtor();
	}

  #else /* _COMPILER_TLS */
static DWORD data_k = WIN_TLS_BAD_KEY;

static void cleanup(void)
	{	/* tidy thread storage */
	_Destroytls();
	_Mtxdst(&mtx);
	if (data_k != WIN_TLS_BAD_KEY)
		TlsFree(data_k);
	}

static void init(void)
	{	/* initialize thread storage */
	if ((data_k = TlsAlloc()) == WIN_TLS_BAD_KEY)
		abort();
	_Mtxinit(&mtx);
	_Atexit(&cleanup);
	}

static void **getTlsData(_Tlskey_t key)
	{	/* return pointer to thread storage for key */
	void **data = 0;

	if (key < 0 || TLS_MAX_SLOTS <= key)
		;
	else if ((data = TlsGetValue(data_k)) != 0)
		;
	else if ((data = (void **)calloc(TLS_MAX_SLOTS, sizeof (void *))) == 0
		|| !TlsSetValue(data_k, data))
		free(data), data = 0;
	return (data);
	}

void _Destroytls(void)
	{	/* destroy thread storage */
	int j = 0;
	int rpt = 1;
	void **data = TlsGetValue(data_k);

	if (data != 0)
		while (rpt && j++ < _TLS_DTOR_ITERATIONS)
			{	/* try several times, just in case */
			int i;

			rpt = 0;
			for (i = 0; i < TLS_MAX_SLOTS; ++i)
				if (tls_ctrl[i].inuse && tls_ctrl[i].dtor
					&& (data[i]) != 0)
					{	/* destroy a datum */
					void *tmp = data[i];

					data[i] = 0;
					tls_ctrl[i].dtor(tmp);
					rpt = 1;
					}
			}
	}

int _Tlsalloc(_Tlskey_t *key, _Tlsdtor_t dtor)
	{	/* allocate thread-local storage */
	_Once(&tls_o, init);
	return (alloc_tls(key, dtor));
	}

int _Tlsfree(_Tlskey_t key)
	{	/* free thread-local storage */
	if (key < 0 || TLS_MAX_SLOTS <= key)
		return (1);

	_Mtxlock(&mtx);
	tls_ctrl[key].inuse = 0;
	if (key < nextkey)
		nextkey = key;
	_Mtxunlock(&mtx);
	return (0);
	}

int _Tlsset(_Tlskey_t key, void *value)
	{	/* store value in thread-local storage */
	void **data = getTlsData(key);

	if (data != 0)
		{	/* store value */
		data[key] = value;
		return (0);
		}
	return (1);
	}

void *_Tlsget(_Tlskey_t key)
	{	/* get value from thread-local storage */
	void **data = getTlsData(key);

	return (data != 0 ? data[key] : 0);
	}
  #endif /* _COMPILER_TLS */

_STD_END
 #endif /* !_MULTI_THREAD etc. */

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
