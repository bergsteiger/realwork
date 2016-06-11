/* fegetenv function */
#include <fenv.h>

 #if defined(__BORLANDC__)
  #pragma warn -par
 #endif /* compiler type */

 #if _FPP_TYPE == _FPP_NONE
  #include "xtls.h"
_STD_BEGIN

_TLS_DATA_DECL(fenv_t, _Fenv);

int (fegetenv)(fenv_t *penv)
	{	/* store floating-point environment */
	*penv = *_TLS_DATA_PTR(_Fenv);
	return (0);
	}
_STD_END

 #else /* _FPP_TYPE == _FPP_NONE */
_STD_BEGIN

int (fegetenv)(fenv_t *penv)
	{	/* store floating-point environment */

  #if defined(__APPLE__)	/* defer to fegetenv.s */

  #elif _FPP_TYPE == _FPP_X86

   #if defined(_MSC_VER) || defined(__BORLANDC__)
	__asm {		/* VC++ */
		mov		eax, dword ptr 8[ebp]
		fstenv	[eax]
		fldcw	word ptr [eax]
	}

   #elif defined(__EDG__)
	asm("mov	8(%ebp),%eax");	/* gcc/PC */
	asm("fstenv	(%eax)");
	asm("fldcw	(%eax)");

   #else /* defined(_MSC_VER) || defined(__BORLANDC__) */
	__asm__("mov	8(%ebp),%eax");	/* gcc/PC */
	__asm__("fstenv	(%eax)");
	__asm__("fldcw	(%eax)");
   #endif /* defined(_MSC_VER) || defined(__BORLANDC__) */

  #elif _FPP_TYPE == _FPP_SPARC

   #if defined(__EDG__)
	asm("ld		[%fp+68],%o0");
	asm("st		%fsr,[%o0]");

   #else /* defined(__EDG__) */
	__asm("ld		[%fp+68],%o0");
	__asm("st		%fsr,[%o0]");
   #endif /* defined(__EDG__) */

  #elif _FPP_TYPE == _FPP_MIPS

   #if defined(_MSC_VER)
	__asm("cfcl	%0,$31" : "=r" (*penv));

   #else /* defined(_MSC_VER) */
	__asm__("cfcl	%0,$31" : "=r" (*penv));
   #endif /* defined(_MSC_VER) */

  #elif _FPP_TYPE == _FPP_S390
	__asm__("efpc	2,0");
	__asm__("l		3,96(11)");
	__asm__("st		2,0(3)");

  #elif _FPP_TYPE == _FPP_PPC
	union {
		double dbl;
		fenv_t csr[2];
		} status;

	__asm__("mffs	%0" : "=f" (status));
	*penv = status.csr[1];

  #elif _FPP_TYPE == _FPP_HPPA
	__asm__(	/* HP PA-Risc */
		"fstd		%%fr0,0(%2)\n"
		"fstd,ma	%%fr1,8(%2)\n"
		"fstd,ma	%%fr2,8(%2)\n"
		"fstd		%%fr3,0(%2)\n"
			: "=m" (*penv), "=r" (penv) : "1" (penv));

  #elif _FPP_TYPE == _FPP_ALPHA
	__asm__(
		"excb\n"
		"mf_fpcr	%0\n"
		"excb"
			: "=f" (*penv));

  #elif _FPP_TYPE == _FPP_ARM
	__asm__("wfs	%0" : "=r" (*penv));

  #elif _FPP_TYPE == _FPP_M68K
	__asm__("fmovem%.l	%/fpcr/%/fpsr/%/fpiar,%0" : "=m" (*penv));

  #elif _FPP_TYPE == _FPP_SH4
	fenv_t env;

	__asm__("sts	fpcsr,%0" : "=r" (env));
	*penv = env;

  #elif _FPP_TYPE == _FPP_IA64
	__asm__("mov.m	%0=ar.fpsr" : "=r" (*penv));

  #elif _FPP_TYPE == _FPP_WCE
	penv->_Fe_ctl = _controlfp(0, 0);
	penv->_Fe_stat = penv->_Fe_ctl & (_FE_RND_MASK << _FE_RND_OFF);
	penv->_Fe_stat |= _statusfp() & (FE_ALL_EXCEPT << _FE_EXCEPT_OFF);

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
