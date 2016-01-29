////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/KPageToolLib/impl/ActionsImpl/GetLabelAction.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::KPageToolLib::ActionsImpl::GetLabelAction
// Заголовок реализации класса серванта для интерфеса KPageAction
//
// получить лэйблы
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_KPAGETOOLLIB_ACTIONSIMPL_GETLABELACTION_H__
#define __MDPROCESS_KPAGETOOLLIB_ACTIONSIMPL_GETLABELACTION_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/KPageToolLib/Actions/Actions.h"

namespace KPageToolLib {
namespace ActionsImpl {

class GetLabelAction; // self forward Var
typedef ::Core::Var<GetLabelAction> GetLabelAction_var;
typedef ::Core::Var<const GetLabelAction> GetLabelAction_cvar;

class GetLabelAction_factory;

// получить лэйблы
class GetLabelAction:
	virtual public Actions::KPageAction
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (GetLabelAction)
	friend class GetLabelAction_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	GetLabelAction ();

	virtual ~GetLabelAction ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Actions::KPageAction
	// Выполнить действие над страницей. Возвращает 0 - в случае удачи. 1 - в случае любой ошибки
	// (подробности в консольном окне).
	// page - собственно страница над которой нужно выполнить действие. page НЕ нужно класть в Var!
	virtual int execute (ServerGate::Contents::KPage* page);
}; // class GetLabelAction

} // namespace ActionsImpl
} // namespace KPageToolLib


#endif //__MDPROCESS_KPAGETOOLLIB_ACTIONSIMPL_GETLABELACTION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
