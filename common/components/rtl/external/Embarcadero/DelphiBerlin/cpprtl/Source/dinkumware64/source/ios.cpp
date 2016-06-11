// ios_base -- ios_base basic members
#include <new>
#include <xiosbase>
_STD_BEGIN
#define NSTDSTR	8	/* cin, wcin, cout, wcout, cerr, wcerr, clog, wclog */

extern _CRTIMP2 const streamoff
	_BADOFF = -1;	// initialize constant for bad file offset

int ios_base::_Index = 0;	// initialize source of unique indexes
bool ios_base::_Sync = true;	// initialize synchronization flag
_CRTIMP2 fpos_t _Fpz = {0};	// initialize constant for beginning of file
static ios_base *stdstr[NSTDSTR + 2] =
	{0};	// [1, NSTDSTR] hold pointers to standard streams
static char stdopens[NSTDSTR + 2] =
	{0};	// [1, NSTDSTR] hold open counts for standard streams
ios_base::~ios_base() _NOEXCEPT
	{	// destroy the object
	if (0 < _Stdstr && 0 < --stdopens[_Stdstr])
		return;
	_Tidy();
	delete _Ploc;
	}

void _CDECL ios_base::_Addstd(ios_base *str)
	{	// add standard stream to destructor list
	_Lockit lock(_LOCK_STREAM);

	for (str->_Stdstr = 0; ++str->_Stdstr < NSTDSTR; )
		if (stdstr[str->_Stdstr] == 0
			|| stdstr[str->_Stdstr] == str)
			break;	// found a candidate

	stdstr[str->_Stdstr] = str;
	++stdopens[str->_Stdstr];
	}
_STD_END

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
