////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/ChatLibrary/ServerLibHome.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<ServerLibrary::Category>> shared::ChatLibrary
//
// ���������� ������ �����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/ChatLibrary/ServerLibHome.h"

namespace ChatLibrary {

Core::Root::LibHome& ServerLibHomeFactory::get () {
	return ServerLibHomeImpl::Singleton::instance();
}

ServerLibHomeImpl::ServerLibHomeImpl () {
	this->set_requested_status (Core::Root::ES_IDLE);
}

void ServerLibHomeImpl::registrate_all_factories () const {
	//#UC START# *4A2E061E0198_ENVIRONMENTS_CONFIG*
	//#UC END# *4A2E061E0198_ENVIRONMENTS_CONFIG*

}
	
void ServerLibHomeImpl::finalize () {
}
} // namespace ChatLibrary

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
