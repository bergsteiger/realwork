/* feupdateenv function */
#include <fenv.h>
_STD_BEGIN

int (feupdateenv)(const fenv_t *penv)
	{	/* merge in stored floating-point environment */
	int except = fetestexcept(FE_ALL_EXCEPT);

	fesetenv(penv);
	feraiseexcept(except);
	return (0);
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
