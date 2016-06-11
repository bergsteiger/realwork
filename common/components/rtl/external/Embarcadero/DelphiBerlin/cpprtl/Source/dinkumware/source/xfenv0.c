/* _Fenv0 object */
#include <fenv.h>
_STD_BEGIN

 #if _FPP_TYPE == _FPP_NONE
/* extern const */ fenv_t _Fenv0 = {
	(FE_TONEAREST << _FE_RND_OFF)
		| (FE_ALL_EXCEPT << _FE_EXMASK_OFF), 0};

 #elif _FPP_TYPE == _FPP_X86
/* extern const */ fenv_t _Fenv0 = {
	_FE_EXMASK_ALL | (FE_TONEAREST << _FE_RND_OFF),
	0, (unsigned long)(-1)};

 #elif _FPP_TYPE == _FPP_SPARC || _FPP_TYPE == _FPP_MIPS \
	|| _FPP_TYPE == _FPP_S390 || _FPP_TYPE == _FPP_PPC \
	|| _FPP_TYPE == _FPP_ARM || _FPP_TYPE == _FPP_SH4 \
	|| _FPP_TYPE == _FPP_IA64

  #if defined(_FE_EXMASK_ALL)
/* extern const */ fenv_t _Fenv0 = {
	_FE_EXMASK_ALL | (FE_TONEAREST << _FE_RND_OFF)};

  #else /* defined(_FE_EXMASK_ALL) */
/* extern const */ fenv_t _Fenv0 = {FE_TONEAREST << _FE_RND_OFF};
  #endif /* defined(_FE_EXMASK_ALL) */

 #elif _FPP_TYPE == _FPP_HPPA
/* extern const */ fenv_t _Fenv0 = {
	FE_TONEAREST << _FE_RND_OFF};

 #elif _FPP_TYPE == _FPP_ALPHA
/* extern const */ fenv_t _Fenv0 = {
	_FE_EXMASK_ALL | (FE_TONEAREST << _FE_RND_OFF)};

 #elif _FPP_TYPE == _FPP_M68K
/* extern const */ fenv_t _Fenv0 = {
	FE_TONEAREST << _FE_RND_OFF, 0, 0};

 #elif _FPP_TYPE == _FPP_WCE
/* extern const */ fenv_t _Fenv0 = {
	_FE_EXMASK_ALL | (FE_TONEAREST << _FE_RND_OFF), 0};

 #else /* _FPP_TYPE */
  #error unknown FPP type
 #endif /* _FPP_TYPE */

_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
