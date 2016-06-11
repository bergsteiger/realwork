/* fesettrapenable function */
#include <fenv.h>

 #if _FPP_TYPE == _FPP_NONE
  #include "xtls.h"
_STD_BEGIN

_TLS_DATA_DECL(fenv_t, _Fenv);

int (fesettrapenable)(fexcept_t enable)
	{	/* set exception enable mask */
	fenv_t *pfenv = _TLS_DATA_PTR(_Fenv);

	if ((enable & FE_ALL_EXCEPT) != enable)
		return (1);
	else
		{	/* valid mask, set it */
		pfenv->_Fe_ctl = pfenv->_Fe_ctl & ~(FE_ALL_EXCEPT << _FE_EXMASK_OFF)
			| ((~enable & FE_ALL_EXCEPT) << _FE_EXMASK_OFF);
		return (0);
		}
	}
_STD_END

 #else /* _FPP_TYPE == _FPP_NONE */
_STD_BEGIN

int (fesettrapenable)(fexcept_t enable)
	{	/* store and clear floating-point environment */
	if ((enable & FE_ALL_EXCEPT) != enable)
		return (1);
	else
		{	/* valid mask, set it */

  #if _FPP_TYPE == _FPP_X86 || _FPP_TYPE == _FPP_WCE
		fexcept_t control;

		_Fegetctl(&control);
		control = control & ~(FE_ALL_EXCEPT << _FE_EXMASK_OFF)
			| ((~enable & FE_ALL_EXCEPT) << _FE_EXMASK_OFF);
		_Fesetctl(&control);

  #elif _FPP_TYPE == _FPP_SPARC || _FPP_TYPE == _FPP_MIPS \
	|| _FPP_TYPE == _FPP_S390 || _FPP_TYPE == _FPP_PPC \
	|| _FPP_TYPE == _FPP_ARM || _FPP_TYPE == _FPP_SH4
		fenv_t env;

		fegetenv(&env);
		env = env & ~(FE_ALL_EXCEPT << _FE_EXMASK_OFF)
			| ((enable & FE_ALL_EXCEPT) << _FE_EXMASK_OFF);
		fesetenv(&env);

  #elif _FPP_TYPE == _FPP_HPPA
		_Fesetstat(enable << _FE_EXMASK_OFF,
			FE_ALL_EXCEPT << _FE_EXMASK_OFF);

  #elif _FPP_TYPE == _FPP_ALPHA
		fenv_t env;

		fegetenv(&env);
		if ((enable & FE_INEXACT) != 0)
			enable |= FE_INEXACT << 10;
		if ((enable & FE_UNDERFLOW) != 0)
			enable |= FE_UNDERFLOW << 10;
		env = env & ~(_FE_ALL_ENABLE << _FE_EXMASK_OFF)
			| ((~enable & _FE_ALL_ENABLE) << _FE_EXMASK_OFF);
		fesetenv(&env);

 #elif _FPP_TYPE == _FPP_M68K
		fenv_t env;

		fegetenv(&env);
		env._Fe_ctl = env._Fe_ctl & ~(FE_ALL_EXCEPT << _FE_EXMASK_OFF)
			| ((enable & FE_ALL_EXCEPT) << _FE_EXMASK_OFF);
		fesetenv(&env);

  #elif _FPP_TYPE == _FPP_IA64
		fenv_t env;

		fegetenv(&env);
		env = env & ~(FE_ALL_EXCEPT << _FE_EXMASK_OFF)
			| ((~enable & FE_ALL_EXCEPT) << _FE_EXMASK_OFF);
		fesetenv(&env);

  #else /* _FPP_TYPE */
   #error unknown FPP type
  #endif /* _FPP_TYPE */

		return (0);
		}
	}
_STD_END
 #endif /* _FPP_TYPE == _FPP_NONE */

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
