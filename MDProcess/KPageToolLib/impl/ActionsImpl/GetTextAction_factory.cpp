////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/KPageToolLib/impl/ActionsImpl/GetTextAction_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::KPageToolLib::ActionsImpl::GetTextAction
//
// ���������� ������� GET. ������ ����� �������� � � ���������� ��� � ����.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/KPageToolLib/impl/ActionsImpl/GetTextAction_factory.h"
#include "MDProcess/KPageToolLib/impl/ActionsImpl/GetTextAction.h"

namespace KPageToolLib {
namespace ActionsImpl {

GetTextAction_factory::GetTextAction_factory () {
}

void GetTextAction_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	Actions::KPageActionFactoryManager::register_factory (this, priority);
}

const Actions::PageActionsEnum GetTextAction_factory::key () const {
	return Actions::PA_GET;
}

Actions::KPageAction* GetTextAction_factory::get () {
	GetTextAction_var ret = new GetTextAction ();
	return ret._retn ();
}

} // namespace ActionsImpl
} // namespace KPageToolLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

