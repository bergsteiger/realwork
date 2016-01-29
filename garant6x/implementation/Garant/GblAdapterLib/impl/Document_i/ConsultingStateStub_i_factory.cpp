////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ConsultingStateStub_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::ConsultingStateStub_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ConsultingStateStub_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ConsultingStateStub_i.h"

namespace GblAdapterLib {

ConsultingStateStub_i_factory::ConsultingStateStub_i_factory () {
}

void ConsultingStateStub_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	ConsultingStateStubFactoryManager::register_factory (this, priority);
}

const char* ConsultingStateStub_i_factory::key () const {
	return "ConsultingStateStub_i";
}

ConsultingStateStub* ConsultingStateStub_i_factory::make_stub () {
	return Core::IObject::_duplicate (ConsultingStateStub_i::Singleton::instance());
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

