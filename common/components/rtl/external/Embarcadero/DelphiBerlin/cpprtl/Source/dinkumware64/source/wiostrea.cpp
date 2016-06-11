// wiostream -- initialize standard wide streams
#include <fstream>

 #if _IS_EMBEDDED

 #else /* _IS_EMBEDDED */
#include <iostream>
#include <new>
_STD_BEGIN
		// OBJECT DECLARATIONS
int _Winit::_Init_cnt = -1;	// net constructors - destructors
static wfilebuf wfin(_Noinit);	// uninitialized wcin buffer
static wfilebuf wfout(_Noinit);	// uninitialized wcout buffer
static wfilebuf wferr(_Noinit);	// uninitialized wcerr/wclog buffer
_CRTIMP2 wistream wcin(_Noinit);	// uninitialized wcin
_CRTIMP2 wostream wcout(_Noinit);	// uninitialized wcout
_CRTIMP2 wostream wcerr(_Noinit);	// uninitialized wcerr
_CRTIMP2 wostream wclog(_Noinit);	// uninitialized wclog

_CRTIMP2 _Winit::_Winit()
	{	// initialize standard wide streams first time
	bool doinit;
		{	// lock and test whether to initialize
		_Lockit lock(_LOCK_STREAM);
		if (0 <= _Init_cnt)
			{	// redundant initialization, skip
			++_Init_cnt;
			doinit = false;
			}
		else
			{	// first initialization, do it
			_Init_cnt = 1;
			doinit = true;
			}
		}

	if (doinit)
		{	// initialize standard wide streams
		new (&wfin) wfilebuf(stdin);
		new (&wfout) wfilebuf(stdout);
		new (&wferr) wfilebuf(stderr);
		new (&wcin) wistream(&wfin, true);
		new (&wcout) wostream(&wfout, true);
		wcin.tie(&wcout);
		new (&wcerr) wostream(&wferr, true);

 #if _HAS_CPP0X
		wcerr.tie(&wcout);	// required with DR 455
 #endif /* _HAS_CPP0X */

		wcerr.setf(ios_base::unitbuf);
		new (&wclog) wostream(&wferr, true);
		wclog.tie(&wcout);
		}
	}

_CRTIMP2 _Winit::~_Winit() _NOEXCEPT
	{	// flush standard wide streams on last destruction
	bool doflush;
		{	// lock and test whether to flush streams
		_Lockit lock(_LOCK_STREAM);
		if (--_Init_cnt == 0)
			doflush = true;	// last destruction, do it
		else
			doflush = false;	// not last destruction, skip
		}

	if (doflush)
		{	// flush standard wide streams, but don't destroy
		wcout.flush();
		wcerr.flush();
		wclog.flush();
		}
	}
_STD_END
 #endif /* _IS_EMBEDDED */

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
