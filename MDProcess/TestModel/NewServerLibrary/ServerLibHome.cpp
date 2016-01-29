////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/NewServerLibrary/ServerLibHome.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<ServerLibrary::Category>> TestModel::NewServerLibrary
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "TestModel/NewServerLibrary/ServerLibHome.h"

namespace NewServerLibrary {

Core::Root::LibHome& ServerLibHomeFactory::get () {
	return ServerLibHomeImpl::Singleton::instance();
}

ServerLibHomeImpl::ServerLibHomeImpl () {
	this->set_requested_status (Core::Root::ES_IDLE);
}

void ServerLibHomeImpl::registrate_all_factories () const {
	//#UC START# *49AECD640165_ENVIRONMENTS_CONFIG*
	//#UC END# *49AECD640165_ENVIRONMENTS_CONFIG*

}
	
void ServerLibHomeImpl::finalize () {
}
} // namespace NewServerLibrary

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
