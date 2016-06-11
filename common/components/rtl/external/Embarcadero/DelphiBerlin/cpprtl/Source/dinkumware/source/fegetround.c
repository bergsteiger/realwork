/* fegetround function */
#include <fenv.h>

 #if defined(__BORLANDC__)
  #pragma warn -par
 #endif /* compiler type */

 #if _FPP_TYPE == _FPP_NONE
  #include "xtls.h"
_STD_BEGIN

_TLS_DATA_DECL(fenv_t, _Fenv);

int (fegetround)()
	{	/* test rounding mode */
	fexcept_t control;

	control = _TLS_DATA_PTR(_Fenv)->_Fe_ctl;
	return ((int)(control >> _FE_RND_OFF) & _FE_RND_MASK);
	}
_STD_END

 #elif _FPP_TYPE == _FPP_X86 || _FPP_TYPE == _FPP_WCE
_STD_BEGIN

void _Fegetctl(fexcept_t *pctl)
	{	/* get control word */

  #if _FPP_TYPE == _FPP_WCE
	fenv_t env;

	fegetenv(&env);
	*pctl = env._Fe_ctl;

  #elif defined(_MSC_VER) || defined(__BORLANDC__)
	__asm {	/* VC++ */
		mov		eax, dword ptr 8[ebp]
		fstcw	word ptr [eax]
	}

  #elif defined(__EDG__)
	asm("mov	8(%ebp),%eax");	/* gcc/PC */
	asm("fstcw	(%eax)");

  #else /* defined(_MSC_VER) || defined(__BORLANDC__) */
	__asm__("mov	8(%ebp),%eax");	/* gcc/PC */
	__asm__("fstcw	(%eax)");
  #endif /* defined(_MSC_VER) || defined(__BORLANDC__) */

	}

int (fegetround)()
	{	/* test rounding mode */
	fexcept_t control;

	_Fegetctl(&control);
	return ((int)(control >> _FE_RND_OFF) & _FE_RND_MASK);
	}
_STD_END

 #elif _FPP_TYPE == _FPP_SPARC || _FPP_TYPE == _FPP_S390 \
	|| _FPP_TYPE == _FPP_MIPS || _FPP_TYPE == _FPP_PPC \
	|| _FPP_TYPE == _FPP_ALPHA || _FPP_TYPE == _FPP_ARM \
	|| _FPP_TYPE == _FPP_SH4 || _FPP_TYPE == _FPP_IA64
_STD_BEGIN

int (fegetround)()
	{	/* test rounding mode */
	fexcept_t control;

	fegetenv(&control);
	return ((int)(control >> _FE_RND_OFF) & _FE_RND_MASK);
	}
_STD_END

 #elif _FPP_TYPE == _FPP_HPPA || _FPP_TYPE == _FPP_M68K
_STD_BEGIN

int (fegetround)()
	{	/* test rounding mode */
	return ((int)(_Fegetstat() >> _FE_RND_OFF) & _FE_RND_MASK);
	}
_STD_END

 #else /* _FPP_TYPE */
  #error unknown FPP type
 #endif /* _FPP_TYPE */

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
