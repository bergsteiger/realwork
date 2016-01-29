////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/KPageToolLib/impl/ActionsImpl/AddAttachmentAction_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::KPageToolLib::ActionsImpl::AddAttachmentAction
// Заголовк реализации фабрик интерфеса KPageAction для серванта AddAttachmentAction
//
// AddAttachmentAction
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_KPAGETOOLLIB_ACTIONSIMPL_ADDATTACHMENTACTION_FCTR_H__
#define __MDPROCESS_KPAGETOOLLIB_ACTIONSIMPL_ADDATTACHMENTACTION_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/KPageToolLib/Actions/ActionsFactories.h"
#include "MDProcess/KPageToolLib/impl/ActionsImpl/ActionsImpl.h"

namespace KPageToolLib {
namespace ActionsImpl {

/// Interface-factory implementation for AddAttachmentAction
class AddAttachmentAction_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public Actions::KPageActionAbstractFactory
{
public:
	AddAttachmentAction_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const Actions::PageActionsEnum key () const;

	Actions::KPageAction* get ();

};

typedef ::Core::Var<AddAttachmentAction_factory> AddAttachmentAction_factory_var;

} // namespace ActionsImpl
} // namespace KPageToolLib


#endif //__MDPROCESS_KPAGETOOLLIB_ACTIONSIMPL_ADDATTACHMENTACTION_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

