/* _Fltrounds function */
#include <float.h>

 #if _HAS_C9X
#include <fenv.h>
_STD_BEGIN

int (_Fltrounds)(void)
	{	/* report floating-point rounding mode */
	switch (fegetround())
		{	/* map hardware rounding mode to FLT_ROUNDS value */
	case FE_TOWARDZERO:
		return (0);

	case FE_TONEAREST:
		return (1);

	case FE_UPWARD:
		return (2);

	case FE_DOWNWARD:
		return (3);

	default:
		return (-1);	/* indeterminate */
		}
	}
_STD_END

 #else /* _IS_C9X */
_STD_BEGIN

int (_Fltrounds)(void)
	{	/* report floating-point rounding mode */
	return (1);	/* assume tonearest */
	}
_STD_END
 #endif /* _IS_C9X */

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
