/* feholdexcept function */
#include <fenv.h>

 #if _FPP_TYPE == _FPP_NONE
  #include "xtls.h"
_STD_BEGIN

_TLS_DATA_DECL(fenv_t, _Fenv);

int (feholdexcept)(fenv_t *penv)
	{	/* store and clear floating-point environment */
	fenv_t *pfenv = _TLS_DATA_PTR(_Fenv);

	*penv = *pfenv;
	pfenv->_Fe_ctl |= FE_ALL_EXCEPT << _FE_EXMASK_OFF;	/* mask all */
	pfenv->_Fe_stat &= ~FE_ALL_EXCEPT << _FE_EXCEPT_OFF;	/* clear all */

	return (0);
	}
_STD_END

 #else /* _FPP_TYPE == _FPP_NONE */
_STD_BEGIN

int (feholdexcept)(fenv_t *penv)
	{	/* store and clear floating-point environment */
	fenv_t env;

	fegetenv(&env);

  #if _FPP_TYPE == _FPP_X86 || _FPP_TYPE == _FPP_WCE
	*penv = env;
	env._Fe_ctl |= (FE_ALL_EXCEPT << _FE_EXMASK_OFF);	/* mask all */
	env._Fe_stat &= ~(FE_ALL_EXCEPT << _FE_EXCEPT_OFF);	/* clear all */
	fesetenv(&env);

  #elif _FPP_TYPE == _FPP_SPARC || _FPP_TYPE == _FPP_MIPS \
	|| _FPP_TYPE == _FPP_S390 || _FPP_TYPE == _FPP_PPC \
	|| _FPP_TYPE == _FPP_ARM || _FPP_TYPE == _FPP_SH4
	*penv = env;

   #if defined(FE_EXLAST_OFF)
	*penv &= ~((FE_ALL_EXCEPT << _FE_EXCEPT_OFF)
		| (FE_ALL_EXCEPT << _FE_EXLAST_OFF)
		| (FE_ALL_EXCEPT << _FE_EXMASK_OFF));	/* mask/clear all */

   #else /* defined(FE_EXLAST_OFF) */
	*penv &= ~((FE_ALL_EXCEPT << _FE_EXCEPT_OFF)
		| (FE_ALL_EXCEPT << _FE_EXMASK_OFF));	/* mask/clear all */
   #endif /* defined(FE_EXLAST_OFF) */

	fesetenv(&env);

  #elif _FPP_TYPE == _FPP_HPPA
	*penv = env;
	env._Fe_stat &= ~((FE_ALL_EXCEPT << _FE_EXCEPT_OFF)
		| (FE_ALL_EXCEPT << _FE_EXMASK_OFF));	/* mask/clear all */
	fesetenv(&env);

  #elif _FPP_TYPE == _FPP_ALPHA
	*penv = env;
	env &= ~(FE_ALL_EXCEPT << _FE_EXCEPT_OFF);	/* clear all */
	env |= _FE_ALL_ENABLE << _FE_EXMASK_OFF;	/* mask all */
	fesetenv(&env);

  #elif _FPP_TYPE == _FPP_M68K
	*penv = env;
	env._Fe_ctl &= ~(0xc100
		| (FE_ALL_EXCEPT << _FE_EXMASK_OFF));	/* mask all */
	env._Fe_stat &= ~((FE_ALL_EXCEPT << _FE_EXCEPT_OFF)
		| (FE_ALL_EXCEPT << _FE_EXLAST_OFF));	/* clear all */
	fesetenv(&env);

  #elif _FPP_TYPE == _FPP_IA64
	*penv = env;
	env &= ~(FE_ALL_EXCEPT << _FE_EXCEPT_OFF);	/* clear all */
	env |= FE_ALL_EXCEPT << _FE_EXMASK_OFF;	/* mask all */
	fesetenv(&env);

  #else /* _FPP_TYPE */
   #error unknown FPP type
  #endif /* _FPP_TYPE */

	return (0);
	}
_STD_END
 #endif /* _FPP_TYPE == _FPP_NONE */

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
