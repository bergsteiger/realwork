////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/SubServerLibrary/LibHome.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<ServerLibrary::Category>> TestModel::SubServerLibrary
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "TestModel/SubServerLibrary/LibHome.h"

namespace SubServerLibrary {

void LibHomeImpl::publish_all_servers_factories () const {
}

CoreSrv::Root::CorbaLibHome& LibHomeFactory::get () {
	return LibHomeImpl::Singleton::instance();
}

LibHomeImpl::LibHomeImpl () {
}

void LibHomeImpl::registrate_all_factories () const {
	//#UC START# *49AED1DB00DE_ENVIRONMENTS_CONFIG*
	//#UC END# *49AED1DB00DE_ENVIRONMENTS_CONFIG*

}
	
void LibHomeImpl::finalize () {
}
} // namespace SubServerLibrary

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
