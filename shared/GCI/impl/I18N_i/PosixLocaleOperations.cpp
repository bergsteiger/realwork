////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/impl/I18N_i/PosixLocaleOperations.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::I18N_i::PosixLocaleOperations
//
// установка локали для posix систем.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/LibHome.h"
#include "shared/GCI/impl/I18N_i/PosixLocaleOperations.h"
#include "shared/GCI/impl/I18N_i/Environment.h"

//#UC START# *48F6F18501B0_CUSTOM_INCLUDES*
#include <clocale>
//#UC END# *48F6F18501B0_CUSTOM_INCLUDES*

namespace GCI {
namespace I18N_i {

//#UC START# *48F6F18501B0*
//#UC END# *48F6F18501B0*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

PosixLocaleOperations::PosixLocaleOperations ()
//#UC START# *452F6A8F0148_48F6F9050118_48F6F18501B0_BASE_INIT*
//#UC END# *452F6A8F0148_48F6F9050118_48F6F18501B0_BASE_INIT*
{
	//#UC START# *452F6A8F0148_48F6F9050118_48F6F18501B0_BODY*
	//#UC END# *452F6A8F0148_48F6F9050118_48F6F18501B0_BODY*
}

PosixLocaleOperations::~PosixLocaleOperations () {
	//#UC START# *48F6F18501B0_DESTR_BODY*
	//#UC END# *48F6F18501B0_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from I18N::LocaleOperations
// возвращает текущую локаль
I18N::SupportedLocales PosixLocaleOperations::get_locale () const {
	//#UC START# *452F720B00CB_48F6F18501B0*
	const char* locale = std::setlocale (LC_ALL, 0);
	if (ACE_OS::strnstr (locale, "ru", sizeof ("ru") - 1) == locale) {
		return GCI::I18N::SL_RU_CP1251;
	}
	if (ACE_OS::strnstr (locale, "en", sizeof ("en") - 1) == locale) {
		return GCI::I18N::SL_ENGLISH;
	}
	if (ACE_OS::strnstr (locale, "tt", sizeof ("tt") - 1) == locale) {
		return GCI::I18N::SL_TATAR;
	}

	GDS_ASSERT (false && "Unknown locale type");
	return GCI::I18N::SL_UNKNOWN;
	//#UC END# *452F720B00CB_48F6F18501B0*
}

// implemented method from I18N::LocaleOperations
// устанавливает текущую локаль.
void PosixLocaleOperations::set_locale (I18N::SupportedLocales locale) {
	//#UC START# *452F71DA0203_48F6F18501B0*
	switch (locale) {
		case GCI::I18N::SL_ENGLISH:
			std::setlocale (LC_ALL, "en_US.UTF-8");
			break;
		case GCI::I18N::SL_RU_CP1251:
			std::setlocale (LC_ALL, "ru_RU.CP1251");
			break;
		case GCI::I18N::SL_TATAR:
			std::setlocale (LC_ALL, "tt_RU.CP1251");
			break;
		default:
			GDS_ASSERT (false && "Unknown locale type");
	}
	//#UC END# *452F71DA0203_48F6F18501B0*
}
} // namespace I18N_i
} // namespace GCI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

