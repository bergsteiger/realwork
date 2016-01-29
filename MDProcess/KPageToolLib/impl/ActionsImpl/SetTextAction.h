////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/KPageToolLib/impl/ActionsImpl/SetTextAction.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::KPageToolLib::ActionsImpl::SetTextAction
// Заголовок реализации класса серванта для интерфеса KPageAction
//
// Реализация дейсвия SET. Читает текст страницы из файла и записывает его в страницу.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_KPAGETOOLLIB_ACTIONSIMPL_SETTEXTACTION_H__
#define __MDPROCESS_KPAGETOOLLIB_ACTIONSIMPL_SETTEXTACTION_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/KPageToolLib/Actions/Actions.h"

namespace KPageToolLib {
namespace ActionsImpl {

class SetTextAction; // self forward Var
typedef ::Core::Var<SetTextAction> SetTextAction_var;
typedef ::Core::Var<const SetTextAction> SetTextAction_cvar;

class SetTextAction_factory;

// Реализация дейсвия SET. Читает текст страницы из файла и записывает его в страницу.
class SetTextAction:
	virtual public Actions::KPageAction
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (SetTextAction)
	friend class SetTextAction_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	SetTextAction ();

	virtual ~SetTextAction ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Actions::KPageAction
	// Выполнить действие над страницей. Возвращает 0 - в случае удачи. 1 - в случае любой ошибки
	// (подробности в консольном окне).
	// page - собственно страница над которой нужно выполнить действие. page НЕ нужно класть в Var!
	virtual int execute (ServerGate::Contents::KPage* page);
}; // class SetTextAction

} // namespace ActionsImpl
} // namespace KPageToolLib


#endif //__MDPROCESS_KPAGETOOLLIB_ACTIONSIMPL_SETTEXTACTION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
