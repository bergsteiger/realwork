/* _Feraise function */
#include <yvals.h>
#include <errno.h>

 #if _HAS_C9X
#include <fenv.h>
#include <math.h>

 #else /* _IS_C9X */
#include <ymath.h>
 #endif /* _IS_C9X */

_STD_BEGIN

_CRTIMP2 void (_Feraise)(int except)
	{	/* report floating-point exception */

 #if _HAS_C9X
	int errh = math_errhandling;	/* quiet diagnostics */

	if ((errh & MATH_ERREXCEPT) != 0)
		{	/* set hardware bits */
		if ((except & (_FE_OVERFLOW | _FE_UNDERFLOW)) != 0)
			except |= _FE_INEXACT;	/* IEC 60559 */
		feraiseexcept(except);
		}

	if ((errh & MATH_ERRNO) == 0)
		;
	else if ((except & (_FE_DIVBYZERO | _FE_INVALID)) != 0)
		errno = EDOM;
	else if ((except & (_FE_UNDERFLOW | _FE_OVERFLOW)) != 0)
		errno = ERANGE;

 #else /* _IS_C9X */
	if ((except & (_FE_DIVBYZERO | _FE_INVALID)) != 0)
		errno = EDOM;
	else if ((except & (_FE_UNDERFLOW | _FE_OVERFLOW)) != 0)
		errno = ERANGE;
 #endif /* _IS_C9X */

	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
