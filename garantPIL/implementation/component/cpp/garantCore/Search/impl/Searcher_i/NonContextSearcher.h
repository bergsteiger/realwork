////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/Search/impl/Searcher_i/NonContextSearcher.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garantCore::Search::Searcher_i::NonContextSearcher
//
// Неконтекстный поиск
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_SEARCH_SEARCHER_I_NONCONTEXTSEARCHER_H__
#define __GARANTCORE_SEARCH_SEARCHER_I_NONCONTEXTSEARCHER_H__

#include "shared/Core/sys/std_inc.h"
#include "garantPIL/implementation/component/cpp/libs/gkdb/src/SearchB.h"
#include "garantCore/Search/Def/Def.h"
#include "garantPIL/implementation/component/cpp/libs/gkdb/src/collect.h"
#include "garantCore/Search/impl/Searcher_i/StorageData.h"

namespace Search {
namespace Searcher_i {

// Неконтекстный поиск
class NonContextSearcher :
	virtual public StorageData
{
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	explicit NonContextSearcher (SearchBase* base);

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// поиск
	SortedCollection* find (const QueryTag& tag, unsigned long doc_id);

	// поиск шаблона
	SortedCollection* find_pattern (const QueryTag& tag);

	// поиск в диапазоне дат
	SortedCollection* find_range (const QueryTag& tag, unsigned long doc_id);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	SearchBase* m_base;
}; // class NonContextSearcher

} // namespace Searcher_i
} // namespace Search


#endif //__GARANTCORE_SEARCH_SEARCHER_I_NONCONTEXTSEARCHER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

