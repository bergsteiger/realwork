////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/KPageToolLib/impl/ActionsImpl/GetTextAction_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::KPageToolLib::ActionsImpl::GetTextAction
// Заголовк реализации фабрик интерфеса KPageAction для серванта GetTextAction
//
// Реализация дейсвия GET. Читает текст страницы К и записывает его в файл.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_KPAGETOOLLIB_ACTIONSIMPL_GETTEXTACTION_FCTR_H__
#define __MDPROCESS_KPAGETOOLLIB_ACTIONSIMPL_GETTEXTACTION_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/KPageToolLib/Actions/ActionsFactories.h"
#include "MDProcess/KPageToolLib/impl/ActionsImpl/ActionsImpl.h"

namespace KPageToolLib {
namespace ActionsImpl {

/// Interface-factory implementation for GetTextAction
class GetTextAction_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public Actions::KPageActionAbstractFactory
{
public:
	GetTextAction_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const Actions::PageActionsEnum key () const;

	Actions::KPageAction* get ();

};

typedef ::Core::Var<GetTextAction_factory> GetTextAction_factory_var;

} // namespace ActionsImpl
} // namespace KPageToolLib


#endif //__MDPROCESS_KPAGETOOLLIB_ACTIONSIMPL_GETTEXTACTION_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

