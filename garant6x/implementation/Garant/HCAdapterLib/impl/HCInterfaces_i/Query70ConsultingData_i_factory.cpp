////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/HCAdapterLib/impl/HCInterfaces_i/Query70ConsultingData_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::HCAdapterLib::HCInterfaces_i::Query70ConsultingData_i
//
// Реализация интерфейса запроса для СК сентября 2007 года (ф1 версии 7.0).
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/HCAdapterLib/impl/HCInterfaces_i/Query70ConsultingData_i_factory.h"
#include "garant6x/implementation/Garant/HCAdapterLib/impl/HCInterfaces_i/Query70ConsultingData_i.h"

namespace HCAdapterLib {
namespace HCInterfaces_i {

Query70ConsultingData_i_factory::Query70ConsultingData_i_factory () {
}

void Query70ConsultingData_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	HCInterfaces::OnlineDataFactoryManager::register_factory (this, priority);
}

const char* Query70ConsultingData_i_factory::key () const {
	return HCInterfaces::QUERY70;
}

HCInterfaces::OnlineData* Query70ConsultingData_i_factory::make (
	GCI::IO::Stream* xml_stream
	, const GblConsultingDef::ConsultationID& consultation_id
) {
	Query70ConsultingData_i_var ret = new Query70ConsultingData_i (xml_stream, consultation_id);
	return ret._retn ();
}

} // namespace HCInterfaces_i
} // namespace HCAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

