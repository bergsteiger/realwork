////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/HCAdapterLib/impl/HCInterfaces_i/MarkConsultingData70_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::HCAdapterLib::HCInterfaces_i::MarkConsultingData70_i
//
// оценка для СК версии 7.0
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/HCAdapterLib/impl/HCInterfaces_i/MarkConsultingData70_i_factory.h"
#include "garant6x/implementation/Garant/HCAdapterLib/impl/HCInterfaces_i/MarkConsultingData70_i.h"

namespace HCAdapterLib {
namespace HCInterfaces_i {

MarkConsultingData70_i_factory::MarkConsultingData70_i_factory () {
}

void MarkConsultingData70_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	HCInterfaces::OnlineDataFactoryManager::register_factory (this, priority);
}

const char* MarkConsultingData70_i_factory::key () const {
	return HCInterfaces::MARK70;
}

HCInterfaces::OnlineData* MarkConsultingData70_i_factory::make (
	GCI::IO::Stream* xml_stream
	, const GblConsultingDef::ConsultationID& consultation_id
) {
	MarkConsultingData70_i_var ret = new MarkConsultingData70_i (xml_stream, consultation_id);
	return ret._retn ();
}

} // namespace HCInterfaces_i
} // namespace HCAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

