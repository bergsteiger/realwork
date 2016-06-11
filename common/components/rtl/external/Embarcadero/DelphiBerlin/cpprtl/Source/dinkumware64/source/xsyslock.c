/* xsyslock.c -- thread locking and unlocking functions */
#include "xmtx.h"
#include <stdio.h>

 #if defined(__BORLANDC__)
  #pragma warn -par
 #endif /* defined(__BORLANDC__) */

_C_LIB_DECL

 #if !_MULTI_THREAD
void (_Locksyslock)(int lockno)
	{	/* set a system lock */
	}

void (_Unlocksyslock)(int lockno)
	{	/* clear a system lock */
	}

 #else /* _MULTI_THREAD */
  #define INIT	_Once(&syslock_o, _Initlocks)
  #define TIDY	_CSTD _Atexit(&_Clearlocks)

static _Once_t syslock_o = _ONCE_T_INIT;

 #if _HAS_DINKUM_CLIB
  #define _MAX_FLOCK	FOPEN_MAX

static _Rmtx file_mtx[_MAX_FLOCK];
static int max_flock = 0;
 #endif /* _HAS_DINKUM_CLIB */

static int max_lock = 0;
static _Rmtx mtx[_MAX_LOCK];

void _CDECL _Clearlocks(void)
	{	/* clear all locks at program termination */
	int count;

 #if _HAS_DINKUM_CLIB
	max_flock = 0;

	for (count = 0; count < _MAX_FLOCK; ++count)
		_Mtxdst(&file_mtx[count]);
 #endif /* _HAS_DINKUM_CLIB */

	max_lock = 0;

	for (count = 0; count < _MAX_LOCK; ++count)
		_Mtxdst(&mtx[count]);
	}

void _CDECL _Initlocks(void)
	{	/* initialize all locks on first call to _Locksyslock */
	int count;

  #if _WIN32_C_LIB
	count = 0;
	if (count != 0)
		{	/* drag in our tolower, but don't force TLS setup */
		int (_CDECL tolower)(int);

		(tolower)('A');	/* block linking of conflicting code */
		}
  #endif /* _WIN32_C_LIB */

 #if _HAS_DINKUM_CLIB
	for (count = 0; count < _MAX_FLOCK; ++count)
		_Mtxinit(&file_mtx[count]);
	max_flock = _MAX_FLOCK;
 #endif /* _HAS_DINKUM_CLIB */

	for (count = 0; count < _MAX_LOCK; ++count)
		_Mtxinit(&mtx[count]);
	max_lock = _MAX_LOCK;

	TIDY;
	}

 #if _HAS_DINKUM_CLIB
void (_Lockfilelock)(FILE *str)
	{	/* set a file lock */
	INIT;
	if (str != 0 && str->_Idx < max_flock)
		_Mtxlock(&file_mtx[str->_Idx]);
	}

void (_Unlockfilelock)(FILE *str)
	{	/* clear a system lock */
	if (str != 0 && str->_Idx < max_flock)
		_Mtxunlock(&file_mtx[str->_Idx]);
	}
 #endif /* _HAS_DINKUM_CLIB */

void (_Locksyslock)(int lockno)
	{	/* set a system lock */
	INIT;
	if (lockno < max_lock)
		_Mtxlock(&mtx[lockno]);
	}

void (_Unlocksyslock)(int lockno)
	{	/* clear a system lock */
	if (lockno < max_lock)
		_Mtxunlock(&mtx[lockno]);
	}
 #endif /* _MULTI_THREAD */

_END_C_LIB_DECL

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
