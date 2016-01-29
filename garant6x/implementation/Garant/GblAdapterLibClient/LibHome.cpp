////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLibClient/LibHome.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Library::Category>> garant6x::GblAdapterLibClient
//
// Реализация кода, специфичная для клиентского адаптера
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "garant6x/implementation/Garant/GblAdapterLibClient/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLibClient/impl/Start_i/Client_factory.h"

namespace GblAdapterLibClient {

Core::Root::LibHome& LibHomeFactory::get () {
	return LibHomeImpl::Singleton::instance();
}

LibHomeImpl::LibHomeImpl () {
}

void LibHomeImpl::registrate_all_factories () const {
	//#UC START# *474E8E58022D_ENVIRONMENTS_CONFIG*
	//#UC END# *474E8E58022D_ENVIRONMENTS_CONFIG*

	{
		Start_i::Client_factory_var fctr = new Start_i::Client_factory ();
		fctr->registrate_me(0);
	}
	
}
	
void LibHomeImpl::finalize () {
}
} // namespace GblAdapterLibClient

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
