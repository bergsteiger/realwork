////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/impl/Manage_i/RequestTransformer_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::ContextSearch::Manage_i::RequestTransformer_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/LibHome.h"
#include "shared/ContextSearch/impl/Manage_i/RequestTransformer_i.h"
// by <<uses>> dependencies
#include "shared/GCL/str/str_conv.h"
#include "boost/bind.hpp"
#include "boost/algorithm/string/classification.hpp"
#include "shared/ContextSearch/Common/ContextUtility.h"

namespace ContextSearch {
namespace Manage_i {

//////////////////////////////////////////////////////////////////////////////////////////
// nested implementation
// Константы
const size_t RequestTransformer_i::MAX_WORDS_OF_REQUEST = 15; // максимальное количество слов в морфозапросе

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods

// исключить слова и фразы
void RequestTransformer_i::exclude (std::string& str, const GCL::StrVector& data, bool is_fake) {
	//#UC START# *4B5AAD5A0109*
	std::string res, rest, cur;

	GCL::StrVector::const_iterator it;

	for (const char* req = str.c_str (); *req; ) {
		cur = req;

		it = std::lower_bound (data.begin (), data.end (), cur
			, boost::bind (std::greater <size_t> ()
			, boost::bind (&std::string::size, _1)
			, boost::bind (&std::string::size, _2))
		);

		for (; it != data.end (); ++it) {
			if (cur [0] == *(it->begin ())) {
				if (cur.size () == it->size ()) {
					if (cur == *it) {
						break;
					}
				} else if (it->size () < cur.size () && cur [it->size ()] == ' ') {
					if (it->compare (0, it->size (), cur, 0, it->size ()) == 0) {
						break;
					}
				}
			}
		}

		if (it == data.end ()) {
			if (res.empty () == false) {
				res += ' ';
			}
			req += ContextUtility::get_first_word (rest, req);
			res += rest;
		} else if (cur.size () != it->size ()) {
			req += it->size () + 1;

			if (is_fake && res.empty () == false) {
				char prev = *res.rbegin ();

				if (prev >= '0' && prev <= '9' && *req >= '0' && *req <= '9') {
					res += " -";
				}
			}
		} else {
			break;
		}
	}

	if (str.size () != res.size ()) {
		str = res;
	}
	//#UC END# *4B5AAD5A0109*
}


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

RequestTransformer_i::RequestTransformer_i (Morpho::Def::INormalizer* normalizer)
//#UC START# *4B5AA36E0301_4B5AA3F5014A_4B5AA66F0097_BASE_INIT*
//#UC END# *4B5AA36E0301_4B5AA3F5014A_4B5AA66F0097_BASE_INIT*
{
	//#UC START# *4B5AA36E0301_4B5AA3F5014A_4B5AA66F0097_BODY*
	m_normalizer = Morpho::Def::INormalizer::_duplicate (normalizer);
	//#UC END# *4B5AA36E0301_4B5AA3F5014A_4B5AA66F0097_BODY*
}

RequestTransformer_i::~RequestTransformer_i () {
	//#UC START# *4B5AA66F0097_DESTR_BODY*
	//#UC END# *4B5AA66F0097_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// получить значение даты
const std::string& RequestTransformer_i::correct_date (std::string& str) {
	//#UC START# *51D6BF11000C*
	GDS_ASSERT (str.empty () == false);

	if (str.size () > 2 && str [0] == 'О' && str [1] == 'Т' && str [2] >= '0' && str [2] <= '9') {
		str.erase (0, 2);
	}

	char last = *(str.rbegin ());

	if (last != '!' && last != '*' && (last < '0' || last > '9')) {
		std::string::reverse_iterator r_it = std::find_if (str.rbegin (), str.rend (), boost::is_digit ());
		std::string::iterator it = r_it.base ();

		if (it != str.begin () && this->is_year (&(*it))) {
			str.erase (it, str.end ());
		}
	}

	return str;
	//#UC END# *51D6BF11000C*
}

// исключение стоп-слов c учетом hard-словосочетаний
void RequestTransformer_i::exclude_hard (std::string& req, const GCL::StrVector& data, const GCL::StrVector& hard) {
	//#UC START# *53FCB8F600CA*
	for (GCL::StrVector::const_iterator it = hard.begin (); it != hard.end (); ++it) {
		if (std::find (it->begin (), it->end (), ' ') == it->end ()) {
			std::string str = *it;
			std::replace_if (str.begin (), str.end (), boost::is_any_of ("-~"), ' ');

			size_t pos = req.find (str);

			if (pos != std::string::npos) {
				if (pos == 0 || req [pos - 1] == ' ') {
					std::copy (it->begin (), it->end (), req.begin () + pos);
				}
			}
		} else {
			size_t pos = req.find (*it);

			if (pos != std::string::npos) {
				if (pos == 0 || req [pos - 1] == ' ') {
					std::replace (req.begin () + pos, req.begin () + pos + it->size (), ' ', '=');
				}
			}
		}
	}

	this->exclude (req, data, DBComm::PSDTemplates (), true);
	std::replace (req.begin (), req.end (), '=', ' ');
	//#UC END# *53FCB8F600CA*
}

// проверка строки на значения "Г", "Г.", "ГОД",..
bool RequestTransformer_i::is_year (const std::string& str) {
	//#UC START# *51D6B82F0163*
	if (str == "Г." || str == "Г") {
		return true;
	} else if (*(str.rbegin ()) == '!') {
		std::string copy_str = str.substr (0, str.size () - 1);
		return m_normalizer->has_norma (copy_str, std::string ("ГОД"));
	}
	return m_normalizer->has_norma (str, std::string ("ГОД"));
	//#UC END# *51D6B82F0163*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Manage::IRequestTransformer
// корректировка
void RequestTransformer_i::correct (const std::string& in, std::string& out) {
	//#UC START# *51D6B5F8027C_4B5AA66F0097*
	GCL::StrVector parts;
	ContextUtility::split (parts, in, true);

	if (parts.size () > MAX_WORDS_OF_REQUEST) {
		parts.erase (parts.begin () + MAX_WORDS_OF_REQUEST, parts.end ());
	}

	for (GCL::StrVector::iterator it = parts.begin (); it != parts.end (); ++it) {
		if (out.size ()) {
			out += ' ';
		}

		std::string str = *it;

		bool is_date = false;

		if (it->at (0) != 'N') {
			size_t count = std::count_if (it->begin (), it->end (), boost::is_any_of ("./-"));

			if (count == 0 || count == 2) {
				if (ContextUtility::is_date (this->correct_date (str))) {
					std::replace_if (str.begin (), str.end (), boost::is_punct (), ' ');
					is_date = true;
				}
			}

			if (is_date == false && count < 2) {
				if (it + 1 != parts.end ()) {
					std::string str_date = *it + '-' + *(it + 1);

					if (ContextUtility::is_date (this->correct_date (str_date))) {
						str = str_date;
						std::replace_if (str.begin (), str.end (), boost::is_punct (), ' ');
						is_date = true;
						it += 1;
					}
				}
			}

			if (is_date == false && parts.size () - std::distance (parts.begin (), it) > 2) {
				std::string year = *(it + 2);

				if (ContextUtility::is_date (str, *(it + 1), this->correct_date (year))) {
					str += ' ';
					str += *(it + 1);
					str += ' ';
					str += year;
					is_date = true;
					it += 2;
				}
			}
		}

		if (is_date == false) {
			str = *it;
			std::replace_if (str.begin (), str.end (), !boost::bind (&ContextUtility::is_valid_char, _1), '-');
		} else if (it + 1 != parts.end () && this->is_year (*(it + 1))) {
			++it;
		}

		out += str;
	}
	//#UC END# *51D6B5F8027C_4B5AA66F0097*
}

// implemented method from Manage::IRequestTransformer
// исключение стоп-слов
size_t RequestTransformer_i::exclude (
	std::string& req
	, const GCL::StrVector& data
	, const DBComm::PSDTemplates& templates
	, bool is_fake
) {
	//#UC START# *4B5AA43F01EC_4B5AA66F0097*
	GDS_ASSERT (req.empty () == false);

	GCL::to_upper (req);

	std::string str = req;

	RequestTransformer_i::exclude (str, data, is_fake);

	if (is_fake) {
		size_t count = std::count_if (str.begin (), str.end (), boost::is_any_of (" =-~"));

		if (count != str.size ()) { // если во фразе остались слова
			req = str;
		}
	} else if (str.empty () == false) { // если во фразе остались слова
		req = str;
	}

	size_t ret = ContextUtility::get_words_count (req);

	/*
	if (ret > 2) {
		PartsSpeechAnalyzer::set_frames (templates, req);
	}
	*/

	return ret;
	//#UC END# *4B5AA43F01EC_4B5AA66F0097*
}

// implemented method from Manage::IRequestTransformer
// выполнить
GCL::StrVector* RequestTransformer_i::execute (
	const std::string& in
	, const GCL::StrVector& data
	, const GCL::StrVector& hard
	, Defs::StrStrMap& pseudo
) {
	//#UC START# *53FCAB670039_4B5AA66F0097*
	Core::Aptr <GCL::StrVector> ret = m_normalizer->execute_for_phrase (in, pseudo);

	std::for_each (ret->begin (), ret->end ()
		, boost::bind (&RequestTransformer_i::exclude_hard, this, _1, data, hard)
	);

	std::sort (ret->begin (), ret->end ());
	ret->erase (std::unique (ret->begin (), ret->end ()), ret->end ());
	return ret._retn ();
	//#UC END# *53FCAB670039_4B5AA66F0097*
}

// implemented method from Manage::IRequestTransformer
// исключение стоп-слов
void RequestTransformer_i::unchecked_exclude (std::string& req, const GCL::StrVector& data) {
	//#UC START# *528E26DF01E7_4B5AA66F0097*
	GDS_ASSERT (req.empty () == false);

	GCL::to_upper (req);

	RequestTransformer_i::exclude (req, data, false);
	//#UC END# *528E26DF01E7_4B5AA66F0097*
}
} // namespace Manage_i
} // namespace ContextSearch

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

