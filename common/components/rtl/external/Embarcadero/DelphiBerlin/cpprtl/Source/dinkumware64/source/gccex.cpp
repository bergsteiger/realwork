// gccex -- exception members for gcc

 #if __EDG__

 #else /* __EDG__ */
#include <exception>
_X_STD_BEGIN
  #if defined(__GNUC__) || defined(__BORLANDC__)
_Prhand exception::_Set_raise_handler(_Prhand _Pnew)
	{	// register a handler for _Raise calls
	const _Prhand _Pold = _Raise_handler;
	_Raise_handler = _Pnew;
	return (_Pold);
	}

//exception::exception()  _THROW0()
//	{}	// construct with no message string
//
//	explicit exception(const char *_Message = _MESG("unknown")) _THROW0()
//		: _Ptr(_Message)
//		{}	// construct from message string
//
//	exception(const exception& _Right) _THROW0()
//		: _Ptr(_Right._Ptr)
//		{}	// construct by copying _Right
//
//	exception& operator=(const exception& _Right) _THROW0()
//		{	// assign _Right
//		_Ptr = _Right._Ptr;
//		return (*this); }

   #if __GNUC__ < 3 \
	|| !defined(__APPLE__) && !defined(__MINGW32__) && !defined(__CYGWIN__)
exception::~exception() _NOEXCEPT
	{	// destroy the object
	}

 #if _HAS_TRADITIONAL_STL
const char *exception::what() const

 #else /* _HAS_TRADITIONAL_STL */
const char *exception::what() const _THROW0()
 #endif /* _HAS_TRADITIONAL_STL */

	{	// return message string
	return ("");
	}

//	virtual const char *what() const _THROW0()
//		{	// return pointer to message string
//		return (_Ptr);
//		}
   #endif /* __GNUC__ < 3 etc. */

  #endif /* defined(__GNUC__) || defined(__BORLANDC__) */

 #if _HAS_EXCEPTIONS

 #else /* _HAS_EXCEPTIONS */
void exception::_Raise() const
	{	// raise the exception
	if (_Raise_handler != 0)
		(*_Raise_handler)(*this);	// call raise handler if present

	_Doraise();	// call the protected virtual
	_RAISE(*this);	// raise this exception
	}

void exception::_Doraise() const
	{	// perform class-specific exception handling
	}
 #endif /* _HAS_EXCEPTIONS */
_X_STD_END
 #endif /* __EDG__ */

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
