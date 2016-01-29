////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/impl/I18N_i/GarantWinLocaleOperations_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::I18N_i::GarantWinLocaleOperations
// Заголовк реализации фабрик интерфеса  для серванта GarantWinLocaleOperations
//
// к сожалению стандартная setlocale лажается на виндах без поддержки заданной локали, поэтому пока
// WinLocaleOperations был заменён на GarantWinLocaleOperations. См. [$111739591].
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCI_I18N_I_GARANTWINLOCALEOPERATIONS_FCTR_H__
#define __SHARED_GCI_I18N_I_GARANTWINLOCALEOPERATIONS_FCTR_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/I18N/I18NFactories.h"
#include "shared/GCI/impl/I18N_i/I18N_i.h"

namespace GCI {
namespace I18N_i {

/// Interface-factory implementation for GarantWinLocaleOperations
class GarantWinLocaleOperations_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public I18N::LocaleOperationsAbstractFactory
{
public:
	GarantWinLocaleOperations_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	I18N::LocaleOperations* make ();

};

typedef ::Core::Var<GarantWinLocaleOperations_factory> GarantWinLocaleOperations_factory_var;

} // namespace I18N_i
} // namespace GCI


#endif //__SHARED_GCI_I18N_I_GARANTWINLOCALEOPERATIONS_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

