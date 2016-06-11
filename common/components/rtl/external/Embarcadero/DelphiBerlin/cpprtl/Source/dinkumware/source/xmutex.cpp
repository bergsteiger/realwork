//	xmutex.cpp -- implement mutex lock for iostreams
#include <xdebug>
#include <yvals.h>

 #if _MULTI_THREAD && _IOSTREAM_OP_LOCKS
  #include "xmtx.h"
_STD_BEGIN

_Mutex::_Mutex()
	: _Mtx(_NEW_CRT _Rmtx)
	{	// initialize recursive mutex object
	_Mtxinit((_Rmtx*)_Mtx);
	}

_Mutex::~_Mutex()
	{	// release resources allocated to mutex object
	_Mtxdst((_Rmtx*)_Mtx);
	_DELETE_CRT((_Rmtx*)_Mtx);
	}

void _Mutex::_Lock()
	{	// lock mutex
	_Mtxlock((_Rmtx*)_Mtx);
	}

void _Mutex::_Unlock()
	{	// unlock mutex
	_Mtxunlock((_Rmtx*)_Mtx);
	}
_STD_END
 #endif	/* _MULTI_THREAD */

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
