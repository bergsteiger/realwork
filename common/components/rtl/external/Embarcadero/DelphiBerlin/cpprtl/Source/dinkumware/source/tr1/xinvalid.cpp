// xinvalid: throw exception from TR1 random number generators
#include <stdexcept>

 #if _HAS_TR1
  #include <random>

_STD_BEGIN
	namespace tr1 {	// TR1 additions

void _CRTIMP2 _Xinvalid(const char *_Msg)
	{	// throw invalid_argument exception
	_THROW(invalid_argument, _Msg);
	}

	}	// namespace tr1
_STD_END
 #endif /* _HAS_TR1 */

/*
 * Copyright (c) 1992-2008 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
