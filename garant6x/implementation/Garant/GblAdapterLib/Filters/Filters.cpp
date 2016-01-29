////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Filters/Filters.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Filters
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Filters/Filters.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Filters/FiltersFactories.h"

namespace GblAdapterLib {

// factory interface wrapper for FilterFromQuery
FilterFromQuery* FilterFromQueryFactory::make (
	const GblFilters::Filter& filter
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return FilterFromQueryFactoryManager::Singleton::instance ()->make (filter);
}


const char* NotAllAttributesRestored::uid () const /*throw ()*/ {
	return "EE06D8C5-03DF-425F-8462-8591D75847CE";
}

const char* NotAllAttributesRestored::what () const throw () {
	//#UC START# *45EEB32A0044_WHAT_IMPL*
	return "NotAllAttributesRestored (Не все атрибуты поискового запроса восстановлны из базы)";
	//#UC END# *45EEB32A0044_WHAT_IMPL*
}

// factory interface wrapper for FiltersManager
FiltersManager* FiltersManagerFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return FiltersManagerFactoryManager::Singleton::instance ()->make ();
}

// factory interface wrapper for FiltersUsageCounter
FiltersUsageCounter* FiltersUsageCounterFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return FiltersUsageCounterFactoryManager::Singleton::instance ()->make ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

