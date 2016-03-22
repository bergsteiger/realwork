////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/Search/ContextSearch/ContextSearcher.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garantCore::Search::ContextSearch::ContextSearcher
//
// Контекстный поиск
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_SEARCH_CONTEXTSEARCH_CONTEXTSEARCHER_H__
#define __GARANTCORE_SEARCH_CONTEXTSEARCH_CONTEXTSEARCHER_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCL/data/std_defs.h"
#include "shared/DB/DBCore/DBCore.h"
#include "garantCore/SearchAdapterLib/Adapter/Adapter.h"
#include "garantCore/Search/Def/Def.h"
#include "garantPIL/implementation/component/cpp/libs/gkdb/src/collect.h"
#include "garantCore/Search/ContextSearch/Collector_i.h"
#include "garantPIL/implementation/component/cpp/libs/gkdb/src/Base.h"

//#UC START# *50ACE4D50116_CUSTOM_INCLUDES*
//#UC END# *50ACE4D50116_CUSTOM_INCLUDES*

namespace Search {

// Контекстный поиск
class ContextSearcher {
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	ContextSearcher (Base* base, SearchAdapterLib::Adapter::IRelevancyInfo* info, const GCL::StrVector& src);

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// добавить контекст
	void add (const QueryTag& tag);

	// выполнить
	SortedCollection* execute (SearchAdapterLib::Adapter::IFilter* filter);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	Base* m_base;

	SearchAdapterLib::Adapter::IRelevancyInfo* m_info_collector;

	DBCore::IProgress_var m_progress;

	Collector_i::RequestData m_request_data;

	GCL::StrVector m_src;

//#UC START# *50ACE4D50116*
	ContextSearch::Defs::Requests m_requests;

private:
	RefwReleCollection* search (
		const std::string& src, const ContextSearch::Defs::Requests& reqs, ContextSearch::Defs::IFilter* filter
	);

	RefwReleCollection* search (const ContextSearch::Defs::Requests& reqs, ContextSearch::Defs::IFilter* filter);
//#UC END# *50ACE4D50116*
}; // class ContextSearcher

} // namespace Search


#endif //__GARANTCORE_SEARCH_CONTEXTSEARCH_CONTEXTSEARCHER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

