// exception handling support functions
#include <new>
#include <stdexcept>
#include <atomic>

_STD_BEGIN
_CRTIMP2P _NO_RET(_PCDECL _Xbad_alloc())
	{	// report a bad_alloc error
	_THROW_N(_XSTD bad_alloc, 0);
	}

_CRTIMP2P _NO_RET(_PCDECL _Xinvalid_argument(const char *_Message))
	{	// report an invalid_argument error
	_THROW_N(invalid_argument, _Message);
	}

_CRTIMP2P _NO_RET(_PCDECL _Xlength_error(const char *_Message))
	{	// report a length_error
	_THROW_N(length_error, _Message);
	}

_CRTIMP2P _NO_RET(_PCDECL _Xout_of_range(const char *_Message))
	{	// report an out_of_range error
	_THROW_N(out_of_range, _Message);
	}

_CRTIMP2P _NO_RET(_PCDECL _Xoverflow_error(const char *_Message))
	{	// report an overflow error
	_THROW_N(overflow_error, _Message);
	}

_CRTIMP2P _NO_RET(_PCDECL _Xruntime_error(const char *_Message))
	{	// report a runtime_error
	_THROW_N(runtime_error, _Message);
	}
_STD_END

 #if _HAS_TR1
 #include <functional>

_STD_BEGIN
_CRTIMP2P _NO_RET(_PCDECL _Xbad_function_call())
	{	// report a bad_function_call error
	_THROW_N(bad_function_call, _EMPTY_ARGUMENT);
	}
_STD_END

 #if _HAS_EXCEPTIONS

 #if (__EDG__ && 0 < _MSC_VER) || defined(__CODEGEARC__)	/* compiler test */
  #define _REGEX_BUILD	1	/* suppress further _Names definition */
 #endif /* __EDG__ etc. */

 #include <regex>

_STD_BEGIN
_CRTIMP2P _NO_RET(_PCDECL _Xregex_error(regex_constants::error_type _Code))
	{	// report a regex_error
	_THROW_N(regex_error, _Code);
	}
_STD_END
 #endif /* _HAS_EXCEPTIONS */

 #endif /* _HAS_TR1 */

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
