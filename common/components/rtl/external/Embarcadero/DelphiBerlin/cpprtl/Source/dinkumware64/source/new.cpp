// new -- operator new support functions
#include <new>

_STD_BEGIN
 #if defined(_WIN32_C_LIB) && __EDG__
new_handler get_new_handler() _NOEXCEPT
	{	// get new handler -- UNSAFE
	new_handler _Hand = set_new_handler(0);
	set_new_handler(_Hand);
	return (_Hand);
	}

 #else /* defined(_WIN32_C_LIB) && __EDG__ */
static new_handler _New_hand = 0;	// pointer to current new handler

new_handler get_new_handler() _NOEXCEPT
	{	// get new handler
	_Lockit lock(_LOCK_MALLOC);
	return (_New_hand);
	}

new_handler set_new_handler(new_handler pnew) _THROW0()
	{	// point at new handler
	_Lockit lock(_LOCK_MALLOC);
	new_handler pold = _New_hand;
	_New_hand = pnew;
	return (pold);
	}
 #endif /* defined(_WIN32_C_LIB) && __EDG__ */
_STD_END

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
