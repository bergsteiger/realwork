////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/KPageToolLib/impl/ActionsImpl/SetLabelAction_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::KPageToolLib::ActionsImpl::SetLabelAction
//
// установить лэйблы
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/KPageToolLib/impl/ActionsImpl/SetLabelAction_factory.h"
#include "MDProcess/KPageToolLib/impl/ActionsImpl/SetLabelAction.h"

namespace KPageToolLib {
namespace ActionsImpl {

SetLabelAction_factory::SetLabelAction_factory () {
}

void SetLabelAction_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	Actions::KPageActionFactoryManager::register_factory (this, priority);
}

const Actions::PageActionsEnum SetLabelAction_factory::key () const {
	return Actions::PA_SET_LABEL;
}

Actions::KPageAction* SetLabelAction_factory::get () {
	SetLabelAction_var ret = new SetLabelAction ();
	return ret._retn ();
}

} // namespace ActionsImpl
} // namespace KPageToolLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

