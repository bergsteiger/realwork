////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/NewLibrary/LibHome.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Library::Category>> TestModel::NewLibrary
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "TestModel/NewLibrary/LibHome.h"

namespace NewLibrary {

Core::Root::LibHome& LibHomeFactory::get () {
	return LibHomeImpl::Singleton::instance();
}

LibHomeImpl::LibHomeImpl () {
}

void LibHomeImpl::registrate_all_factories () const {
	//#UC START# *49AECD3C01C1_ENVIRONMENTS_CONFIG*
	//#UC END# *49AECD3C01C1_ENVIRONMENTS_CONFIG*

}
	
void LibHomeImpl::finalize () {
}
} // namespace NewLibrary

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
