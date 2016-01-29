////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/LinkSupport/ServerLibHome.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<ServerLibrary::Category>> MDProcess::LinkSupport
//
// поддержка переходов от страницы к элементу в розу
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "MDProcess/LinkSupport/ServerLibHome.h"

namespace LinkSupport {

Core::Root::LibHome& ServerLibHomeFactory::get () {
	return ServerLibHomeImpl::Singleton::instance();
}

ServerLibHomeImpl::ServerLibHomeImpl () {
	this->set_requested_status (Core::Root::ES_IDLE);
}

void ServerLibHomeImpl::registrate_all_factories () const {
	//#UC START# *468B884203C8_ENVIRONMENTS_CONFIG*
	//#UC END# *468B884203C8_ENVIRONMENTS_CONFIG*

}
	
void ServerLibHomeImpl::finalize () {
}
} // namespace LinkSupport

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
