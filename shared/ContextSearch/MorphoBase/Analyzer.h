////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/MorphoBase/Analyzer.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityClass::Class>> shared::ContextSearch::MorphoBase::Analyzer
//
// Анализатор контекстного запроса
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_MORPHOBASE_ANALYZER_H__
#define __SHARED_CONTEXTSEARCH_MORPHOBASE_ANALYZER_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/Search/Search.h"

namespace ContextSearch {

// Анализатор контекстного запроса
class Analyzer {
	SET_OBJECT_COUNTER (Analyzer)
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// проверка на цифры
	static bool is_digits (const Search::PhraseEx& in);

	// проверка на идентичность слов в запросе
	static bool is_identical (const Search::PhraseEx& in);

}; // class Analyzer

} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_MORPHOBASE_ANALYZER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

