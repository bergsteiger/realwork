////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/impl/MDACommands/MDACmdManager_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAAddinLib::MDACommands::MDACmdManager
// Заголовк реализации фабрик интерфеса CmdManager для серванта MDACmdManager
//
// менеджер MDA-команд
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_MDACOMMANDS_MDACMDMANAGER_FCTR_H__
#define __MDPROCESS_MDAADDINLIB_MDACOMMANDS_MDACMDMANAGER_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/Commands/CommandsFactories.h"

namespace MDACommands {

/// Interface-factory implementation for MDACmdManager
class MDACmdManager_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public Commands::CmdManagerAbstractFactory
{
public:
	MDACmdManager_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	Commands::CmdManager* get ();

};

typedef ::Core::Var<MDACmdManager_factory> MDACmdManager_factory_var;

} // namespace MDACommands


#endif //__MDPROCESS_MDAADDINLIB_MDACOMMANDS_MDACMDMANAGER_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

