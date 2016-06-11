// iomanip -- instantiations of iomanip
#include <iomanip>
_STD_BEGIN
		// FUNCTION resetiosflags
static void _CDECL rsfun(ios_base& iostr, ios_base::fmtflags mask)
	{	// reset specified format flags
	iostr.setf(ios_base::_Fmtzero, mask);
	}

		// FUNCTION setiosflags
static void _CDECL sifun(ios_base& iostr, ios_base::fmtflags mask)
	{	// set specified format flags
	iostr.setf(ios_base::_Fmtmask, mask);
	}

		// FUNCTION setbase
static void _CDECL sbfun(ios_base& iostr, int base)
	{	// set base
	iostr.setf(base == 8 ? ios_base::oct
		: base == 10 ? ios_base::dec
		: base == 16 ? ios_base::hex
		: ios_base::_Fmtzero,
			ios_base::basefield);
	}

		// FUNCTION setprecision
static void _CDECL spfun(ios_base& iostr, streamsize prec)
	{	// set precision
	iostr.precision(prec);
	}

		// FUNCTION setw
static void _CDECL swfun(ios_base& iostr, streamsize wide)
	{	// set width
	iostr.width(wide);
	}

 #if _IS_EMBEDDED
		// FUNCTION setfill
static void _CDECL sffun(ios& iostr, char ch)
	{	// set fill
	iostr.fill(ch);
	}

_MRTIMP2 _SMNAME(char) _CDECL setfill(char ch)
	{	// manipulator to set fill
	return (_SMNAME(char)(&sffun, ch));
	}

_MRTIMP2 _SMNAME(fmt) _CDECL resetiosflags(ios_base::fmtflags mask)
	{	// manipulator to reset format flags
	return (_SMNAME(fmt)(&rsfun, mask));
	}

_MRTIMP2 _SMNAME(fmt) _CDECL setiosflags(ios_base::fmtflags mask)
	{	// manipulator to set format flags
	return (_SMNAME(fmt)(&sifun, mask));
	}

_MRTIMP2 _SMNAME(int) _CDECL setbase(int base)
	{	// manipulator to set base
	return (_SMNAME(int)(&sbfun, base));
	}

_MRTIMP2 _SMNAME(str) _CDECL setprecision(streamsize prec)
	{	// manipulator to set precision
	return (_SMNAME(str)(&spfun, prec));
	}

_MRTIMP2 _SMNAME(str) _CDECL setw(streamsize wide)
	{	// manipulator to set width
	return (_SMNAME(str)(&swfun, wide));
	}

 #else /* _IS_EMBEDDED */
_MRTIMP2 _Smanip<ios_base::fmtflags>
	_CDECL resetiosflags(ios_base::fmtflags mask)
	{	// manipulator to reset format flags
	return (_Smanip<ios_base::fmtflags>(&rsfun, mask));
	}

_MRTIMP2 _Smanip<ios_base::fmtflags>
	_CDECL setiosflags(ios_base::fmtflags mask)
	{	// manipulator to set format flags
	return (_Smanip<ios_base::fmtflags>(&sifun, mask));
	}

_MRTIMP2 _Smanip<int> _CDECL setbase(int base)
	{	// manipulator to set base
	return (_Smanip<int>(&sbfun, base));
	}

_MRTIMP2 _Smanip<streamsize> _CDECL setprecision(streamsize prec)
	{	// manipulator to set precision
	return (_Smanip<streamsize>(&spfun, prec));
	}

_MRTIMP2 _Smanip<streamsize> _CDECL setw(streamsize wide)
	{	// manipulator to set width
	return (_Smanip<streamsize>(&swfun, wide));
	}
 #endif /* _IS_EMBEDDED */
_STD_END

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
