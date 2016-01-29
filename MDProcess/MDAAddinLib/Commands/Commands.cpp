////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/Commands/Commands.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> MDProcess::MDAAddinLib::Commands
//
// интерфейсы для обработки MDA-команд
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/Commands/Commands.h"
#include "MDProcess/MDAAddinLib/Commands/CommandsFactories.h"

namespace Commands {

// factory interface wrapper for CmdManager
CmdManager& CmdManagerFactory::get () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return CmdManagerFactoryManager::Singleton::instance ()->get ();
}

// factory interface wrapper for DblClickAction
DblClickAction* DblClickActionFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return DblClickActionFactoryManager::Singleton::instance ()->make ();
}

} // namespace Commands

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

