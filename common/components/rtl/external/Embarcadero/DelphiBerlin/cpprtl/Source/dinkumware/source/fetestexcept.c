/* fetestexcept function */
#include <fenv.h>
_STD_BEGIN

int (fetestexcept)(int except)
	{	/* test exception sticky bits */
	fexcept_t status;

	fegetexceptflag(&status, except);
	return (status);
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
