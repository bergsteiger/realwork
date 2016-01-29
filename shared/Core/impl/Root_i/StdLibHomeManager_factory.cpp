////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/impl/Root_i/StdLibHomeManager_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::Core::Root_i::StdLibHomeManager
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "ace/ACE.h"
#include "shared/Core/impl/Root_i/StdLibHomeManager_factory.h"
#include "shared/Core/impl/Root_i/StdLibHomeManager.h"

namespace Core {
namespace Root_i {

StdLibHomeManager_factory::StdLibHomeManager_factory () {
}

void StdLibHomeManager_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	Root::LibHomeManagerFactoryManager::register_factory (this, priority);
}

const char* StdLibHomeManager_factory::key () const {
	return "StdLibHomeManager";
}

Root::LibHomeManager* StdLibHomeManager_factory::get () {
	StdLibHomeManager_var ret = new StdLibHomeManager ();
	return ret._retn ();
}

} // namespace Root_i
} // namespace Core

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

