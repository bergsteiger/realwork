////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/impl/I18N_i/GarantWinLocaleOperations.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::I18N_i::GarantWinLocaleOperations
// Заголовок реализации класса серванта для интерфеса 
//
// к сожалению стандартная setlocale лажается на виндах без поддержки заданной локали, поэтому пока
// WinLocaleOperations был заменён на GarantWinLocaleOperations. См. [$111739591].
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCI_I18N_I_GARANTWINLOCALEOPERATIONS_H__
#define __SHARED_GCI_I18N_I_GARANTWINLOCALEOPERATIONS_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/I18N/I18N.h"
#include "shared/GCI/impl/I18N_i/LocaleOperationsHelper.h"

namespace GCI {
namespace I18N_i {

class GarantWinLocaleOperations; // self forward Var
typedef ::Core::Var<GarantWinLocaleOperations> GarantWinLocaleOperations_var;
typedef ::Core::Var<const GarantWinLocaleOperations> GarantWinLocaleOperations_cvar;

class GarantWinLocaleOperations_factory;

// к сожалению стандартная setlocale лажается на виндах без поддержки заданной локали, поэтому пока
// WinLocaleOperations был заменён на GarantWinLocaleOperations. См. [$111739591].
class GarantWinLocaleOperations:
	virtual public LocaleOperationsHelper
{
	SET_OBJECT_COUNTER (GarantWinLocaleOperations)
	friend class GarantWinLocaleOperations_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	GarantWinLocaleOperations ();

	virtual ~GarantWinLocaleOperations ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	I18N::SupportedLocales m_win_locale;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from I18N::LocaleOperations
	// возвращает текущую локаль
	virtual I18N::SupportedLocales get_locale () const;

	// implemented method from I18N::LocaleOperations
	// устанавливает текущую локаль.
	virtual void set_locale (I18N::SupportedLocales locale);
}; // class GarantWinLocaleOperations

} // namespace I18N_i
} // namespace GCI


#endif //__SHARED_GCI_I18N_I_GARANTWINLOCALEOPERATIONS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
