////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/Search/impl/Searcher_i/SearchHelper.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityClass::Class>> garantCore::Search::Searcher_i::SearchHelper
//
// Помощник
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_SEARCH_SEARCHER_I_SEARCHHELPER_H__
#define __GARANTCORE_SEARCH_SEARCHER_I_SEARCHHELPER_H__

#include "shared/Core/sys/std_inc.h"
#include "garantCore/Search/Def/Def.h"
#include "garantPIL/implementation/component/cpp/libs/gkdb/src/collect.h"
#include "garantPIL/implementation/component/cpp/libs/gkdb/src/Base.h"

namespace Search {
namespace Searcher_i {

// Помощник
class SearchHelper {
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// проверка на валидность
	static bool check_query (Base* base, const std::string& in);

	// копирование коллекции
	static SortedCollection* copy_collection (const SortedCollection* in);

	// приоритет
	static short get_data_priority (short type);

	// фабрика ключей для хранилища
	static char* make_date_key (const std::string& str);

	// фабрика ключей для хранилища
	static char* make_key (Base* base, const QueryTag& tag);

	// трансформация
	static SortedCollection* transform_for_title_search (SortedCollection* in, const SortedCollection* list);

}; // class SearchHelper

} // namespace Searcher_i
} // namespace Search


#endif //__GARANTCORE_SEARCH_SEARCHER_I_SEARCHHELPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

