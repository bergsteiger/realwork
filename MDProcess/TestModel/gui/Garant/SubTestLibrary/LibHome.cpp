////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/gui/Garant/SubTestLibrary/LibHome.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<TestLibrary::Category>> TestModel::SubTestLibrary
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "TestModel/gui/Garant/SubTestLibrary/LibHome.h"

namespace SubTestLibrary {

Core::Root::LibHome& LibHomeFactory::get () {
	return LibHomeImpl::Singleton::instance();
}

LibHomeImpl::LibHomeImpl () {
}

void LibHomeImpl::registrate_all_factories () const {
	//#UC START# *49AED1D0000A_ENVIRONMENTS_CONFIG*
	//#UC END# *49AED1D0000A_ENVIRONMENTS_CONFIG*

}
	
void LibHomeImpl::finalize () {
}
} // namespace SubTestLibrary

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
