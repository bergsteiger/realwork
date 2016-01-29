////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/HCAdapterLib/impl/HCInterfaces_i/OfflineConsultingData_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::HCAdapterLib::HCInterfaces_i::OfflineConsultingData_i
// Заголовк реализации фабрик интерфеса OfflineData для серванта OfflineConsultingData_i
//
// Реализация работы консультаций, доставляемых вручную.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_HCADAPTERLIB_HCINTERFACES_I_OFFLINECONSULTINGDATA_I_FCTR_H__
#define __GARANT6X_HCADAPTERLIB_HCINTERFACES_I_OFFLINECONSULTINGDATA_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/HCAdapterLib/HCInterfaces/HCInterfacesFactories.h"

namespace HCAdapterLib {
namespace HCInterfaces_i {

/// Interface-factory implementation for OfflineConsultingData_i
class OfflineConsultingData_i_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public HCInterfaces::OfflineDataAbstractFactory
{
public:
	OfflineConsultingData_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	HCInterfaces::OfflineData* make (GCI::IO::Stream* xml_stream);

};

typedef ::Core::Var<OfflineConsultingData_i_factory> OfflineConsultingData_i_factory_var;

} // namespace HCInterfaces_i
} // namespace HCAdapterLib


#endif //__GARANT6X_HCADAPTERLIB_HCINTERFACES_I_OFFLINECONSULTINGDATA_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

