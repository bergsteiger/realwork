////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/impl/Manage_i/QueryCorrector.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::ContextSearch::Manage_i::QueryCorrector
//
// Корректор запроса
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/impl/Manage_i/QueryCorrector.h"
// by <<uses>> dependencies
#include "boost/algorithm/string/trim.hpp"
#include "boost/lexical_cast.hpp"
#include "shared/ContextSearch/Common/ContextUtility.h"
#include "shared/GCL/str/str_conv.h"
#include "boost/bind.hpp"
#include "boost/algorithm/string/split.hpp"

namespace ContextSearch {
namespace Manage_i {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

QueryCorrector::QueryCorrector (bool uwc)
//#UC START# *55154A0500D7_BASE_INIT*
	: m_uwc (uwc)
//#UC END# *55154A0500D7_BASE_INIT*
{
	//#UC START# *55154A0500D7_BODY*
	//#UC END# *55154A0500D7_BODY*
}

QueryCorrector::~QueryCorrector () {
	//#UC START# *51C046C60217_DESTR_BODY*
	//#UC END# *51C046C60217_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// исправление контекста
void QueryCorrector::correct (std::string& str, char delim) {
	//#UC START# *51C04CFA02B0*
	char buf [2];
	buf [0] = delim;
	buf [1] = 0;

	GCL::StrVector parts;
	boost::split (parts, str, boost::is_any_of (buf));

	str.clear ();

	for (GCL::StrVector::iterator it = parts.begin (); it != parts.end (); ++it) {
		if (it->empty ()) {
			continue;
		}

		boost::trim_if (*it, (boost::bind (&ContextUtility::is_valid_char, _1) == false));

		if (it->empty ()) {
			continue;
		}

		size_t count = std::count_if (it->begin (), it->end (), (boost::bind (&ContextUtility::is_valid_char, _1) == false));

		if (count == 1) {
			std::string::iterator _it = std::find_if (it->begin (), it->end (), boost::is_any_of (","));

			if (_it != it->end ()) {
				if (std::find_if (it->begin (), _it, !boost::is_digit ()) == _it) {
					if (std::find_if (_it + 1, it->end (), !boost::is_digit ()) == it->end ()) {
						if (str.empty () == false) {
							str += delim;
						}

						str.append (it->begin (), _it);
						str.append ("-");
						str.append (_it + 1, it->end ());
						continue;
					}
				}
			}
		}

		if (count == 0) {
			QueryCorrector::correct_special (*it);
		} else if (std::find_if (it->begin (), it->end (), boost::is_any_of (",;:")) != it->end ()) {
			std::replace_if (it->begin (), it->end (), boost::is_any_of (",;:"), ' ');
			QueryCorrector::correct (*it, ' ');
		} else {
			std::replace_if (it->begin (), it->end (), !boost::bind (&ContextUtility::is_valid_char, _1), '-');
			QueryCorrector::correct (*it, '-');
		}

		if (it->empty () == false) {
			if (str.empty () == false) {
				str += delim;
			}

			str += *it;
		}
	}
	//#UC END# *51C04CFA02B0*
}

// исправление контекста
void QueryCorrector::correct_special (std::string& str) {
	//#UC START# *51C1860D03D6*
	size_t sz = str.size ();

	if (sz) {
		char last = *(str.rbegin ());

		if (last == '*' || last == '!') {
			if (sz == 1) {
				str.clear (); // удаление свободных
			} else if (last == '*' && sz < 4) {
				if (m_uwc == false) {
					str.erase (sz - 1); // удаление '*' из 1-2-x символьных лексем
				}
			} else if (ContextUtility::is_valid_char (str [sz - 2]) == false) {
				str.erase (sz - 1);
				boost::trim_right_if (str, (boost::bind (&ContextUtility::is_valid_char, _1) == false));
			} else if (last == '!') {
				if (std::find_if (str.begin (), str.end (), boost::is_digit ()) != str.end ()) {
					str.erase (sz - 1); // удаление '!' из цифр/буквоцифр
				}
			}
		}

		if (str [0] == '*' || str [0] == '!') {
			boost::trim_left_if (str, boost::is_any_of ("*!"));
		}
	}
	//#UC END# *51C1860D03D6*
}

// выполнить
const std::string QueryCorrector::execute (const std::string& str, Info& out) {
	//#UC START# *51C04B9D0098*
	std::string ret = boost::trim_copy_if (str, boost::is_space ());

	if (ret.empty () == false) {
		std::replace (ret.begin (), ret.end (), '~' , ' '); // тильда - внутренняя кухня, нефиг...

		size_t pos = ret.rfind ("--");

		if (pos != std::string::npos && pos + 2 < ret.size ()) {
			std::string sub_str = ret.substr (pos + 2);

			if (ContextUtility::is_digit (sub_str)) {
				out.max_fragment = boost::lexical_cast <size_t> (sub_str);
				ret = ret.substr (0 , pos);
			}
		}

		out.has_syn = (*(ret.begin ()) != '\"' || *(ret.rbegin ()) != '\"');

		GCL::to_upper (ret);

		QueryCorrector::correct (ret);

		if (out.has_syn == false) {
			std::replace (ret.begin (), ret.end (), ' ', '-');
		}
	}

	return ret;
	//#UC END# *51C04B9D0098*
}

} // namespace Manage_i
} // namespace ContextSearch

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

