////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/sys/Exception.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::Core::sys::Exception
//
// базовый класс для всех исключений (все пользовательские исключения должны от него наследоваться)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_SYS_EXCEPTION_H__
#define __SHARED_CORE_SYS_EXCEPTION_H__

#include "ace/ACE.h"
#include "shared/Core/sys/RefCountObjectBase.h"

//#UC START# *450035A90222_USER_INCLUDES*
#include <exception>
#include <vector>
#include <string>
//#UC END# *450035A90222_USER_INCLUDES*

namespace Core {

//#UC START# *450035A90222_USER_DEFINITION*
std::string create_exception_string (const char* message, const unsigned long error_code);

class Exception : public virtual std::exception {
public:
	Exception () {
	}
	
	virtual const char* what () const throw () {
		return "";
	}

	virtual const char* uid () const /*throw ()*/ = 0;

public:
	static void std_ex_handler (std::exception& ex);		

	static void unknown_ex_handler ();
};

#define _SAFE_TRY                        \
	try {

#define _STD_EX_DEFINES 1

#define _SAFE_CATCH                      \
	} catch (std::exception& ex) {           \
		ACE_DEBUG ((LM_ERROR, "(%P|%t) STD EXCEPTION: %s, %s:%s\n", ex.what (), __FILE__, __LINE__));   \
	} catch (...) {                          \
		ACE_DEBUG ((LM_ERROR, "(%P|%t) UNKNOWN EXCEPTION, %s:%s\n", __FILE__, __LINE__));  \
	}

#define _DLL_TRY                         \
	try {

#define _DLL_CATCH                       \
	} catch (std::exception& ex) {           \
		Core::Exception::std_ex_handler(ex);  \
		throw;                               \
	} catch (...) {                          \
		Core::Exception::unknown_ex_handler(); \
		throw;                               \
	}

#define _DLL_CATCH_RETURNED              \
	} catch (std::exception& ex) {           \
		Core::Exception::std_ex_handler(ex);  \
		throw;                               \
	} catch (...) {                          \
		Core::Exception::unknown_ex_handler(); \
		throw;                               \
	}
//#UC END# *450035A90222_USER_DEFINITION*

} // namespace Core


#endif //__SHARED_CORE_SYS_EXCEPTION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
