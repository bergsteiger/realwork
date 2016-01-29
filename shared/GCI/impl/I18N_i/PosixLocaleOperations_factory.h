////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/impl/I18N_i/PosixLocaleOperations_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::I18N_i::PosixLocaleOperations
// Заголовк реализации фабрик интерфеса  для серванта PosixLocaleOperations
//
// установка локали для posix систем.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCI_I18N_I_POSIXLOCALEOPERATIONS_FCTR_H__
#define __SHARED_GCI_I18N_I_POSIXLOCALEOPERATIONS_FCTR_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/I18N/I18NFactories.h"
#include "shared/GCI/impl/I18N_i/I18N_i.h"

namespace GCI {
namespace I18N_i {

/// Interface-factory implementation for PosixLocaleOperations
class PosixLocaleOperations_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public I18N::LocaleOperationsAbstractFactory
{
public:
	PosixLocaleOperations_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	I18N::LocaleOperations* make ();

};

typedef ::Core::Var<PosixLocaleOperations_factory> PosixLocaleOperations_factory_var;

} // namespace I18N_i
} // namespace GCI


#endif //__SHARED_GCI_I18N_I_POSIXLOCALEOPERATIONS_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

