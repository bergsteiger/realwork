////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/MorphoBase/Analyzer.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityClass::Class>> shared::ContextSearch::MorphoBase::Analyzer
//
// Анализатор контекстного запроса
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/MorphoBase/Analyzer.h"
// by <<uses>> dependencies
#include "boost/lambda/lambda.hpp"
#include "boost/algorithm/string/classification.hpp"

namespace ContextSearch {

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// проверка на цифры
bool Analyzer::is_digits (const Search::PhraseEx& in) {
	//#UC START# *56950BCC01F6*
	for (Search::PhraseEx::const_iterator it = in.begin (); it != in.end (); ++it) {
		for (Search::StringSet::const_iterator _it = it->begin (); _it != it->end (); ++_it) {
			if (std::find_if (_it->begin (), _it->end (), boost::is_digit ()) == _it->end ()) {
				return false;
			}
		}
	}

	return true;
	//#UC END# *56950BCC01F6*
}

// проверка на идентичность слов в запросе
bool Analyzer::is_identical (const Search::PhraseEx& in) {
	//#UC START# *497EE9450143*
	return (in.size () > 1)? (std::find_if (in.begin () + 1, in.end (), boost::lambda::_1 != in.front ()) == in.end ()) : false;
	//#UC END# *497EE9450143*
}

} // namespace ContextSearch

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

