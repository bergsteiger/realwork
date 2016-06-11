/* fesetexceptflag function */
#include <fenv.h>

 #if _FPP_TYPE == _FPP_NONE
  #include "xtls.h"
_STD_BEGIN

_TLS_DATA_DECL(fenv_t, _Fenv);

int (fesetexceptflag)(const fexcept_t *pflags, int except)
	{	/* load selected exception sticky bits */
	if ((except &= FE_ALL_EXCEPT) != 0)
		{	/* load selected bits */
		fexcept_t mask = *pflags & except;
		fenv_t *p = _TLS_DATA_PTR(_Fenv);

		p->_Fe_stat &= ~except << _FE_EXCEPT_OFF;
		p->_Fe_stat |= mask << _FE_EXCEPT_OFF;
		}
	return (0);
	}
_STD_END

 #else /* _FPP_TYPE == _FPP_NONE */
_STD_BEGIN

int (fesetexceptflag)(const fexcept_t *pflags, int except)
	{	/* load selected exception sticky bits */
	if ((except &= FE_ALL_EXCEPT) != 0)
		{	/* load selected bits */
		fexcept_t mask = *pflags & except;

  #if _FPP_TYPE == _FPP_X86 || _FPP_TYPE == _FPP_WCE
		fenv_t env;

		fegetenv(&env);
		env._Fe_stat &= ~except << _FE_EXCEPT_OFF;
		env._Fe_stat |= mask << _FE_EXCEPT_OFF;
		fesetenv(&env);

  #elif _FPP_TYPE == _FPP_SPARC || _FPP_TYPE == _FPP_MIPS \
	|| _FPP_TYPE == _FPP_S390 || _FPP_TYPE == _FPP_PPC \
	|| _FPP_TYPE == _FPP_ALPHA || _FPP_TYPE == _FPP_ARM \
	|| _FPP_TYPE == _FPP_SH4 || _FPP_TYPE == _FPP_IA64
		fenv_t env;

		fegetenv(&env);
		env &= ~except << _FE_EXCEPT_OFF;
		env |= mask << _FE_EXCEPT_OFF;
		fesetenv(&env);

  #elif _FPP_TYPE == _FPP_HPPA || _FPP_TYPE == _FPP_M68K
		_Fesetstat(except << _FE_EXCEPT_OFF,
			mask << _FE_EXCEPT_OFF);

  #else /* _FPP_TYPE */
   #error unknown FPP type
  #endif /* _FPP_TYPE */

		}
	return (0);
	}
_STD_END
 #endif /* _FPP_TYPE == _FPP_NONE */

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
