////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/KPageToolLib/impl/ActionsImpl/AddAttachmentAction.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::KPageToolLib::ActionsImpl::AddAttachmentAction
// Заголовок реализации класса серванта для интерфеса KPageAction
//
// AddAttachmentAction
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_KPAGETOOLLIB_ACTIONSIMPL_ADDATTACHMENTACTION_H__
#define __MDPROCESS_KPAGETOOLLIB_ACTIONSIMPL_ADDATTACHMENTACTION_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/KPageToolLib/Actions/Actions.h"

namespace KPageToolLib {
namespace ActionsImpl {

class AddAttachmentAction; // self forward Var
typedef ::Core::Var<AddAttachmentAction> AddAttachmentAction_var;
typedef ::Core::Var<const AddAttachmentAction> AddAttachmentAction_cvar;

class AddAttachmentAction_factory;

// AddAttachmentAction
class AddAttachmentAction:
	virtual public Actions::KPageAction
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (AddAttachmentAction)
	friend class AddAttachmentAction_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	AddAttachmentAction ();

	virtual ~AddAttachmentAction ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Actions::KPageAction
	// Выполнить действие над страницей. Возвращает 0 - в случае удачи. 1 - в случае любой ошибки
	// (подробности в консольном окне).
	// page - собственно страница над которой нужно выполнить действие. page НЕ нужно класть в Var!
	virtual int execute (ServerGate::Contents::KPage* page);
}; // class AddAttachmentAction

} // namespace ActionsImpl
} // namespace KPageToolLib


#endif //__MDPROCESS_KPAGETOOLLIB_ACTIONSIMPL_ADDATTACHMENTACTION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
