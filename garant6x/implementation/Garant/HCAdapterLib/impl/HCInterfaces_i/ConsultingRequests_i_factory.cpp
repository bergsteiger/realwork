////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/HCAdapterLib/impl/HCInterfaces_i/ConsultingRequests_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::HCAdapterLib::HCInterfaces_i::ConsultingRequests_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/HCAdapterLib/impl/HCInterfaces_i/ConsultingRequests_i_factory.h"
#include "garant6x/implementation/Garant/HCAdapterLib/impl/HCInterfaces_i/ConsultingRequests_i.h"

namespace HCAdapterLib {
namespace HCInterfaces_i {

ConsultingRequests_i_factory::ConsultingRequests_i_factory () {
}

void ConsultingRequests_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	HCInterfaces::ConsultingRequestsFactoryManager::register_factory (this, priority);
}

const char* ConsultingRequests_i_factory::key () const {
	return "ConsultingRequests_i";
}

HCInterfaces::ConsultingRequests* ConsultingRequests_i_factory::make () {
	ConsultingRequests_i_var ret = new ConsultingRequests_i ();
	return ret._retn ();
}

} // namespace HCInterfaces_i
} // namespace HCAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

