////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/impl/MDACommands/DblClickActionImpl_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAAddinLib::MDACommands::DblClickActionImpl
//
// действие на дабл-клик
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/impl/MDACommands/DblClickActionImpl_factory.h"
#include "MDProcess/MDAAddinLib/impl/MDACommands/DblClickActionImpl.h"

namespace MDACommands {

DblClickActionImpl_factory::DblClickActionImpl_factory () {
}

void DblClickActionImpl_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	Commands::DblClickActionFactoryManager::register_factory (this, priority);
}

const char* DblClickActionImpl_factory::key () const {
	return "DblClickActionImpl";
}

Commands::DblClickAction* DblClickActionImpl_factory::make () {
	DblClickActionImpl_var ret = new DblClickActionImpl ();
	return ret._retn ();
}

} // namespace MDACommands

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

