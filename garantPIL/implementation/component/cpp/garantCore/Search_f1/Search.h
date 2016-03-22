
#ifndef __SEARCH_F1_H__
#define __SEARCH_F1_H__

#include "shared/Core/sys/std_inc.h"
#include "garantCore/Search/Def/Def.h"
#include "garantPIL/implementation/component/cpp/libs/gkdb/src/SearchB.h"

namespace Search {
	SearchResult* execute (
		SearchBase* base
		, const std::string& str
		, const Segments& segments
		, const SortedCollection* init
		, bool show_short_list
		, bool remove_wo_annos
	);

	SearchResult* execute_pharm (
		SearchBase* base
		, const std::string& str
		, const Segments& segments
		, const SortedCollection* init
		, bool show_short_list
	);

	bool check_query (Base* base, const std::string& str);
}

#endif //__SEARCH_F1_H__