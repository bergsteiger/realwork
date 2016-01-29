////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/impl/Search_i/RequestAnalyzer.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::ContextSearch::Search_i::RequestAnalyzer
//
// Анализатор контекстного запроса
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_SEARCH_I_REQUESTANALYZER_H__
#define __SHARED_CONTEXTSEARCH_SEARCH_I_REQUESTANALYZER_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/Search/Search.h"
#include "shared/ContextSearch/Relevancy/Relevancy.h"
#include "shared/ContextSearch/MorphoBase/Searcher.h"

namespace ContextSearch {
namespace Search_i {

// Анализатор контекстного запроса
class RequestAnalyzer {
	SET_OBJECT_COUNTER (RequestAnalyzer)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	RequestAnalyzer (const Search::RequestEx& request, const Search::AlgorithmProperties& prop, bool is_ext);

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// algorithm
	Relevancy::IAlgorithm* get_algorithm ();

	// searcher
	Searcher* get_searcher ();

private:
	// build
	void build (const Search::RequestEx& request, const Search::AlgorithmProperties& prop, bool is_ext);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	Relevancy::IAlgorithm_var m_algorithm;

	Core::Box<Searcher> m_searcher;
}; // class RequestAnalyzer

} // namespace Search_i
} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_SEARCH_I_REQUESTANALYZER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

