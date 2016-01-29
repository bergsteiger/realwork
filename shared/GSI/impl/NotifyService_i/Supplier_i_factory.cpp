////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/GSI/impl/NotifyService_i/Supplier_i_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::GSI::NotifyService_i::Supplier_i
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/GSI/impl/NotifyService_i/Supplier_i_factory.h"
#include "shared/GSI/impl/NotifyService_i/Supplier_i.h"
#include "shared/GSI/impl/NotifyService_i/Environment.h"

namespace GSI {
namespace NotifyService_i {

Supplier_i_factory::Supplier_i_factory () {
}

void Supplier_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	NotifyService::SupplierFactoryManager::register_factory (this, priority);
}

const char* Supplier_i_factory::key () const {
	return "Supplier_i";
}

NotifyService::Supplier* Supplier_i_factory::make () {
	Supplier_i_var ret = new Supplier_i ();
	return ret._retn ();
}

} // namespace NotifyService_i
} // namespace GSI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

