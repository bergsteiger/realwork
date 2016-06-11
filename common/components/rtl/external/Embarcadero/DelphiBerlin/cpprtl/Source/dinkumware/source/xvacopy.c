/* _Vacopy function */
#include <stdarg.h>
#include <string.h>
_STD_BEGIN

void _Vacopy(va_list *pap, va_list ap)
	{	/* copy ap to *pap */
	static const size_t vasize = sizeof (va_list);	/* quiet diagnostic */

	if (vasize != sizeof (ap))
		memcpy(pap, ap, sizeof (va_list));	/* ASSUMES array element > ptr */
	else
		memcpy(pap, &ap, sizeof (va_list));
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
