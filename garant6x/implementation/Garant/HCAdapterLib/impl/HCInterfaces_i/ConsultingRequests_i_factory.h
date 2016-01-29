////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/HCAdapterLib/impl/HCInterfaces_i/ConsultingRequests_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::HCAdapterLib::HCInterfaces_i::ConsultingRequests_i
// Заголовк реализации фабрик интерфеса ConsultingRequests для серванта ConsultingRequests_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_HCADAPTERLIB_HCINTERFACES_I_CONSULTINGREQUESTS_I_FCTR_H__
#define __GARANT6X_HCADAPTERLIB_HCINTERFACES_I_CONSULTINGREQUESTS_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/HCAdapterLib/HCInterfaces/HCInterfacesFactories.h"

namespace HCAdapterLib {
namespace HCInterfaces_i {

/// Interface-factory implementation for ConsultingRequests_i
class ConsultingRequests_i_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public HCInterfaces::ConsultingRequestsAbstractFactory
{
public:
	ConsultingRequests_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	HCInterfaces::ConsultingRequests* make ();

};

typedef ::Core::Var<ConsultingRequests_i_factory> ConsultingRequests_i_factory_var;

} // namespace HCInterfaces_i
} // namespace HCAdapterLib


#endif //__GARANT6X_HCADAPTERLIB_HCINTERFACES_I_CONSULTINGREQUESTS_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

