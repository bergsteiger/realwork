////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/KPageToolLib/impl/ActionsImpl/GetLabelAction_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::KPageToolLib::ActionsImpl::GetLabelAction
//
// получить лэйблы
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/KPageToolLib/impl/ActionsImpl/GetLabelAction_factory.h"
#include "MDProcess/KPageToolLib/impl/ActionsImpl/GetLabelAction.h"

namespace KPageToolLib {
namespace ActionsImpl {

GetLabelAction_factory::GetLabelAction_factory () {
}

void GetLabelAction_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	Actions::KPageActionFactoryManager::register_factory (this, priority);
}

const Actions::PageActionsEnum GetLabelAction_factory::key () const {
	return Actions::PA_GET_LABEL;
}

Actions::KPageAction* GetLabelAction_factory::get () {
	GetLabelAction_var ret = new GetLabelAction ();
	return ret._retn ();
}

} // namespace ActionsImpl
} // namespace KPageToolLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

