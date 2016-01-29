////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Internet/impl/Inet_i/Utility.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityClass::Class>> shared::Internet::Inet_i::Utility
//
// Утилитный класс
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_INTERNET_INET_I_UTILITY_H__
#define __SHARED_INTERNET_INET_I_UTILITY_H__

#include "shared/Core/sys/std_inc.h"

//#UC START# *4AC0725E0229_CUSTOM_INCLUDES*
//#UC END# *4AC0725E0229_CUSTOM_INCLUDES*

namespace Internet {
namespace Inet_i {

// Утилитный класс
class Utility {
	SET_OBJECT_COUNTER (Utility)
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// проверка соединения с интернет
	static bool has_internet_connection ();

	// расширенная проверка соединения с интернет (выполняется val проверок с паузой в 1 сек)
	static bool has_internet_connection_ex (size_t val);


//#UC START# *4AC0725E0229*
//#UC END# *4AC0725E0229*
}; // class Utility

} // namespace Inet_i
} // namespace Internet


#endif //__SHARED_INTERNET_INET_I_UTILITY_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

