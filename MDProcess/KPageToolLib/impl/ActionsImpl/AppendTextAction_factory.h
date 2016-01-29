////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/KPageToolLib/impl/ActionsImpl/AppendTextAction_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::KPageToolLib::ActionsImpl::AppendTextAction
// Заголовк реализации фабрик интерфеса KPageAction для серванта AppendTextAction
//
// Реализация дейсвия APPEND. Читает текст страницы из файла и дописывает его в страницу.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_KPAGETOOLLIB_ACTIONSIMPL_APPENDTEXTACTION_FCTR_H__
#define __MDPROCESS_KPAGETOOLLIB_ACTIONSIMPL_APPENDTEXTACTION_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/KPageToolLib/Actions/ActionsFactories.h"
#include "MDProcess/KPageToolLib/impl/ActionsImpl/ActionsImpl.h"

namespace KPageToolLib {
namespace ActionsImpl {

/// Interface-factory implementation for AppendTextAction
class AppendTextAction_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public Actions::KPageActionAbstractFactory
{
public:
	AppendTextAction_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const Actions::PageActionsEnum key () const;

	Actions::KPageAction* get ();

};

typedef ::Core::Var<AppendTextAction_factory> AppendTextAction_factory_var;

} // namespace ActionsImpl
} // namespace KPageToolLib


#endif //__MDPROCESS_KPAGETOOLLIB_ACTIONSIMPL_APPENDTEXTACTION_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

