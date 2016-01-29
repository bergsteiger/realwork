////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/SearchAdapterLib/Adapter/Adapter.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garantCore::SearchAdapterLib::Adapter
//
// Интерфейсы и типы поискового адаптера
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "garantCore/SearchAdapterLib/Adapter/Adapter.h"
#include "garantCore/SearchAdapterLib/Adapter/AdapterFactories.h"

namespace SearchAdapterLib {
namespace Adapter {

// factory interface wrapper for ISearcher
ISearcher* ISearcherFactory::make (
	DBCore::IBase* base
	, Morpho::Def::ICache* cache
	, const std::string& src
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return ISearcherFactoryManager::Singleton::instance ()->make (base, cache, src);
}

// factory interface wrapper for IHelper
IHelper* IHelperFactory::make (
	Morpho::Def::ICache* cache
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return IHelperFactoryManager::Singleton::instance ()->make (cache);
}

// factory interface wrapper for IAdapter
IAdapter& IAdapterFactory::instance () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return IAdapterFactoryManager::Singleton::instance ()->instance ();
}

} // namespace Adapter
} // namespace SearchAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

