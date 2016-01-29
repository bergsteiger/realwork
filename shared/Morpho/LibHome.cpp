////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Morpho/LibHome.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Library::Category>> shared::Morpho
//
// Библиотека алгоритмов морфоанализа
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Morpho/LibHome.h"

namespace Morpho {

Core::Root::LibHome& LibHomeFactory::get () {
	return LibHomeImpl::Singleton::instance();
}

LibHomeImpl::LibHomeImpl () {
}

void LibHomeImpl::registrate_all_factories () const {
	//#UC START# *4E0092A6000E_ENVIRONMENTS_CONFIG*
	//#UC END# *4E0092A6000E_ENVIRONMENTS_CONFIG*

}
	
void LibHomeImpl::finalize () {
}
} // namespace Morpho

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
