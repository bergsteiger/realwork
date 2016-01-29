////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/Search/impl/Searcher_i/Searcher_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garantCore::Search::Searcher_i::Searcher_i
//
// Реализация поисковой машины
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_SEARCH_SEARCHER_I_SEARCHER_I_H__
#define __GARANTCORE_SEARCH_SEARCHER_I_SEARCHER_I_H__

#include "shared/Core/sys/std_inc.h"
#include "garantPIL/implementation/component/cpp/libs/gkdb/src/SearchB.h"
#include "garantCore/Search/Def/Def.h"
#include "garantCore/Search/impl/Searcher_i/NonContextSearcher.h"
#include "garantPIL/implementation/component/cpp/libs/gkdb/src/collect.h"

namespace Search {
namespace Searcher_i {

// Реализация поисковой машины
class Searcher_i;
typedef Core::Var<Searcher_i> Searcher_i_var;
typedef Core::Var<const Searcher_i> Searcher_i_cvar;

class Searcher_i :
	virtual public ISearcher
	, virtual public Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (Searcher_i)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declarations
private:
	// Результирующий список
	class Result {
	//////////////////////////////////////////////////////////////////////////////////////////
	// self methods
	public:
		// фабрика
		static SearchResult* make (SortedCollection* in, long max_size);

		// фабрика
		static SearchResult* make (bool is_interrupted);


	//#UC START# *50DC3D6D03B7*
	//#UC END# *50DC3D6D03B7*
	}; // class Result

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	explicit Searcher_i (SearchBase* base);

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// поиск заданного запроса
	SearchResult* _execute (const std::string& query, const SearchProp& prop);

	// контекстный поиск в заданном списке
	SortedCollection* context_search (
		const QueriesTags& tags
		, const SortedCollection* in
		, MergeOp op
		, const SearchProp& prop
	);

	// выполнить
	SortedCollection* execute (const QueriesTags& tags, const SearchProp& prop);

	// выполнить
	SortedCollection* execute_new (const QueriesTags& tags, const SearchProp& prop);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	SearchBase* m_base;

	Core::Box<NonContextSearcher> m_nc_searcher;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from ISearcher
	// выполнить
	SearchResult* execute (const std::string& query, const SearchProp& prop);

	// implemented method from ISearcher
	// выполнить
	SearchResult* execute (IQuery* query, const SearchProp& prop);
}; // class Searcher_i

} // namespace Searcher_i
} // namespace Search


#endif //__GARANTCORE_SEARCH_SEARCHER_I_SEARCHER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

