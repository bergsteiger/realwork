////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/MorphoBase/ResultOperations.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityClass::Class>> shared::ContextSearch::MorphoBase::ResultOperations
//
// Операции с векторами релевантных документов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_MORPHOBASE_RESULTOPERATIONS_H__
#define __SHARED_CONTEXTSEARCH_MORPHOBASE_RESULTOPERATIONS_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/Search/Search.h"

namespace ContextSearch {

// Операции с векторами релевантных документов
class ResultOperations {
	SET_OBJECT_COUNTER (ResultOperations)
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// пересечение двух контейнеров с результатами поисков
	static Search::RelevancyDocuments* intersection (const Search::RelevancyDocuments& x, const Search::RelevancyDocuments& y);

	// мердж двух контейнеров с результатами поисков
	static Search::RelevancyDocuments* merge (const Search::RelevancyDocuments& x, const Search::RelevancyDocuments& y);

	// объединение двух контейнеров с результатами поисков
	static Search::RelevancyDocuments* union_ (const Search::RelevancyDocuments& x, const Search::RelevancyDocuments& y);

}; // class ResultOperations

} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_MORPHOBASE_RESULTOPERATIONS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

