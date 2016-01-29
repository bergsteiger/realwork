////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GSI/impl/NotifyService_i/Manager_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::GSI::NotifyService_i::Manager_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/GSI/impl/NotifyService_i/Manager_i_factory.h"
#include "shared/GSI/impl/NotifyService_i/Manager_i.h"
#include "shared/GSI/impl/NotifyService_i/Environment.h"

namespace GSI {
namespace NotifyService_i {

Manager_i_factory::Manager_i_factory () {
}

void Manager_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	ManagerLocalFactoryManager::register_factory (this, priority);
}

const char* Manager_i_factory::key () const {
	return "Manager_i";
}

NotifyService::Manager* Manager_i_factory::make () {
	Manager_i_var ret = new Manager_i ();
	return ret._retn ();
}

} // namespace NotifyService_i
} // namespace GSI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

