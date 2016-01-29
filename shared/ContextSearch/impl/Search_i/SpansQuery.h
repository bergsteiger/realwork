////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/impl/Search_i/SpansQuery.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::ContextSearch::Search_i::SpansQuery
//
// Спаны
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_SEARCH_I_SPANSQUERY_H__
#define __SHARED_CONTEXTSEARCH_SEARCH_I_SPANSQUERY_H__

#include "shared/Core/sys/std_inc.h"
#include <vector>
#include "shared/GCL/data/std_defs.h"
#include "shared/ContextSearch/Search/Search.h"
#include "shared/ContextSearch/DBComm/DBComm.h"
#include "shared/ContextSearch/impl/Search_i/SpanQuery.h"

namespace ContextSearch {
namespace Search_i {

// Спаны
class SpansQuery {

//////////////////////////////////////////////////////////////////////////////////////////
// nested declarations
public:
	// Спаны
	typedef std::vector < SpanQuery > Spans;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	SpansQuery (const GCL::StrVector& spans, const Search::AlgorithmProperties& prop);

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// очистить кэш спанов
	void clear ();

	// данные
	Spans& get ();

	// вычислить значение для прогресс-индикатора
	size_t get_prog_value ();

	// поиск
	bool next (DBComm::DocId border, Search::DocIdPair& out);

	// поиск документа
	bool search_doc (DBComm::DocId id);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	Spans m_data;
}; // class SpansQuery

} // namespace Search_i
} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_SEARCH_I_SPANSQUERY_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

