//	xmutex.cpp -- implement mutex lock for iostreams
#include <yvals.h>

 #if _MULTI_THREAD && _IOSTREAM_OP_LOCKS
  #include "xmtx.h"
_STD_BEGIN
_Mutex::_Mutex()
	: _Mtx(new _Rmtx)
	{	// initialize recursive mutex object
	_Mtxinit((_Rmtx*)_Mtx);
	}

_Mutex::~_Mutex() _NOEXCEPT
	{	// release resources allocated to mutex object
	_Mtxdst((_Rmtx*)_Mtx);
	delete (_Rmtx*)_Mtx;
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

 #else	/* _MULTI_THREAD etc. */

int _Xmutex_cpp_unused = 0;
 #endif	/* _MULTI_THREAD etc. */

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
