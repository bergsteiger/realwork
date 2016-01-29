////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLibDesktop/LibHome.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Library::Category>> garant6x::GblAdapterLibDesktop
//
// Реализация кода, специфичная для серверного адаптера
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "garant6x/implementation/Garant/GblAdapterLibDesktop/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLibDesktop/impl/Start_i/Desktop_factory.h"

namespace GblAdapterLibDesktop {

Core::Root::LibHome& LibHomeFactory::get () {
	return LibHomeImpl::Singleton::instance();
}

LibHomeImpl::LibHomeImpl () {
}

void LibHomeImpl::registrate_all_factories () const {
	//#UC START# *474E8E7E00E7_ENVIRONMENTS_CONFIG*
	//#UC END# *474E8E7E00E7_ENVIRONMENTS_CONFIG*

	{
		Start_i::Desktop_factory_var fctr = new Start_i::Desktop_factory ();
		fctr->registrate_me(0);
	}
	
}
	
void LibHomeImpl::finalize () {
}
} // namespace GblAdapterLibDesktop

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
