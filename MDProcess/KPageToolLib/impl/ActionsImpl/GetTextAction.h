////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/KPageToolLib/impl/ActionsImpl/GetTextAction.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::KPageToolLib::ActionsImpl::GetTextAction
// Заголовок реализации класса серванта для интерфеса KPageAction
//
// Реализация дейсвия GET. Читает текст страницы К и записывает его в файл.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_KPAGETOOLLIB_ACTIONSIMPL_GETTEXTACTION_H__
#define __MDPROCESS_KPAGETOOLLIB_ACTIONSIMPL_GETTEXTACTION_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/KPageToolLib/Actions/Actions.h"

namespace KPageToolLib {
namespace ActionsImpl {

class GetTextAction; // self forward Var
typedef ::Core::Var<GetTextAction> GetTextAction_var;
typedef ::Core::Var<const GetTextAction> GetTextAction_cvar;

class GetTextAction_factory;

// Реализация дейсвия GET. Читает текст страницы К и записывает его в файл.
class GetTextAction:
	virtual public Actions::KPageAction
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (GetTextAction)
	friend class GetTextAction_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	GetTextAction ();

	virtual ~GetTextAction ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Actions::KPageAction
	// Выполнить действие над страницей. Возвращает 0 - в случае удачи. 1 - в случае любой ошибки
	// (подробности в консольном окне).
	// page - собственно страница над которой нужно выполнить действие. page НЕ нужно класть в Var!
	virtual int execute (ServerGate::Contents::KPage* page);
}; // class GetTextAction

} // namespace ActionsImpl
} // namespace KPageToolLib


#endif //__MDPROCESS_KPAGETOOLLIB_ACTIONSIMPL_GETTEXTACTION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
