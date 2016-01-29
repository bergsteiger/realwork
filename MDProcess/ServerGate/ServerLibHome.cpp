////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/ServerGate/ServerLibHome.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<ServerLibrary::Category>> MDProcess::ServerGate
//
// ��������� ���������� ��� ��������� ��������� � �
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "MDProcess/ServerGate/ServerLibHome.h"

namespace ServerGate {

Core::Root::LibHome& ServerLibHomeFactory::get () {
	return ServerLibHomeImpl::Singleton::instance();
}

ServerLibHomeImpl::ServerLibHomeImpl () {
	this->set_requested_status (Core::Root::ES_IDLE);
}

void ServerLibHomeImpl::registrate_all_factories () const {
	//#UC START# *4614D4F6009C_ENVIRONMENTS_CONFIG*
	//#UC END# *4614D4F6009C_ENVIRONMENTS_CONFIG*

}
	
void ServerLibHomeImpl::finalize () {
}
} // namespace ServerGate

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
