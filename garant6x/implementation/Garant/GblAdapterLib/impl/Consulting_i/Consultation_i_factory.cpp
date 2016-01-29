////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Consulting_i/Consultation_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Consulting_i::Consultation_i
//
// реализация
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Consulting_i/Consultation_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Consulting_i/Consultation_i.h"

namespace GblAdapterLib {

Consultation_i_factory* Consultation_i_factory::s_instance = 0;

Consultation_i_factory::Consultation_i_factory () {
}

void Consultation_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	ConsultationFactoryManager::register_factory (this, priority);
	s_instance = this;
}

const char* Consultation_i_factory::key () const {
	return "Consultation_i";
}

Consultation* Consultation_i_factory::make (
	GblConsultingClient::Consultation* server_consultation
	, FoldersNode* folders_node
) {
	Consultation_i_var ret = new Consultation_i (server_consultation, folders_node);
	return ret._retn ();
}

Consultation_i* Consultation_iServantFactory::make (GblConsultingClient::Consultation* server_consultation, FoldersNode* folders_node) {
	if (Consultation_i_factory::s_instance) {
		return dynamic_cast<Consultation_i*>(Consultation_i_factory::s_instance->make (server_consultation, folders_node));
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Consulting_i::Consultation_i_factory");
	}
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

