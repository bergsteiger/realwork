/* fesetenv function */
#include <fenv.h>

 #if defined(__BORLANDC__)
  #pragma warn -par
 #endif /* compiler type */

 #if 199901L <= __STDC_VERSION__ && !defined(__APPLE__)
  #define DBL_BIG	1e+300	/* may raise inexact too */

 #else /* 199901L <= __STDC_VERSION__ */
 #define DBL_BIG	1e+300	/* may raise inexact too */
 #endif /* 199901L <= __STDC_VERSION__ */

_STD_BEGIN
static struct {
	int except;
	double num, denom;
	} table[] = {	/* raise except by evaluating num / denom */
	{FE_INVALID, 0.0, 0.0},
	{FE_DIVBYZERO, 1.0, 0.0},
	{FE_OVERFLOW, DBL_BIG, 1.0 / DBL_BIG},
	{FE_UNDERFLOW, 1.0 / DBL_BIG, DBL_BIG},
	{FE_INEXACT, 2.0, 3.0}};

double _Force_raise(int except)
	{	/* trigger one or more exceptions */
	double ans = 0.0;
	int i;

	for (i = 0; i < sizeof (table) / sizeof (table[0]); ++i)
		if ((except & table[i].except) != 0)
			ans = table[i].num / table[i].denom;
	return (ans);	/* use it, to quell warnings */
	}
_STD_END

 #if _FPP_TYPE == _FPP_NONE
  #include "xtls.h"
_STD_BEGIN

_TLS_DATA_DECL(fenv_t, _Fenv);

int (fesetenv)(const fenv_t *penv)
	{	/* load floating-point environment */
	*_TLS_DATA_PTR(_Fenv) = *penv;
	return (0);
	}
_STD_END

 #else /* _FPP_TYPE == _FPP_NONE */
_STD_BEGIN

  #if !defined(__APPLE__)	/* defer to fegetenv.s */
int (fesetenv)(const fenv_t *penv)
	{	/* load floating-point environment */


  #if _FPP_TYPE == _FPP_X86

   #if defined(_MSC_VER) || defined(__BORLANDC__)
	__asm {		/* VC++ */
		mov		eax, dword ptr 8[ebp]
		fldenv	[eax]
	}

   #elif defined(__EDG__)
	asm("mov	8(%ebp),%eax");	/* gcc/PC */
	asm("fldenv	(%eax)");

   #else /* defined(_MSC_VER) || defined(__BORLANDC__) */
	__asm__("mov	8(%ebp),%eax");	/* gcc/PC */
	__asm__("fldenv	(%eax)");
   #endif /* defined(_MSC_VER) || defined(__BORLANDC__) */

  #elif _FPP_TYPE == _FPP_SPARC

   #if defined(__EDG__)
	asm("ld		[%fp+68],%o0");
	asm("ld		[%o0],%fsr");

   #else /* defined(__EDG__) */
	__asm("ld		[%fp+68],%o0");
	__asm("ld		[%o0],%fsr");
   #endif /* defined(__EDG__) */

  #elif _FPP_TYPE == _FPP_MIPS

   #if !defined(_MSC_VER)
	__asm__("ctcl	%0,$31" : : "r" (*penv));
   #endif /* defined(_MSC_VER) */

  #elif _FPP_TYPE == _FPP_S390
	__asm__("l		2,96(11)");
	__asm__("l		3,0(2)");
	__asm__("sfpc	3,0");

  #elif _FPP_TYPE == _FPP_PPC
	union {
		double dbl;
		fenv_t csr[2];
		} status;

	status.csr[0] = (fenv_t)-1;
	status.csr[1] = *penv;
	__asm__("mtfsf	0xff,%0" : : "f" (status));

  #elif _FPP_TYPE == _FPP_HPPA
	__asm__(	/* HP PA-Risc */
		"fldd,mb	-8(%2),%%fr3\n"
		"fldd,mb	-8(%2),%%fr2\n"
		"fldd,mb	-8(%2),%%fr1\n"
		"fldd		-8(%2),%%fr0\n"
			: "=m" (*penv), "=r" (penv) : "1" (penv));

  #elif _FPP_TYPE == _FPP_ALPHA
	__asm__(
		"excb\n"
		"mt_fpcr	%0\n"
		"excb"
			: : "f" (*penv));

  #elif _FPP_TYPE == _FPP_ARM
	__asm__("wfs	%0" : : "r" (*penv));

  #elif _FPP_TYPE == _FPP_M68K
	__asm__("fmovem%.l	%0,%/fpcr/%/fpsr/%/fpiar" : : "m" (*penv));

  #elif _FPP_TYPE == _FPP_SH4
	fenv_t env = *penv;

	__asm__("lds	%0,fpcsr" : : "r" (env));

  #elif _FPP_TYPE == _FPP_IA64
	__asm__("mov.m	ar.fpsr=%0" : : "r" (*penv));

  #elif _FPP_TYPE == _FPP_WCE
	_controlfp(penv->_Fe_ctl, _FE_RND_MASK << _FE_RND_OFF);
    _clearfp();
	if ((penv->_Fe_stat & (FE_ALL_EXCEPT << _FE_EXCEPT_OFF)) != 0)
		_Force_raise(penv->_Fe_stat);

  #else /* _FPP_TYPE */
   #error unknown FPP type
  #endif /* _FPP_TYPE */

	return (0);
	}
  #endif /* !defined(__APPLE__) */

_STD_END
 #endif /* _FPP_TYPE == _FPP_NONE */

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
