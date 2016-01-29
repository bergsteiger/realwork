////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Filters_i/FilterUsageCounter_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Filters_i::FilterUsageCounter_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Filters_i/FilterUsageCounter_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Filters_i/FilterUsageCounter_i.h"

namespace GblAdapterLib {

FilterUsageCounter_i_factory::FilterUsageCounter_i_factory () {
}

void FilterUsageCounter_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	FiltersUsageCounterFactoryManager::register_factory (this, priority);
}

const char* FilterUsageCounter_i_factory::key () const {
	return "FilterUsageCounter_i";
}

FiltersUsageCounter* FilterUsageCounter_i_factory::make () {
	return Core::IObject::_duplicate (FilterUsageCounter_i::Singleton::instance());
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

