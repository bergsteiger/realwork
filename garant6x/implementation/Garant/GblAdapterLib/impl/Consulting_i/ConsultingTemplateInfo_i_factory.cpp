////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Consulting_i/ConsultingTemplateInfo_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Consulting_i::ConsultingTemplateInfo_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Consulting_i/ConsultingTemplateInfo_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Consulting_i/ConsultingTemplateInfo_i.h"

namespace GblAdapterLib {

ConsultingTemplateInfo_i_factory::ConsultingTemplateInfo_i_factory () {
}

void ConsultingTemplateInfo_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	ConsultingTemplateInfoFactoryManager::register_factory (this, priority);
}

const char* ConsultingTemplateInfo_i_factory::key () const {
	return "ConsultingTemplateInfo_i";
}

ConsultingTemplateInfo* ConsultingTemplateInfo_i_factory::make () {
	return Core::IObject::_duplicate (ConsultingTemplateInfo_i::Singleton::instance());
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

