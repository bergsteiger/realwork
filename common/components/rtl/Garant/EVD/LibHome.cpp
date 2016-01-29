////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/common/components/rtl/Garant/EVD/LibHome.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Library::Category>> Shared Delphi::EVD
//
// Содержит классы и методы для обработки документов в формате EVD.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "common/components/rtl/Garant/EVD/LibHome.h"

namespace EVD {

Core::Root::LibHome& LibHomeFactory::get () {
	return LibHomeImpl::Singleton::instance();
}

LibHomeImpl::LibHomeImpl () {
}

void LibHomeImpl::registrate_all_factories () const {
	//#UC START# *467A8734039C_ENVIRONMENTS_CONFIG*
	//#UC END# *467A8734039C_ENVIRONMENTS_CONFIG*

}
	
void LibHomeImpl::finalize () {
}
} // namespace EVD

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
