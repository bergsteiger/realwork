// iomanip -- instantiations of iomanip
#include <iomanip>
_STD_BEGIN

		// FUNCTION resetiosflags
static void rsfun(ios_base& iostr, ios_base::fmtflags mask)
	{	// reset specified format flags
	iostr.setf(ios_base::_Fmtzero, mask);
	}

		// FUNCTION setiosflags
static void sifun(ios_base& iostr, ios_base::fmtflags mask)
	{	// set specified format flags
	iostr.setf(ios_base::_Fmtmask, mask);
	}

		// FUNCTION setbase
static void sbfun(ios_base& iostr, int base)
	{	// set base
	iostr.setf(base == 8 ? ios_base::oct
		: base == 10 ? ios_base::dec
		: base == 16 ? ios_base::hex
		: ios_base::_Fmtzero,
			ios_base::basefield);
	}

		// FUNCTION setprecision
static void spfun(ios_base& iostr, streamsize prec)
	{	// set precision
	iostr.precision(prec);
	}

		// FUNCTION setw
static void swfun(ios_base& iostr, streamsize wide)
	{	// set width
	iostr.width(wide);
	}

 #if _IS_EMBEDDED
		// FUNCTION setfill
static void sffun(ios& iostr, char ch)
	{	// set fill
	iostr.fill(ch);
	}

_CRTIMP2 _SMNAME(char) setfill(char ch)
	{	// manipulator to set fill
	return (_SMNAME(char)(&sffun, ch));
	}

_CRTIMP2 _SMNAME(fmt) resetiosflags(ios_base::fmtflags mask)
	{	// manipulator to reset format flags
	return (_SMNAME(fmt)(&rsfun, mask));
	}

_CRTIMP2 _SMNAME(fmt) setiosflags(ios_base::fmtflags mask)
	{	// manipulator to set format flags
	return (_SMNAME(fmt)(&sifun, mask));
	}

_CRTIMP2 _SMNAME(int) setbase(int base)
	{	// manipulator to set base
	return (_SMNAME(int)(&sbfun, base));
	}

_CRTIMP2 _SMNAME(str) setprecision(streamsize prec)
	{	// manipulator to set precision
	return (_SMNAME(str)(&spfun, prec));
	}

_CRTIMP2 _SMNAME(str) setw(streamsize wide)
	{	// manipulator to set width
	return (_SMNAME(str)(&swfun, wide));
	}

 #else /* _IS_EMBEDDED */
_CRTIMP2 _Smanip<ios_base::fmtflags>
	resetiosflags(ios_base::fmtflags mask)
	{	// manipulator to reset format flags
	return (_Smanip<ios_base::fmtflags>(&rsfun, mask));
	}

_CRTIMP2 _Smanip<ios_base::fmtflags>
	setiosflags(ios_base::fmtflags mask)
	{	// manipulator to set format flags
	return (_Smanip<ios_base::fmtflags>(&sifun, mask));
	}

_CRTIMP2 _Smanip<int> setbase(int base)
	{	// manipulator to set base
	return (_Smanip<int>(&sbfun, base));
	}

_CRTIMP2 _Smanip<streamsize> setprecision(streamsize prec)
	{	// manipulator to set precision
	return (_Smanip<streamsize>(&spfun, prec));
	}

_CRTIMP2 _Smanip<streamsize> setw(streamsize wide)
	{	// manipulator to set width
	return (_Smanip<streamsize>(&swfun, wide));
	}
 #endif /* _IS_EMBEDDED */

_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
