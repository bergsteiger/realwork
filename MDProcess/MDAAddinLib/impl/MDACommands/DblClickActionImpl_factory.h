////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/impl/MDACommands/DblClickActionImpl_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAAddinLib::MDACommands::DblClickActionImpl
// Заголовк реализации фабрик интерфеса DblClickAction для серванта DblClickActionImpl
//
// действие на дабл-клик
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_MDACOMMANDS_DBLCLICKACTIONIMPL_FCTR_H__
#define __MDPROCESS_MDAADDINLIB_MDACOMMANDS_DBLCLICKACTIONIMPL_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/Commands/CommandsFactories.h"

namespace MDACommands {

/// Interface-factory implementation for DblClickActionImpl
class DblClickActionImpl_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public Commands::DblClickActionAbstractFactory
{
public:
	DblClickActionImpl_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	Commands::DblClickAction* make ();

};

typedef ::Core::Var<DblClickActionImpl_factory> DblClickActionImpl_factory_var;

} // namespace MDACommands


#endif //__MDPROCESS_MDAADDINLIB_MDACOMMANDS_DBLCLICKACTIONIMPL_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

