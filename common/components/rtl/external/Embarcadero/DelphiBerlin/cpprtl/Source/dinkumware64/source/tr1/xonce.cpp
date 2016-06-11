/* xonce.cpp -- _Execute_once function */
#include <mutex>

_STD_BEGIN
_CRTIMP2P int _PCDECL _Execute_once(
	once_flag& _Flag, _Lambda_fp_t _Lambda_fp, void *_Pv) _NOEXCEPT
	{	// wrap Win32 InitOnceExecuteOnce()
	_BEGIN_LOCK(_LOCK_CALL_ONCEEX)
		if (_Flag._Opaque == 0)
			{	/* call func(arg) and mark as called */
			_Lambda_fp(0, _Pv, 0);
			_Flag._Opaque = &_Flag;
			}
	_END_LOCK()
	return (1);
	}
_STD_END

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
