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
#include "boost/bind.hpp"

namespace ContextSearch {

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// получить слово
void Analyzer::get_value (const std::string& in, std::string& out) {
	//#UC START# *497EE96F0318*
	char last_ch = in.at (in.size () - 1);

	if (last_ch == '!') {
		out = in.substr (0, in.size () - 1);
	} else {
		out = in;
	}
	//#UC END# *497EE96F0318*
}

// проверка на идентичность слов в запросе
bool Analyzer::is_identical (const Search::PhraseEx& request) {
	//#UC START# *497EE9450143*
	bool ret = request.size () > 1;

	if (ret) {
		Search::PhraseEx::const_iterator first_it = request.begin (), it_end = request.end ();

		if (std::find_if (first_it, it_end, boost::bind (&GCL::StrSet::size, _1) > (size_t) 1) != it_end) {
			return false;
		}

		std::string first, cur;

		Analyzer::get_value (*(first_it->begin ()), first);

		for (Search::PhraseEx::const_iterator it = first_it + 1; it != it_end && ret; ++it) {
			Analyzer::get_value (*(it->begin ()), cur);
			ret = (first == cur);
		}
	}

	return ret;
	//#UC END# *497EE9450143*
}

} // namespace ContextSearch

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

