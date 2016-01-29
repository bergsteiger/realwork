////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/impl/I18N_i/PosixLocaleOperations.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::I18N_i::PosixLocaleOperations
// Заголовок реализации класса серванта для интерфеса 
//
// установка локали для posix систем.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCI_I18N_I_POSIXLOCALEOPERATIONS_H__
#define __SHARED_GCI_I18N_I_POSIXLOCALEOPERATIONS_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/impl/I18N_i/LocaleOperationsHelper.h"

//#UC START# *48F6F18501B0_CUSTOM_INCLUDES*
//#UC END# *48F6F18501B0_CUSTOM_INCLUDES*

namespace GCI {
namespace I18N_i {

class PosixLocaleOperations; // self forward Var
typedef ::Core::Var<PosixLocaleOperations> PosixLocaleOperations_var;
typedef ::Core::Var<const PosixLocaleOperations> PosixLocaleOperations_cvar;

class PosixLocaleOperations_factory;

// установка локали для posix систем.
class PosixLocaleOperations:
	virtual public LocaleOperationsHelper
{
	SET_OBJECT_COUNTER (PosixLocaleOperations)
	friend class PosixLocaleOperations_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	PosixLocaleOperations ();

	virtual ~PosixLocaleOperations ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from I18N::LocaleOperations
	// возвращает текущую локаль
	virtual I18N::SupportedLocales get_locale () const;

	// implemented method from I18N::LocaleOperations
	// устанавливает текущую локаль.
	virtual void set_locale (I18N::SupportedLocales locale);

//#UC START# *48F6F18501B0*
//#UC END# *48F6F18501B0*
}; // class PosixLocaleOperations

} // namespace I18N_i
} // namespace GCI


#endif //__SHARED_GCI_I18N_I_POSIXLOCALEOPERATIONS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
