////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/MorphoAdapterLib/LibHome.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Library::Category>> garantCore::MorphoAdapterLib
//
// Библиотека с экспортируемой морфологией
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "garantCore/MorphoAdapterLib/LibHome.h"
#include "garantCore/MorphoAdapterLib/impl/Impl/MorphoAdapter_i_factory.h"
#include "garantCore/MorphoAdapterLib/impl/Impl/MorphoManager_i_factory.h"
#include "garantCore/MorphoAdapterLib/impl/Impl/MlmaRu_i_factory.h"

namespace MorphoAdapterLib {

Core::Root::LibHome& LibHomeFactory::get () {
	return LibHomeImpl::Singleton::instance();
}

LibHomeImpl::LibHomeImpl () {
}

void LibHomeImpl::registrate_all_factories () const {
	//#UC START# *4E9EF358031D_ENVIRONMENTS_CONFIG*
	//#UC END# *4E9EF358031D_ENVIRONMENTS_CONFIG*

	{
		Impl::MorphoAdapter_i_factory_var fctr = new Impl::MorphoAdapter_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		Impl::MorphoManager_i_factory_var fctr = new Impl::MorphoManager_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		Impl::MlmaRu_i_factory_var fctr = new Impl::MlmaRu_i_factory ();
		fctr->registrate_me(0);
	}
	
}
	
void LibHomeImpl::finalize () {
}
} // namespace MorphoAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
