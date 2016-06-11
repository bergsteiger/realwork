// new -- operator new support functions
#include <new>
_STD_BEGIN

new_handler _New_hand = 0;	// pointer to current new handler

_CRTIMP2 new_handler set_new_handler(new_handler pnew) _THROW0()
	{	// point at new handler
	_Lockit lock(_LOCK_MALLOC);
	new_handler pold = _New_hand;
	_New_hand = pnew;
	return (pold);
	}

_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
