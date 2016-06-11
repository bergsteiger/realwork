/* fegettrapenable function */
#include <fenv.h>

 #if _FPP_TYPE == _FPP_NONE
  #include "xtls.h"
_STD_BEGIN

_TLS_DATA_DECL(fenv_t, _Fenv);

fexcept_t (fegettrapenable)(void)
	{	/* get exception enable mask */
	fenv_t *pfenv = _TLS_DATA_PTR(_Fenv);

	return (~(pfenv->_Fe_ctl >> _FE_EXMASK_OFF) & FE_ALL_EXCEPT);
	}
_STD_END

 #else /* _FPP_TYPE == _FPP_NONE */
_STD_BEGIN

fexcept_t (fegettrapenable)(void)
	{	/* store and clear floating-point environment */

  #if _FPP_TYPE == _FPP_X86 || _FPP_TYPE == _FPP_WCE
	fexcept_t control;

	_Fegetctl(&control);
	return (~(control >> _FE_EXMASK_OFF) & FE_ALL_EXCEPT);

  #elif _FPP_TYPE == _FPP_SPARC || _FPP_TYPE == _FPP_MIPS \
	|| _FPP_TYPE == _FPP_S390 || _FPP_TYPE == _FPP_PPC \
	|| _FPP_TYPE == _FPP_ARM || _FPP_TYPE == _FPP_SH4
	fenv_t env;

	fegetenv(&env);
	return ((env >> _FE_EXMASK_OFF) & FE_ALL_EXCEPT);

  #elif _FPP_TYPE == _FPP_HPPA
	return ((_Fegetstat() >> _FE_EXMASK_OFF) & FE_ALL_EXCEPT);

  #elif _FPP_TYPE == _FPP_ALPHA
	fenv_t env;

	fegetenv(&env);
	return (_Fegettrapenable(env));

 #elif _FPP_TYPE == _FPP_M68K
	fenv_t env;

	fegetenv(&env);
	return ((env._Fe_ctl >> _FE_EXMASK_OFF) & FE_ALL_EXCEPT);

  #elif _FPP_TYPE == _FPP_IA64
	fenv_t env;

	fegetenv(&env);
	return (~(env >> _FE_EXMASK_OFF) & FE_ALL_EXCEPT);

  #else /* _FPP_TYPE */
   #error unknown FPP type
  #endif /* _FPP_TYPE */

	}
_STD_END
 #endif /* _FPP_TYPE == _FPP_NONE */

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
