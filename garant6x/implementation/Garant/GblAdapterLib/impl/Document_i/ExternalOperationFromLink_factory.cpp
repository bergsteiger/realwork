////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ExternalOperationFromLink_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::ExternalOperationFromLink
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ExternalOperationFromLink_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ExternalOperationFromLink.h"

namespace GblAdapterLib {

ExternalOperationFromLink_factory::ExternalOperationFromLink_factory () {
}

void ExternalOperationFromLink_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	ObjectFromLinkFactoryManager::register_factory (this, priority);
}

const LinkedObjectType ExternalOperationFromLink_factory::key () const {
	return LO_EXTERNAL_OPERATION;
}

ObjectFromLink* ExternalOperationFromLink_factory::make (GblPilot::Link* server_link) {
	ExternalOperationFromLink_var ret = new ExternalOperationFromLink (server_link);
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

