////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/LibHome.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Library::Category>> shared::Core
//
// Ядро. Билиотека базовый системных типов и методов. Активно используется в шаблонах при генерации
// с модели. Содержит фреймворк GCM2
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/LibHome.h"
#include "shared/Core/impl/mt_i/ThreadPool_i_factory.h"
#include "shared/Core/impl/ParamsImpl/ParamManagerImpl_factory.h"
#include "shared/Core/impl/Root_i/Configuration_i_factory.h"
#include "shared/Core/impl/Root_i/StdLibHomeManager_factory.h"

namespace Core {

Core::Root::LibHome& LibHomeFactory::get () {
	return LibHomeImpl::Singleton::instance();
}

LibHomeImpl::LibHomeImpl () {
}

void LibHomeImpl::registrate_all_factories () const {
	//#UC START# *44FEAE500224_ENVIRONMENTS_CONFIG*
	//#UC END# *44FEAE500224_ENVIRONMENTS_CONFIG*

	{
		mt_i::ThreadPool_i_factory_var fctr = new mt_i::ThreadPool_i_factory ();
		fctr->registrate_me(0);
	}
	
	//#UC START# *44FEAE500224_CUSTOM_REGISTRATE_FOR_48327B8A0355_ParamManagerImpl*
	//#UC END# *44FEAE500224_CUSTOM_REGISTRATE_FOR_48327B8A0355_ParamManagerImpl*
	
	{
		Root_i::Configuration_i_factory_var fctr = new Root_i::Configuration_i_factory ();
		fctr->registrate_me(0);
	}
	
	//#UC START# *44FEAE500224_CUSTOM_REGISTRATE_FOR_457EA1410318_StdLibHomeManager*
	//#UC END# *44FEAE500224_CUSTOM_REGISTRATE_FOR_457EA1410318_StdLibHomeManager*
	
}
	
void LibHomeImpl::finalize () {
}
} // namespace Core

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
