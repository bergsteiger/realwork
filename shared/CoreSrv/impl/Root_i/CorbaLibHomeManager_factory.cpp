////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/CoreSrv/impl/Root_i/CorbaLibHomeManager_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::CoreSrv::Root_i::CorbaLibHomeManager
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/CoreSrv/impl/Root_i/CorbaLibHomeManager_factory.h"
#include "shared/CoreSrv/impl/Root_i/CorbaLibHomeManager.h"

namespace CoreSrv {
namespace Root_i {

CorbaLibHomeManager_factory::CorbaLibHomeManager_factory () {
}

void CorbaLibHomeManager_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	Core::Root::LibHomeManagerFactoryManager::register_factory (this, priority);
}

const char* CorbaLibHomeManager_factory::key () const {
	return "CorbaLibHomeManager";
}

Core::Root::LibHomeManager* CorbaLibHomeManager_factory::get () {
	CorbaLibHomeManager_var ret = new CorbaLibHomeManager ();
	return ret._retn ();
}

} // namespace Root_i
} // namespace CoreSrv

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

