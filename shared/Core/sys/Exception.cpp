////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/sys/Exception.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::Core::sys::Exception
// Файл реализации утилитного набора Exception
//
// базовый класс для всех исключений (все пользовательские исключения должны от него наследоваться)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "ace/ACE.h"
#include "shared/Core/sys/Exception.h"

//#UC START# *450035A90222_CUSTOM_INCLUDES*
#include "boost/lexical_cast.hpp"

#include "shared/Core/sys/assert.h"
#include "shared/Core/mng/Var.h" // cycle
#include "shared/Core/sys/Logs.h"

#ifdef WIN32
#include <objbase.h>
#endif
//#UC END# *450035A90222_CUSTOM_INCLUDES*

namespace Core {

//#UC START# *450035A90222*
std::string create_exception_string (const char* message, const unsigned long error_code) {
	return message + std::string (": ") + boost::lexical_cast<std::string> (error_code);
}

void Exception::std_ex_handler (std::exception& ex) {
#ifdef WIN32
	const Exception* core_ex = dynamic_cast <const Exception*> (&ex);
	if (core_ex) {
		const char* uid = core_ex->uid ();
		const size_t uid_size = ACE_OS_String::strlen (uid) + sizeof (char);

		const void* buffer = ::CoTaskMemAlloc ((ULONG)uid_size);
		if (buffer != 0) {
			try {
				ACE_OS_String::strncpy ((char*)buffer, uid, uid_size);
			} catch (...) {
				::CoTaskMemFree ((void*)buffer);
				buffer = 0;
			}
		}

		if (buffer != 0) {
			::RaiseException (0xE0040203UL, EXCEPTION_NONCONTINUABLE, 1, (const ULONG_PTR*)&buffer);
		} else {
			GDS_ASSERT (false);
		}
	} else if (dynamic_cast <std::bad_alloc*> (&ex)) {
		GDS_ASSERT (false);
		::RaiseException (0xE0040200UL, EXCEPTION_NONCONTINUABLE, 0, 0);
	} else {		
		try {
			LOG_SEX ((ex, "Exception raises through DLL border"));
		} catch (...) {
		}
		GDS_ASSERT (false);

		const char* what = ex.what ();
		const size_t what_size = ACE_OS_String::strlen (what) + sizeof (char);

		const void* buffer = ::CoTaskMemAlloc ((ULONG)what_size);
		if (buffer != 0) {
			try {
				ACE_OS_String::strncpy ((char*)buffer, what, what_size);
			} catch (...) {
				::CoTaskMemFree ((void*)buffer);
				buffer = 0;
			}
		}

		if (buffer != 0) {
			::RaiseException (0xE0040201UL, EXCEPTION_NONCONTINUABLE, 1, (const ULONG_PTR*)&buffer);
		} else {
			GDS_ASSERT (false);
		}
	}
#else // WIN32
	throw ex;
#endif	
}

void Exception::unknown_ex_handler () {
	try {
		LOG_UEX (("Exception raises through DLL border"));
	} catch (...) {
	}
	GDS_ASSERT (false);
}
//#UC END# *450035A90222*

} // namespace Core

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

