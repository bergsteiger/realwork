/* xgetglob.c -- _Getgloballocale and _Setgloballocale functions */
#include "xtls.h"
_STD_BEGIN

typedef void **global_t;

void _Deletegloballocale(void *);

_TLS_DATA_DEF_DT(static, global_t, global_locale, 0, _Deletegloballocale);

void *_Getgloballocale()
	{	/* return pointer to current locale */
	return (*_TLS_DATA_PTR(global_locale));
	}

void _Setgloballocale(void *ptr)
	{	/* alter pointer to current locale */
	*_TLS_DATA_PTR(global_locale) = (void **)ptr;
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
