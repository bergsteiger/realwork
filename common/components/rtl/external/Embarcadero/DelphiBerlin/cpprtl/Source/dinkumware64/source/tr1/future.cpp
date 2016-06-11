// future.cpp -- future static objects
#include <yvals.h>
#include <cstdlib>

 #if _HAS_CPP0X
 #include <future>
 #include <exception>
_STD_BEGIN

_CRTIMP2P _NO_RET(_PCDECL _Throw_future_error(const error_code& _Code))
	{	// throw an exception
	_THROW_N(future_error, _Code);
	}

_CRTIMP2P _NO_RET(_PCDECL _Rethrow_future_exception(
	_XSTD exception_ptr))
	{	// rethrow an exception
	_THROW_N(_STD runtime_error, "unknown exception");
	}
_STD_END
 #else /* _HAS_CPP0X */
 #endif /* _HAS_CPP0X */

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
