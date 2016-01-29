////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/impl/I18N_i/LocaleOperationsHelper.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::I18N_i::LocaleOperationsHelper
// Заголовок реализации класса серванта для интерфеса LocaleOperations
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCI_I18N_I_LOCALEOPERATIONSHELPER_H__
#define __SHARED_GCI_I18N_I_LOCALEOPERATIONSHELPER_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/I18N/I18N.h"

namespace GCI {
namespace I18N_i {

class LocaleOperationsHelper; // self forward Var
typedef ::Core::Var<LocaleOperationsHelper> LocaleOperationsHelper_var;
typedef ::Core::Var<const LocaleOperationsHelper> LocaleOperationsHelper_cvar;

class LocaleOperationsHelper:
	virtual public I18N::LocaleOperations
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (LocaleOperationsHelper)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	LocaleOperationsHelper ();

	virtual ~LocaleOperationsHelper ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from I18N::LocaleOperations
	// возвращает значение локали по её текстовому представлению
	virtual I18N::SupportedLocales string_to_locale (const char* locale_text) const;
}; // class LocaleOperationsHelper

} // namespace I18N_i
} // namespace GCI


#endif //__SHARED_GCI_I18N_I_LOCALEOPERATIONSHELPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
