////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/HCAdapterLib/impl/HCInterfaces_i/OfflineConsultingData_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::HCAdapterLib::HCInterfaces_i::OfflineConsultingData_i
//
// Реализация работы консультаций, доставляемых вручную.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/HCAdapterLib/impl/HCInterfaces_i/OfflineConsultingData_i_factory.h"
#include "garant6x/implementation/Garant/HCAdapterLib/impl/HCInterfaces_i/OfflineConsultingData_i.h"

namespace HCAdapterLib {
namespace HCInterfaces_i {

OfflineConsultingData_i_factory::OfflineConsultingData_i_factory () {
}

void OfflineConsultingData_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	HCInterfaces::OfflineDataFactoryManager::register_factory (this, priority);
}

const char* OfflineConsultingData_i_factory::key () const {
	return "OfflineConsultingData_i";
}

HCInterfaces::OfflineData* OfflineConsultingData_i_factory::make (GCI::IO::Stream* xml_stream) {
	OfflineConsultingData_i_var ret = new OfflineConsultingData_i (xml_stream);
	return ret._retn ();
}

} // namespace HCInterfaces_i
} // namespace HCAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

