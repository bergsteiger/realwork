/* feraiseexcept function */
#include <fenv.h>

 #if defined(_FE_AUTO_RAISE)
  #define _Force_raise(x)	/* nothing to do */
 #endif /* defined(_FE_AUTO_RAISE) */

 #if _FPP_TYPE == _FPP_NONE
  #include <signal.h>
  #include "xtls.h"
_STD_BEGIN

_TLS_DEFINE_INIT(_IMPLICIT_EXTERN, fenv_t, _Fenv) = {
	(FE_TONEAREST << _FE_RND_OFF) | FE_ALL_EXCEPT, 0
	};
_TLS_DEFINE_NO_INIT(_IMPLICIT_EXTERN, fenv_t, _Fenv);

int (feraiseexcept)(int except)
	{	/* report floating-point exception */
	if ((except &= FE_ALL_EXCEPT) != 0)
		{	/* raise one or more exceptions */
		fenv_t *pfenv = _TLS_DATA_PTR(_Fenv);	/* no FPP */

		pfenv->_Fe_stat |= except << _FE_EXCEPT_OFF;
		if (((except << _FE_EXMASK_OFF) & ~pfenv->_Fe_ctl) != 0)
			raise(SIGFPE);	/* raise unmasked exceptions */
		}
	return (0);
	}
_STD_END

 #elif _FPP_TYPE == _FPP_X86 || _FPP_TYPE == _FPP_WCE
_STD_BEGIN

int (feraiseexcept)(int except)
	{	/* report floating-point exception */
	if ((except &= FE_ALL_EXCEPT) != 0)
		{	/* raise one or more exceptions */
		fenv_t env;

		fegetenv(&env);
		env._Fe_stat |= except << _FE_EXCEPT_OFF;
		fesetenv(&env);
		}
	return (0);
	}
_STD_END

 #elif _FPP_TYPE == _FPP_SPARC || _FPP_TYPE == _FPP_MIPS \
	|| _FPP_TYPE == _FPP_S390 || _FPP_TYPE == _FPP_PPC \
	|| _FPP_TYPE == _FPP_ARM || _FPP_TYPE == _FPP_SH4 \
	|| _FPP_TYPE == _FPP_IA64
_STD_BEGIN

int (feraiseexcept)(int except)
	{	/* report floating-point exception */
	if ((except &= FE_ALL_EXCEPT) != 0)
		{	/* raise one or more exceptions */
		fenv_t env;

		fegetenv(&env);

  #if defined(_FE_EXLAST_OFF)
		env |= (except << _FE_EXCEPT_OFF)
			| (except << _FE_EXLAST_OFF);

  #else /* defined(_FE_EXLAST_OFF) */
		env |= except << _FE_EXCEPT_OFF;
  #endif /* defined(_FE_EXLAST_OFF) */

		fesetenv(&env);
		if ((except &= (env >> _FE_EXMASK_OFF)) != 0)
			_Force_raise(except);
		}
	return (0);
	}
_STD_END

 #elif _FPP_TYPE == _FPP_HPPA
_STD_BEGIN

fexcept_t _Fegetstat(void)
	{	/* get status word */
	fexcept_t csr[2];

	__asm__("fstd	%%fr0,0(%1)" : "=m" (*csr) : "r" (csr));
	return (csr[0]);
	}

fexcept_t _Fesetstat(fexcept_t control, fexcept_t mask)
	{	/* set status word */
	fexcept_t csr[2];

	__asm__("fstd	%%fr0,0(%1)" : "=m" (*csr) : "r" (csr));
	csr[0] = csr[0] & ~mask | control;
	__asm__("fldd	0(%0),%%fr0" : :  "r" (csr));
	return (csr[0]);
	}

int (feraiseexcept)(int except)
	{	/* report floating-point exception */
	if ((except &= FE_ALL_EXCEPT) != 0
		&& (except &= _Fesetstat(except << _FE_EXCEPT_OFF,
			FE_ALL_EXCEPT << _FE_EXCEPT_OFF)) != 0)
		_Force_raise(except);
	return (0);
	}
_STD_END

 #elif _FPP_TYPE == _FPP_ALPHA
_STD_BEGIN

fexcept_t _Fegettrapenable(fenv_t env)
	{	/* pack enable flags */
	env >>= _FE_EXMASK_OFF;
	if ((env & (FE_INEXACT << 10)) != 0)
		env |= FE_INEXACT;
	if ((env & (FE_UNDERFLOW << 10)) != 0)
		env |= FE_UNDERFLOW;
	return (env & FE_ALL_EXCEPT);
	}

int (feraiseexcept)(int except)
	{	/* report floating-point exception */
	if ((except &= FE_ALL_EXCEPT) != 0)
		{	/* raise one or more exceptions */
		fenv_t env;

		fegetenv(&env);
		env |= except << _FE_EXCEPT_OFF;
		fesetenv(&env);

		if ((except &= _Fegettrapenable(env)) != 0)
			_Force_raise(except);
		}
	return (0);
	}
_STD_END

 #elif _FPP_TYPE == _FPP_M68K
_STD_BEGIN

fexcept_t _Fegetstat(void)
	{	/* get status word */
	fexcept_t status;

	__asm__("fmove%.l	%/fpsr,%0" : "=dm" (status));
	return (status);
	}

fexcept_t _Fesetstat(fexcept_t control, fexcept_t mask)
	{	/* set status word */
	fexcept_t status;

	__asm__("fmove%.l	%/fpsr,%0" : "=dm" (status));
	status = status & ~mask | control;
	__asm__("fmove%.l	%0,%/fpsr" : : "dm" (status));
	return (status);
	}

int (feraiseexcept)(int except)
	{	/* report floating-point exception */
	if ((except &= FE_ALL_EXCEPT) != 0
		&& (except &= _Fesetstat(except << _FE_EXCEPT_OFF,
			FE_ALL_EXCEPT << _FE_EXCEPT_OFF)) != 0)
		_Force_raise(except);
	return (0);
	}
_STD_END

 #else /* _FPP_TYPE */
  #error unknown FPP type
 #endif /* _FPP_TYPE */

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
