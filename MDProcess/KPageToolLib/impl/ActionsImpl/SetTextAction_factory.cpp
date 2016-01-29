////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/KPageToolLib/impl/ActionsImpl/SetTextAction_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::KPageToolLib::ActionsImpl::SetTextAction
//
// Реализация дейсвия SET. Читает текст страницы из файла и записывает его в страницу.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/KPageToolLib/impl/ActionsImpl/SetTextAction_factory.h"
#include "MDProcess/KPageToolLib/impl/ActionsImpl/SetTextAction.h"

namespace KPageToolLib {
namespace ActionsImpl {

SetTextAction_factory::SetTextAction_factory () {
}

void SetTextAction_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	Actions::KPageActionFactoryManager::register_factory (this, priority);
}

const Actions::PageActionsEnum SetTextAction_factory::key () const {
	return Actions::PA_SET;
}

Actions::KPageAction* SetTextAction_factory::get () {
	SetTextAction_var ret = new SetTextAction ();
	return ret._retn ();
}

} // namespace ActionsImpl
} // namespace KPageToolLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

