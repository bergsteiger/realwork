////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/SubServerLibrary/ServerLibHome.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<ServerLibrary::Category>> TestModel::SubServerLibrary
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "TestModel/SubServerLibrary/ServerLibHome.h"

namespace SubServerLibrary {

Core::Root::LibHome& ServerLibHomeFactory::get () {
	return ServerLibHomeImpl::Singleton::instance();
}

ServerLibHomeImpl::ServerLibHomeImpl () {
	this->set_requested_status (Core::Root::ES_IDLE);
}

void ServerLibHomeImpl::registrate_all_factories () const {
	//#UC START# *49AED1DB00DE_ENVIRONMENTS_CONFIG*
	//#UC END# *49AED1DB00DE_ENVIRONMENTS_CONFIG*

}
	
void ServerLibHomeImpl::finalize () {
}
} // namespace SubServerLibrary

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
