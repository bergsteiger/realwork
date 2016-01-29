////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Filters_i/FilterFromQuery_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Filters_i::FilterFromQuery_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Filters_i/FilterFromQuery_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Filters_i/FilterFromQuery_i.h"

namespace GblAdapterLib {

FilterFromQuery_i_factory::FilterFromQuery_i_factory () {
}

void FilterFromQuery_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	FilterFromQueryFactoryManager::register_factory (this, priority);
}

const char* FilterFromQuery_i_factory::key () const {
	return "FilterFromQuery_i";
}

FilterFromQuery* FilterFromQuery_i_factory::make (const GblFilters::Filter& filter) {
	FilterFromQuery_i_var ret = new FilterFromQuery_i (filter);
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

