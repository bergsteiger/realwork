// gcctinfo -- type_info members for gcc

 #if __EDG__

 #elif defined(__GNUC__) && __GNUC__ < 3
#include <cstring>

 #if _IS_EMBEDDED

 #else /* _IS_EMBEDDED */
#include <typeinfo>
_X_STD_BEGIN

type_info::~type_info()
	{	// destroy the object
	}

bool type_info::operator==(const type_info& _Right) const
	{	// test for equality
	return (this == &_Right
		|| strcmp(_Myname, _Right._Myname) == 0);
	}

bool type_info::operator!=(const type_info& _Right) const
	{	// test for inequality
	return (!(*this == _Right));
	}

bool type_info::before(const type_info& _Right) const
	{	// test if this precedes arg
	return (this != &_Right
		&& strcmp(_Myname, _Right._Myname) < 0);
	}

const char *type_info::name() const
	{	// return name of type
	return (_Myname);
	}

type_info::type_info(const char *_Name)
	: _Myname(_Name)
	{	// construct with name
	}
_X_STD_END
 #endif /* _IS_EMBEDDED */

 #endif /* __EDG__ */

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
