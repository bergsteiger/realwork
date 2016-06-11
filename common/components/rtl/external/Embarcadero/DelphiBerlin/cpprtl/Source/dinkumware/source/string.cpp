// string -- template string support functions
#include <istream>
_STD_BEGIN

 #if _IS_EMBEDDED
const string::size_type string::npos =
	(string::size_type)(-1);	// define npos as largest positive value
 #endif /* _IS_EMBEDDED */

_CRTIMP2 void _String_base::_Xlen() const
	{	// report a length_error
	_THROW(length_error, "string too long");
	}

_CRTIMP2 void _String_base::_Xran() const
	{	// report an out_of_range error
	_THROW(out_of_range, "invalid string position");
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
