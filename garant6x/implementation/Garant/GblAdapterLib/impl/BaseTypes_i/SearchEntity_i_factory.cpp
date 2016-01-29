////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/BaseTypes_i/SearchEntity_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::BaseTypes_i::SearchEntity_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/BaseTypes_i/SearchEntity_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/BaseTypes_i/SearchEntity_i.h"
//#UC START# *456EE2440148CUSTOM_INLUDE*
#include "garantServer/src/Business/GblPilot/GblPilotC.h"

#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"

#include "garant6x/implementation/Garant/GblAdapterLib/DynamicDocList/DynamicDocListFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Monitoring/Monitoring.h"
//#UC END# *456EE2440148CUSTOM_INLUDE*

namespace GblAdapterLib {

SearchEntity_i_factory::SearchEntity_i_factory () {
}

void SearchEntity_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	SearchEntityFactoryManager::register_factory (this, priority);
}

const char* SearchEntity_i_factory::key () const {
	return "SearchEntity_i";
}

// фабрика
SearchEntity* SearchEntity_i_factory::make (
	SearchResultType result_type
	, size_t document_count
	, size_t entry_count
	, size_t edition_count
) {
	//#UC START# *456ECA9603A9456EE2440148_456EE2B102EE_IMPL*
	SearchEntity_i_var ret = new SearchEntity_i (result_type, document_count, entry_count, edition_count);
	return ret._retn ();
	//#UC END# *456ECA9603A9456EE2440148_456EE2B102EE_IMPL*
}

// фабрика
SearchEntity* SearchEntity_i_factory::make (GblPilotQueryDef::SearchEntity* search_entity) {
	//#UC START# *456ECA9603A9456EE2440148_460299EF0138_IMPL*
	SearchEntity_var out_entity;
	switch (search_entity->result_type ()) {
		case GblPilotQueryDef::SRT_DOCUMENT_LIST:
		case GblPilotQueryDef::SRT_PHARM_LIST:
			{
			GblPilot::SearchDocList_var search_doc_list = GblPilot::SearchDocList::_narrow (search_entity);
			out_entity = SearchDynListFactory::make (search_doc_list.in ());
			ApplicationHelper::instance ()->get_cached_life_cycle_manager ()->release_object (search_doc_list.in ());
			}
			break;

		case GblPilotQueryDef::SRT_AUTOREFERAT:
			{
			GblPilot::AutoReferatList_var auto_referat_list = GblPilot::AutoReferatList::_narrow (search_entity);
			out_entity = MonitoringListFactory::make (auto_referat_list.in (), search_entity->document_count ());
			}
			break;

		case GblPilotQueryDef::SRT_CONSULTATION:
			break;
	}
	return out_entity._retn ();
	//#UC END# *456ECA9603A9456EE2440148_460299EF0138_IMPL*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

