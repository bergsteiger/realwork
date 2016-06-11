/* _Feraise function */
#include <yvals.h>
#include <errno.h>

 #if _HAS_C9X
#include <fenv.h>
#include <math.h>

 #else /* _HAS_C9X */
#include <ymath.h>
 #endif /* _IS_C9X */

_C_LIB_DECL

 #if defined(__OXILI_CLRUNTIME)	/* compiler test */
void (_CDECL _Feraise)(int except)
	{	/* do nothing */
	}

 #else /* defined(__OXILI_CLRUNTIME) */
void (_CDECL _Feraise)(int except)
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
	else if ((except & _FE_INVALID) != 0)
		errno = EDOM;
	else if ((except & (_FE_DIVBYZERO | _FE_UNDERFLOW | _FE_OVERFLOW)) != 0)
		errno = ERANGE;

 #else /* _HAS_C9X */
	if ((except & (_FE_DIVBYZERO | _FE_INVALID)) != 0)
		errno = EDOM;
	else if ((except & (_FE_UNDERFLOW | _FE_OVERFLOW)) != 0)
		errno = ERANGE;
 #endif /* _IS_C9X */
	}
 #endif /* defined(__OXILI_CLRUNTIME) */

_END_C_LIB_DECL

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
