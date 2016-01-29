////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/TestLib/LibHome.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<ServerLibrary::Category>> shared::TestLib
//
// Тестирующая библиотека
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/TestLib/LibHome.h"

namespace TestLib {

void LibHomeImpl::publish_all_servers_factories () const {
}

CoreSrv::Root::CorbaLibHome& LibHomeFactory::get () {
	return LibHomeImpl::Singleton::instance();
}

LibHomeImpl::LibHomeImpl () {
}

void LibHomeImpl::registrate_all_factories () const {
	//#UC START# *45D6DAC9026F_ENVIRONMENTS_CONFIG*
	//#UC END# *45D6DAC9026F_ENVIRONMENTS_CONFIG*

}
	
void LibHomeImpl::finalize () {
}
} // namespace TestLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
