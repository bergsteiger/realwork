/* fesetround function */
#include <fenv.h>

 #if defined(__BORLANDC__)
  #pragma warn -par
 #endif /* defined(__BORLANDC__) */

 #if _FPP_TYPE == _FPP_NONE
  #include "xtls.h"
_STD_BEGIN

_TLS_DATA_DECL(fenv_t, _Fenv);

int (fesetround)(int round)
	{	/* set rounding mode */
	if ((round & _FE_RND_MASK) != round)
		return (1);
	else
		{	/* valid mode, set it */
		fenv_t *pfenv = _TLS_DATA_PTR(_Fenv);

		pfenv->_Fe_ctl = pfenv->_Fe_ctl & ~(_FE_RND_MASK << _FE_RND_OFF)
			| (round << _FE_RND_OFF);
		return (0);
		}
	}
_STD_END

 #elif _FPP_TYPE == _FPP_X86 || _FPP_TYPE == _FPP_WCE
_STD_BEGIN

void _Fesetctl(fexcept_t *pctl)
	{	/* set control word */

  #if _FPP_TYPE == _FPP_WCE
	_controlfp(*pctl, _FE_RND_MASK << _FE_RND_OFF);

  #elif defined(_MSC_VER) || defined(__BORLANDC__)
	__asm {	/* VC++ */
		mov		eax, dword ptr 8[ebp]
		fldcw	word ptr [eax]
	}

  #elif defined(__EDG__)
	asm("mov	8(%ebp),%eax");	/* gcc/PC */
	asm("fldcw	(%eax)");

  #else /* defined(_MSC_VER) || defined(__BORLANDC__) */
	__asm__("mov	8(%ebp),%eax");	/* gcc/PC */
	__asm__("fldcw	(%eax)");
  #endif /* defined(_MSC_VER) || defined(__BORLANDC__) */

	}

int (fesetround)(int round)
	{	/* set rounding mode */
	fexcept_t control;

	if ((int)(round & _FE_RND_MASK) != round)
		return (1);
	else
		{	/* valid mode, set it */
		_Fegetctl(&control);
		control = control & ~(_FE_RND_MASK << _FE_RND_OFF)
			| (round << _FE_RND_OFF);
		_Fesetctl(&control);
		return (0);
		}
	}
_STD_END

 #elif _FPP_TYPE == _FPP_SPARC || _FPP_TYPE == _FPP_S390 \
	|| _FPP_TYPE == _FPP_MIPS || _FPP_TYPE == _FPP_PPC \
	|| _FPP_TYPE == _FPP_ALPHA || _FPP_TYPE == _FPP_ARM \
	|| _FPP_TYPE == _FPP_SH4 || _FPP_TYPE == _FPP_IA64
_STD_BEGIN

int (fesetround)(int round)
	{	/* set rounding mode */
	fexcept_t control;

	if ((int)(round & _FE_RND_MASK) != round)
		return (1);
	else
		{	/* valid mode, set it */
		fegetenv(&control);
		control = control & ~(_FE_RND_MASK << _FE_RND_OFF)
			| (round << _FE_RND_OFF);
		fesetenv(&control);
		return (0);
		}
	}
_STD_END

 #elif _FPP_TYPE == _FPP_HPPA || _FPP_TYPE == _FPP_M68K
_STD_BEGIN

int (fesetround)(int round)
	{	/* set rounding mode */
	if ((int)(round & _FE_RND_MASK) != round)
		return (1);
	else
		{	/* valid mode, set it */
		_Fesetstat(round << _FE_RND_OFF, _FE_RND_MASK << _FE_RND_OFF);
		return (0);
		}
	}
_STD_END

 #else /* _FPP_TYPE */
  #error unknown FPP type
 #endif /* _FPP_TYPE */

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
