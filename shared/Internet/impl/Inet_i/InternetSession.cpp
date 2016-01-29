////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Internet/impl/Inet_i/InternetSession.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::Internet::Inet_i::InternetSession
//
// Интернет сессия
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/Internet/impl/Inet_i/InternetSession.h"

//#UC START# *4AC5F7FA036E_CUSTOM_INCLUDES*
//#UC END# *4AC5F7FA036E_CUSTOM_INCLUDES*

namespace Internet {
namespace Inet_i {

//#UC START# *4AC5F7FA036E*
//#UC END# *4AC5F7FA036E*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

InternetSession::InternetSession (const char* user_agent, unsigned long access_type, const char* proxy_name)
//#UC START# *4AC5FC5B020C_BASE_INIT*
	: CInternetSession ((LPCTSTR) user_agent, 1, (DWORD) access_type, (LPCTSTR) proxy_name, NULL, 0)
//#UC END# *4AC5FC5B020C_BASE_INIT*
{
	//#UC START# *4AC5FC5B020C_BODY*
	//#UC END# *4AC5FC5B020C_BODY*
}

InternetSession::~InternetSession () {
	//#UC START# *4AC5F7FA036E_DESTR_BODY*
	//#UC END# *4AC5F7FA036E_DESTR_BODY*
}


} // namespace Inet_i
} // namespace Internet

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

