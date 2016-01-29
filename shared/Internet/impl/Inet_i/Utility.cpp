////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Internet/impl/Inet_i/Utility.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityClass::Class>> shared::Internet::Inet_i::Utility
//
// Утилитный класс
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/Internet/impl/Inet_i/Utility.h"

//#UC START# *4AC0725E0229_CUSTOM_INCLUDES*
#include "wininet.h"
//#UC END# *4AC0725E0229_CUSTOM_INCLUDES*

namespace Internet {
namespace Inet_i {

//#UC START# *4AC0725E0229*
//#UC END# *4AC0725E0229*

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// проверка соединения с интернет
bool Utility::has_internet_connection () {
	//#UC START# *4AC072D0029F*
	DWORD flags = 0;
	BOOL ret = InternetGetConnectedState (&flags, 0);
	return ret == TRUE;
	//#UC END# *4AC072D0029F*
}

// расширенная проверка соединения с интернет (выполняется val проверок с паузой в 1 сек)
bool Utility::has_internet_connection_ex (size_t val) {
	//#UC START# *4AC072EB0291*
	bool ret = false;

	for (size_t i = 0; i < val && ret == false; ++i) {
		try {
			ret = Utility::has_internet_connection ();
		} catch (...) {
		}

		if (ret == false) {
			ACE_OS::sleep (1);
		}
	}

	return ret;
	//#UC END# *4AC072EB0291*
}

} // namespace Inet_i
} // namespace Internet

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

