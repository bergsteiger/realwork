// iostream -- ios::Init members, initialize standard streams
#include <fstream>
#include <istream>	/* NOT <iostream>, don't want Init object constructed */
#include <new>
#if defined(__BORLANDC__)
#include <iostream>
#endif

_STD_BEGIN

#if defined(__BORLANDC__)
#pragma init_seg(compiler)  // This causes the global classes defined in this
                            // file to be initialized just a bit earlier than
                            // other global classes in the system. Thus,
                            // normal user global classes can safely use iostream
                            // objects during their ctors & dtors.
_CRTIMP2 ios_base::Init _Ios_init;
_CRTIMP2 _Winit _Wios_init;
#endif
		// OBJECT DECLARATIONS
_CRTIMP2 int ios_base::Init::_Init_cnt = -1;	// net constructors - destructors

static filebuf fin(_Noinit);	// uninitialized cin buffer
static filebuf fout(_Noinit);	// uninitialized cout buffer

_CRTIMP2 istream cin(_Noinit);	// uninitialized cin
_CRTIMP2 ostream cout(_Noinit);	// uninitialized cout

 #if _IS_EMBEDDED
 #else /* _IS_EMBEDDED */
static filebuf ferr(_Noinit);	// uninitialized cerr/clog buffer

_CRTIMP2 ostream cerr(_Noinit);	// uninitialized cerr

 #if _HAS_NAMESPACE
_CRTIMP2 ostream clog(_Noinit);	// uninitialized clog

 #else /* _HAS_NAMESPACE */

 #if __GNUC__ < 3 && !defined(__APPLE__)	/* compiler test */
_CRTIMP2 ostream clog(_Noinit);	// uninitialized clog

 #else /* __GNUC__ < 3 && !defined(__APPLE__) */
namespace _Dinkum_std {
_CRTIMP2 ostream clog(_Noinit);	// uninitialized clog
}	/* namespace _Dinkum_std */
using _Dinkum_std::clog;
 #endif /* __GNUC__ < 3 && !defined(__APPLE__) */

 #endif /* _HAS_NAMESPACE */
 #endif /* _IS_EMBEDDED */

_CRTIMP2 ios_base::Init::Init()
	{	// initialize standard streams first time
	bool doinit;
		{	// lock and test whether to initialize
		_Lockit lock(_LOCK_STREAM);
		if (0 <= _Init_cnt)
			++_Init_cnt, doinit = false;	// redundant initialization, skip
		else
			_Init_cnt = 1, doinit = true; }	// first initialization, do it

	if (doinit)
		{	// initialize standard streams
		new (&fin) filebuf(stdin);
		new (&fout) filebuf(stdout);
		new (&cin) istream(&fin, true);
		new (&cout) ostream(&fout, true);
 #if _IS_EMBEDDED
		cin.tie(&cout); }}
 #else /* _IS_EMBEDDED */
		cin.tie(&cout);
		new (&ferr) filebuf(stderr);
		new (&cerr) ostream(&ferr, true);
 #if _HAS_STRICT_CONFORMANCE
 #else /* _HAS_STRICT_CONFORMANCE */
		cerr.tie(&cout);
 #endif /* _HAS_STRICT_CONFORMANCE */
		cerr.setf(ios_base::unitbuf);
		new (&clog) ostream(&ferr, true);
		clog.tie(&cout); }}
 #endif /* _IS_EMBEDDED */

_CRTIMP2 ios_base::Init::~Init()
	{	// flush standard streams on last destruction
	bool doflush;
		{	// lock and test whether to flush streams
		_Lockit lock(_LOCK_STREAM);
		if (--_Init_cnt == 0)
			doflush = true;	// last destruction, do it
		else
			doflush = false; }	// not last destruction, skip

	if (doflush)
		{	// flush standard streams, but don't destroy
 #if _IS_EMBEDDED
		cout.flush(); }}
 #else /* _IS_EMBEDDED */
		cout.flush();
		cerr.flush();
		clog.flush(); }}
 #endif /* _IS_EMBEDDED */
_STD_END

char _PJP_CPP_Copyright[] =
	"Copyright (c) 1992-2004 by P.J. Plauger,"
	" licensed by Dinkumware, Ltd."
	" ALL RIGHTS RESERVED.";

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
