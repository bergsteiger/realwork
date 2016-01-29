////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Consulting_i/ConsultationManager_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Consulting_i::ConsultationManager_i
//
// реализация
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Consulting_i/ConsultationManager_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Consulting_i/ConsultationManager_i.h"

namespace GblAdapterLib {

ConsultationManager_i_factory::ConsultationManager_i_factory () {
}

void ConsultationManager_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	ConsultationManagerFactoryManager::register_factory (this, priority);
}

const char* ConsultationManager_i_factory::key () const {
	return "ConsultationManager_i";
}

ConsultationManager* ConsultationManager_i_factory::make () {
	ConsultationManager_i_var ret = new ConsultationManager_i ();
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

