// xfpos -- _Postype_to_fpos_t and _Postype_to_mbstate_t conversions
#include <iosfwd>

 #if _HAS_TRADITIONAL_POS_TYPE
_STD_BEGIN
fpos_t _Postype_to_fpos_t(streampos pos)
	{	// convert scalar streampos to fpos_t
	fpos_t ans = {pos};	// ASSUMES OFFSET IS FIRST FIELD

	return (ans);
	}

mbstate_t _Postype_to_mbstate_t(streampos pos)
	{	// convert scalar streampos to mbstate_t (return initial state)
	static mbstate_t mbstinit;

	return (mbstinit);
	}
_STD_END
 #endif /* _HAS_TRADITIONAL_POS_TYPE */

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
