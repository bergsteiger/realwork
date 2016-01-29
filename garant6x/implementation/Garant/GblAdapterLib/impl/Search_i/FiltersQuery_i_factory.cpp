////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/FiltersQuery_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Search_i::FiltersQuery_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/FiltersQuery_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/FiltersQuery_i.h"

namespace GblAdapterLib {

FiltersQuery_i_factory::FiltersQuery_i_factory () {
}

void FiltersQuery_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	FiltersQueryFactoryManager::register_factory (this, priority);
}

const char* FiltersQuery_i_factory::key () const {
	return "FiltersQuery_i";
}

FiltersQuery* FiltersQuery_i_factory::make (FilterFromQuery* filter) {
	FiltersQuery_i_var ret = new FiltersQuery_i (filter);
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

