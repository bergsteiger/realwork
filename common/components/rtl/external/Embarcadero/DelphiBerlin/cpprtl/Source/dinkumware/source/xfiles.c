/* _Files data object */
#include "xstdio.h"
_STD_BEGIN

/* standard error buffer */
static unsigned char ebuf[80] = {0};

 #ifdef _WIN32_WCE
/* the standard streams */
FILE _Stdin = {	/* standard input */
	_MOPENR, 0, 0,
	&_Stdin._Cbuf, &_Stdin._Cbuf + 1, &_Stdin._Cbuf,
	&_Stdin._Cbuf, &_Stdin._Cbuf,
	_Stdin._Back + sizeof (_Stdin._Back),
	_Stdin._WBack + sizeof (_Stdin._WBack) / sizeof (wchar_t)};

FILE _Stdout = {	/* standard output */
	_MOPENW | _MCREAT | _MOPENA, 1, 0,
	&_Stdout._Cbuf, &_Stdout._Cbuf + 1, &_Stdout._Cbuf,
	&_Stdout._Cbuf, &_Stdout._Cbuf,
	_Stdout._Back + sizeof (_Stdout._Back),
	_Stdout._WBack + sizeof (_Stdout._WBack) / sizeof (wchar_t)};

FILE _Stderr = {	/* standard error */
	_MOPENW | _MCREAT | _MOPENA | _MNBF, 2, 0,
	ebuf, ebuf + sizeof (ebuf), ebuf,
	ebuf, ebuf,
	_Stderr._Back + sizeof (_Stderr._Back),
	_Stderr._WBack + sizeof (_Stderr._WBack) / sizeof (wchar_t)};

/* the array of stream pointers */
FILE *_Files[FOPEN_MAX] = {&_Stdin, &_Stdout, &_Stderr};

 #else /* _WIN32_WCE */
/* the standard streams */
_CRTIMP2 FILE _Stdin = {	/* standard input */
	_MOPENR, 0, 0,
	&_Stdin._Cbuf, &_Stdin._Cbuf + 1, &_Stdin._Cbuf,
	&_Stdin._Cbuf, &_Stdin._Cbuf,
	_Stdin._Back + sizeof (_Stdin._Back),
	_Stdin._WBack + sizeof (_Stdin._WBack) / sizeof (wchar_t)
	};

_CRTIMP2 FILE _Stdout = {	/* standard output */
	_MOPENW, 1, 1,
	&_Stdout._Cbuf, &_Stdout._Cbuf + 1, &_Stdout._Cbuf,
	&_Stdout._Cbuf, &_Stdout._Cbuf,
	_Stdout._Back + sizeof (_Stdout._Back),
	_Stdout._WBack + sizeof (_Stdout._WBack) / sizeof (wchar_t)
	};

_CRTIMP2 FILE _Stderr = {	/* standard error */
	_MOPENW | _MNBF, 2, 2,
	ebuf, ebuf + sizeof (ebuf), ebuf,
	ebuf, ebuf,
	_Stderr._Back + sizeof (_Stderr._Back),
	_Stderr._WBack + sizeof (_Stderr._WBack) / sizeof (wchar_t)
	};

/* the array of stream pointers */
_CRTIMP2 FILE *_Files[FOPEN_MAX] = {&_Stdin, &_Stdout, &_Stderr};
 #endif /* _WIN32_WCE */

char _PJP_C_Copyright[] =
	"Copyright (c) 1992-2006 by P.J. Plauger,"
	" licensed by Dinkumware, Ltd."
	" ALL RIGHTS RESERVED.";
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
