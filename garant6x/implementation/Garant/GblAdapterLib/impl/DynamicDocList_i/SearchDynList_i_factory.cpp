////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/SearchDynList_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicDocList_i::SearchDynList_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/SearchDynList_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/SearchDynList_i.h"

namespace GblAdapterLib {

SearchDynList_i_factory::SearchDynList_i_factory () {
}

void SearchDynList_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	SearchDynListFactoryManager::register_factory (this, priority);
}

const char* SearchDynList_i_factory::key () const {
	return "SearchDynList_i";
}

SearchDynList* SearchDynList_i_factory::make (GblPilot::SearchDocList* search_doc_list) {
	SearchDynList_i_var ret = new SearchDynList_i (search_doc_list);
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

