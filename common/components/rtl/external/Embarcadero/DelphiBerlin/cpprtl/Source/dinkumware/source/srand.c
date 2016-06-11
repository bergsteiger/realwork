/* srand function */
#include <stdlib.h>
#include "xtls.h"
_STD_BEGIN

_C_LIB_DECL
_TLS_DATA_DECL(char, _Randinit);
_TLS_DATA_DECL(unsigned long, _Randseed);
_END_C_LIB_DECL

void (srand)(unsigned int seed)
	{	/* alter the seed */
	*_TLS_DATA_PTR(_Randinit) = 0;
	*_TLS_DATA_PTR(_Randseed) = seed;
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
