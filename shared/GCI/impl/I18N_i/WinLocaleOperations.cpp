////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/impl/I18N_i/WinLocaleOperations.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::I18N_i::WinLocaleOperations
//
// установка локали в win32 системах
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/LibHome.h"
#include "shared/GCI/impl/I18N_i/WinLocaleOperations.h"
#include "shared/GCI/impl/I18N_i/Environment.h"

//#UC START# *48F6F14900DE_CUSTOM_INCLUDES*
#include <clocale>
//#UC END# *48F6F14900DE_CUSTOM_INCLUDES*

namespace GCI {
namespace I18N_i {

//#UC START# *48F6F14900DE*
//#UC END# *48F6F14900DE*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

WinLocaleOperations::WinLocaleOperations ()
//#UC START# *452F6A8F0148_48F6F9050118_48F6F14900DE_BASE_INIT*
//#UC END# *452F6A8F0148_48F6F9050118_48F6F14900DE_BASE_INIT*
{
	//#UC START# *452F6A8F0148_48F6F9050118_48F6F14900DE_BODY*
	//#UC END# *452F6A8F0148_48F6F9050118_48F6F14900DE_BODY*
}

WinLocaleOperations::~WinLocaleOperations () {
	//#UC START# *48F6F14900DE_DESTR_BODY*
	//#UC END# *48F6F14900DE_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from I18N::LocaleOperations
// возвращает текущую локаль
I18N::SupportedLocales WinLocaleOperations::get_locale () const {
	//#UC START# *452F720B00CB_48F6F14900DE*
	const char* locale = std::setlocale (LC_ALL, 0);
	if (ACE_OS::strnstr (locale, "Rus", sizeof ("Rus") - 1) == locale) {
	  return GCI::I18N::SL_RU_CP1251;
	}
	if (ACE_OS::strnstr (locale, "Eng", sizeof ("Eng") - 1) == locale) {
	  return GCI::I18N::SL_ENGLISH;
	}
	if (ACE_OS::strnstr (locale, "Tat", sizeof ("Tat") - 1) == locale) {
	  return GCI::I18N::SL_TATAR;
	}

	GDS_ASSERT (false && "Unknown locale type");
	return GCI::I18N::SL_UNKNOWN;
	//#UC END# *452F720B00CB_48F6F14900DE*
}

// implemented method from I18N::LocaleOperations
// устанавливает текущую локаль.
void WinLocaleOperations::set_locale (I18N::SupportedLocales locale) {
	//#UC START# *452F71DA0203_48F6F14900DE*
	switch (locale) {
	  case GCI::I18N::SL_ENGLISH:
		  std::setlocale (LC_ALL, "eng");
		  break;
	  case GCI::I18N::SL_RU_CP1251:
		  std::setlocale (LC_ALL, "rus_rus.1251");
		  break;
	  case GCI::I18N::SL_TATAR:
		  std::setlocale (LC_ALL, "Tatar_rus.1251");
		  break;
	  default:
		  GDS_ASSERT (false && "Unknown locale type");
	}
	//#UC END# *452F71DA0203_48F6F14900DE*
}
} // namespace I18N_i
} // namespace GCI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

