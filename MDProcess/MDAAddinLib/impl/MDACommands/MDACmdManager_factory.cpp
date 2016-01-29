////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/impl/MDACommands/MDACmdManager_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAAddinLib::MDACommands::MDACmdManager
//
// менеджер MDA-команд
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/impl/MDACommands/MDACmdManager_factory.h"
#include "MDProcess/MDAAddinLib/impl/MDACommands/MDACmdManager.h"

namespace MDACommands {

MDACmdManager_factory::MDACmdManager_factory () {
}

void MDACmdManager_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	Commands::CmdManagerFactoryManager::register_factory (this, priority);
}

const char* MDACmdManager_factory::key () const {
	return "MDACmdManager";
}

Commands::CmdManager* MDACmdManager_factory::get () {
	MDACmdManager_var ret = new MDACmdManager ();
	return ret._retn ();
}

} // namespace MDACommands

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

