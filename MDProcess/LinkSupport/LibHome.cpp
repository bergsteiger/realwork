////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/LinkSupport/LibHome.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<ServerLibrary::Category>> MDProcess::LinkSupport
//
// ��������� ��������� �� �������� � �������� � ����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "MDProcess/LinkSupport/LibHome.h"
#include "MDProcess/LinkSupport/ConfModelLinks/ConfModelLinksFactories.h"

namespace LinkSupport {

void LibHomeImpl::publish_all_servers_factories () const {
	ConfModelLinks::ShowOnModelMngFactoryManager::publish_self ();
}

CoreSrv::Root::CorbaLibHome& LibHomeFactory::get () {
	return LibHomeImpl::Singleton::instance();
}

LibHomeImpl::LibHomeImpl () {
}

void LibHomeImpl::registrate_all_factories () const {
	//#UC START# *468B884203C8_ENVIRONMENTS_CONFIG*
	//#UC END# *468B884203C8_ENVIRONMENTS_CONFIG*

}
	
void LibHomeImpl::finalize () {
}
} // namespace LinkSupport

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
