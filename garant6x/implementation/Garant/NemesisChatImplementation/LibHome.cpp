////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/NemesisChatImplementation/LibHome.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<ServerLibrary::Category>> garant6x::NemesisChatImplementation
//
// ���������� ���� ��� �������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "garant6x/implementation/Garant/NemesisChatImplementation/LibHome.h"

namespace NemesisChatImplementation {

void LibHomeImpl::publish_all_servers_factories () const {
}

CoreSrv::Root::CorbaLibHome& LibHomeFactory::get () {
	return LibHomeImpl::Singleton::instance();
}

LibHomeImpl::LibHomeImpl () {
}

void LibHomeImpl::registrate_all_factories () const {
	//#UC START# *4A30E8E402C2_ENVIRONMENTS_CONFIG*
	//#UC END# *4A30E8E402C2_ENVIRONMENTS_CONFIG*

}
	
void LibHomeImpl::finalize () {
}
} // namespace NemesisChatImplementation

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
