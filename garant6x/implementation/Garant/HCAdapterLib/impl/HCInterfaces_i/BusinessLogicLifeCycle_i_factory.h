////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/HCAdapterLib/impl/HCInterfaces_i/BusinessLogicLifeCycle_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::HCAdapterLib::HCInterfaces_i::BusinessLogicLifeCycle_i
// Заголовк реализации фабрик интерфеса BusinessLogicLifeCycle для серванта BusinessLogicLifeCycle_i
//
// реализация соответствующего интерфейса
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_HCADAPTERLIB_HCINTERFACES_I_BUSINESSLOGICLIFECYCLE_I_FCTR_H__
#define __GARANT6X_HCADAPTERLIB_HCINTERFACES_I_BUSINESSLOGICLIFECYCLE_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/HCAdapterLib/HCInterfaces/HCInterfacesFactories.h"

namespace HCAdapterLib {
namespace HCInterfaces_i {

/// Interface-factory implementation for BusinessLogicLifeCycle_i
class BusinessLogicLifeCycle_i_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public HCInterfaces::BusinessLogicLifeCycleAbstractFactory
{
public:
	BusinessLogicLifeCycle_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	HCInterfaces::BusinessLogicLifeCycle* make ();

};

typedef ::Core::Var<BusinessLogicLifeCycle_i_factory> BusinessLogicLifeCycle_i_factory_var;

} // namespace HCInterfaces_i
} // namespace HCAdapterLib


#endif //__GARANT6X_HCADAPTERLIB_HCINTERFACES_I_BUSINESSLOGICLIFECYCLE_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

