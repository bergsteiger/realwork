/* fegetexceptflag function */
#include <fenv.h>

 #if _FPP_TYPE == _FPP_NONE
  #include "xtls.h"
_STD_BEGIN

_TLS_DATA_DECL(fenv_t, _Fenv);

int (fegetexceptflag)(fexcept_t *pflag, int except)
	{	/* store selected exception sticky bits */
	if ((except &= FE_ALL_EXCEPT) != 0)
		*pflag = _TLS_DATA_PTR(_Fenv)->_Fe_stat >>= _FE_EXCEPT_OFF;
	*pflag &= except;
	return (0);
	}
_STD_END

 #else /* _FPP_TYPE == _FPP_NONE */
_STD_BEGIN

int (fegetexceptflag)(fexcept_t *pflag, int except)
	{	/* store selected exception sticky bits */
	if ((except &= FE_ALL_EXCEPT) != 0)
		{	/* try to get one or more exception sticky bits */

  #if _FPP_TYPE == _FPP_X86

   #if defined(_MSC_VER) || defined(__BORLANDC__)
	__asm {	/* VC++ */
		mov		eax, dword ptr 8[ebp]
		fstsw	word ptr [eax]
	}

   #elif defined(__EDG__)
		asm("mov	8(%ebp),%eax");	/* gcc/PC */
		asm("fstsw	(%eax)");

   #else /* defined(_MSC_VER) || defined(__BORLANDC__) */
		__asm__("mov	8(%ebp),%eax");	/* gcc/PC */
		__asm__("fstsw	(%eax)");
   #endif /* defined(_MSC_VER) || defined(__BORLANDC__) */

  #elif _FPP_TYPE == _FPP_SPARC || _FPP_TYPE == _FPP_S390 \
	|| _FPP_TYPE == _FPP_MIPS || _FPP_TYPE == _FPP_PPC \
	|| _FPP_TYPE == _FPP_ALPHA || _FPP_TYPE == _FPP_ARM \
	|| _FPP_TYPE == _FPP_SH4 || _FPP_TYPE == _FPP_IA64
		fegetenv(pflag);
		*pflag >>= _FE_EXCEPT_OFF;

  #elif _FPP_TYPE == _FPP_HPPA || _FPP_TYPE == _FPP_M68K
		*pflag = _Fegetstat();
		*pflag >>= _FE_EXCEPT_OFF;

  #elif _FPP_TYPE == _FPP_WCE
  		fenv_t env;
		fegetenv(&env);
		*pflag = env._Fe_stat >> _FE_EXCEPT_OFF;

  #else /* _FPP_TYPE */
   #error unknown FPP type
  #endif /* _FPP_TYPE */

		}

	*pflag &= except;
	return (0);
	}
_STD_END
 #endif /* _FPP_TYPE == _FPP_NONE */

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
