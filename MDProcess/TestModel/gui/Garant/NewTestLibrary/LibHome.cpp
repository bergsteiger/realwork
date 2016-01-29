////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/gui/Garant/NewTestLibrary/LibHome.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<TestLibrary::Category>> TestModel::NewTestLibrary
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "TestModel/gui/Garant/NewTestLibrary/LibHome.h"

namespace NewTestLibrary {

Core::Root::LibHome& LibHomeFactory::get () {
	return LibHomeImpl::Singleton::instance();
}

LibHomeImpl::LibHomeImpl () {
}

void LibHomeImpl::registrate_all_factories () const {
	//#UC START# *49AECD6F03D5_ENVIRONMENTS_CONFIG*
	//#UC END# *49AECD6F03D5_ENVIRONMENTS_CONFIG*

}
	
void LibHomeImpl::finalize () {
}
} // namespace NewTestLibrary

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
