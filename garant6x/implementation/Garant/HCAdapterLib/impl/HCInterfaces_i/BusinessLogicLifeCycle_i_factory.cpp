////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/HCAdapterLib/impl/HCInterfaces_i/BusinessLogicLifeCycle_i_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::HCAdapterLib::HCInterfaces_i::BusinessLogicLifeCycle_i
//
// ���������� ���������������� ����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/HCAdapterLib/impl/HCInterfaces_i/BusinessLogicLifeCycle_i_factory.h"
#include "garant6x/implementation/Garant/HCAdapterLib/impl/HCInterfaces_i/BusinessLogicLifeCycle_i.h"

namespace HCAdapterLib {
namespace HCInterfaces_i {

BusinessLogicLifeCycle_i_factory::BusinessLogicLifeCycle_i_factory () {
}

void BusinessLogicLifeCycle_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	HCInterfaces::BusinessLogicLifeCycleFactoryManager::register_factory (this, priority);
}

const char* BusinessLogicLifeCycle_i_factory::key () const {
	return "BusinessLogicLifeCycle_i";
}

HCInterfaces::BusinessLogicLifeCycle* BusinessLogicLifeCycle_i_factory::make () {
	return Core::IObject::_duplicate (BusinessLogicLifeCycle_i::Singleton::instance());
}

} // namespace HCInterfaces_i
} // namespace HCAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

