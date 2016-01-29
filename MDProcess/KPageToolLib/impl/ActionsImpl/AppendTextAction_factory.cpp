////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/KPageToolLib/impl/ActionsImpl/AppendTextAction_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::KPageToolLib::ActionsImpl::AppendTextAction
//
// Реализация дейсвия APPEND. Читает текст страницы из файла и дописывает его в страницу.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/KPageToolLib/impl/ActionsImpl/AppendTextAction_factory.h"
#include "MDProcess/KPageToolLib/impl/ActionsImpl/AppendTextAction.h"

namespace KPageToolLib {
namespace ActionsImpl {

AppendTextAction_factory::AppendTextAction_factory () {
}

void AppendTextAction_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	Actions::KPageActionFactoryManager::register_factory (this, priority);
}

const Actions::PageActionsEnum AppendTextAction_factory::key () const {
	return Actions::PA_APPEND;
}

Actions::KPageAction* AppendTextAction_factory::get () {
	AppendTextAction_var ret = new AppendTextAction ();
	return ret._retn ();
}

} // namespace ActionsImpl
} // namespace KPageToolLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

