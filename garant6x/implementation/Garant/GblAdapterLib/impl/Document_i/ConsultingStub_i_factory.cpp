////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ConsultingStub_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::ConsultingStub_i
//
// заглушка для документа-консультации К259180433
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ConsultingStub_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ConsultingStub_i.h"

namespace GblAdapterLib {

ConsultingStub_i_factory::ConsultingStub_i_factory () {
}

void ConsultingStub_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	ConsultingStubFactoryManager::register_factory (this, priority);
}

const char* ConsultingStub_i_factory::key () const {
	return "ConsultingStub_i";
}

ConsultingStub* ConsultingStub_i_factory::make_consulting_stub () {
	return Core::IObject::_duplicate (ConsultingStub_i::Singleton::instance());
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

