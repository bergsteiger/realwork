////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GSI/LibHome.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Library::Category>> shared::GSI
//
// Garant Server Interfaces - общие интерфейсы повторного использования, использующие CORBA
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/GSI/LibHome.h"
#include "shared/GSI/impl/NotifyService_i/Supplier_i_factory.h"
#include "shared/GSI/impl/NotifyService_i/Manager_i_factory.h"

namespace GSI {

Core::Root::LibHome& LibHomeFactory::get () {
	return LibHomeImpl::Singleton::instance();
}

LibHomeImpl::LibHomeImpl () {
}

void LibHomeImpl::registrate_all_factories () const {
	//#UC START# *44F7F7CE0080_ENVIRONMENTS_CONFIG*
	//#UC END# *44F7F7CE0080_ENVIRONMENTS_CONFIG*

	//#UC START# *44F7F7CE0080_CUSTOM_REGISTRATE_FOR_44B26F310177_Supplier_i*
	//#UC END# *44F7F7CE0080_CUSTOM_REGISTRATE_FOR_44B26F310177_Supplier_i*
	
	//#UC START# *44F7F7CE0080_CUSTOM_REGISTRATE_FOR_44A13F9E035B_Manager_i*
	//#UC END# *44F7F7CE0080_CUSTOM_REGISTRATE_FOR_44A13F9E035B_Manager_i*
	
}
	
void LibHomeImpl::finalize () {
}
} // namespace GSI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
