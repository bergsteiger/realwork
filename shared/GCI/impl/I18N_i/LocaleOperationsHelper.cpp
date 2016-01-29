////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/impl/I18N_i/LocaleOperationsHelper.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::I18N_i::LocaleOperationsHelper
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/LibHome.h"
#include "shared/GCI/impl/I18N_i/LocaleOperationsHelper.h"
#include "shared/GCI/impl/I18N_i/Environment.h"

namespace GCI {
namespace I18N_i {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

LocaleOperationsHelper::LocaleOperationsHelper ()
//#UC START# *452F6A8F0148_48F6F9050118_48F6EAF10271_BASE_INIT*
//#UC END# *452F6A8F0148_48F6F9050118_48F6EAF10271_BASE_INIT*
{
	//#UC START# *452F6A8F0148_48F6F9050118_48F6EAF10271_BODY*
	//#UC END# *452F6A8F0148_48F6F9050118_48F6EAF10271_BODY*
}

LocaleOperationsHelper::~LocaleOperationsHelper () {
	//#UC START# *48F6EAF10271_DESTR_BODY*
	//#UC END# *48F6EAF10271_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from I18N::LocaleOperations
// возвращает значение локали по её текстовому представлению
I18N::SupportedLocales LocaleOperationsHelper::string_to_locale (const char* locale_text) const {
	//#UC START# *45336B07004E_48F6EAF10271*
	if (locale_text && ACE_OS::strlen (locale_text) > 1) {
		unsigned char first = locale_text[0];
		unsigned char second = locale_text[1];

		if (((first == 'r') || (first == 'R')) && ((second == 'u') || (second == 'U'))) {
			return I18N::SL_RU_CP1251;
		}
		if (((first == 'e') || (first == 'E')) && ((second == 'n') || (second == 'N'))) {
			return I18N::SL_ENGLISH;
		}
		if (((first == 't') || (first == 'T')) && ((second == 't') || (second == 'T'))) {
			return I18N::SL_TATAR;
		}
	}

	GDS_ASSERT (false && "Unknown locale type");
	return GCI::I18N::SL_UNKNOWN;
	//#UC END# *45336B07004E_48F6EAF10271*
}
} // namespace I18N_i
} // namespace GCI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

