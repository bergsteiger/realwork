////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/SearchAdapterLib/LibHome.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Library::Category>> garantCore::SearchAdapterLib
//
// SearchAdapterLib
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "garantCore/SearchAdapterLib/LibHome.h"
#include "garantCore/SearchAdapterLib/impl/Adapter_i/Searcher_i_factory.h"
#include "garantCore/SearchAdapterLib/impl/Adapter_i/Helper_i_factory.h"
#include "garantCore/SearchAdapterLib/impl/Adapter_i/Adapter_i_factory.h"

namespace SearchAdapterLib {

Core::Root::LibHome& LibHomeFactory::get () {
	return LibHomeImpl::Singleton::instance();
}

LibHomeImpl::LibHomeImpl () {
}

void LibHomeImpl::registrate_all_factories () const {
	//#UC START# *4EBA86850297_ENVIRONMENTS_CONFIG*
	//#UC END# *4EBA86850297_ENVIRONMENTS_CONFIG*

	{
		Adapter_i::Searcher_i_factory_var fctr = new Adapter_i::Searcher_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		Adapter_i::Helper_i_factory_var fctr = new Adapter_i::Helper_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		Adapter_i::Adapter_i_factory_var fctr = new Adapter_i::Adapter_i_factory ();
		fctr->registrate_me(0);
	}
	
}
	
void LibHomeImpl::finalize () {
}
} // namespace SearchAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
