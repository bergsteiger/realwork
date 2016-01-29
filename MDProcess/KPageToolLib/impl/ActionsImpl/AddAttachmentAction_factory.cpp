////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/KPageToolLib/impl/ActionsImpl/AddAttachmentAction_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::KPageToolLib::ActionsImpl::AddAttachmentAction
//
// AddAttachmentAction
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/KPageToolLib/impl/ActionsImpl/AddAttachmentAction_factory.h"
#include "MDProcess/KPageToolLib/impl/ActionsImpl/AddAttachmentAction.h"

namespace KPageToolLib {
namespace ActionsImpl {

AddAttachmentAction_factory::AddAttachmentAction_factory () {
}

void AddAttachmentAction_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	Actions::KPageActionFactoryManager::register_factory (this, priority);
}

const Actions::PageActionsEnum AddAttachmentAction_factory::key () const {
	return Actions::PA_ATTACH;
}

Actions::KPageAction* AddAttachmentAction_factory::get () {
	AddAttachmentAction_var ret = new AddAttachmentAction ();
	return ret._retn ();
}

} // namespace ActionsImpl
} // namespace KPageToolLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

