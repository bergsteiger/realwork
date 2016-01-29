////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ћодуль: "w:/shared/ContextSearch/Common/ContextUtility.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityClass::Class>> shared::ContextSearch::Common::ContextUtility
//
// ‘ункции дл€ анализа контекста
//
//
// ¬се права принадлежат ќќќ Ќѕѕ "√арант-—ервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/Common/ContextUtility.h"
// by <<uses>> dependencies
#include "boost/lexical_cast.hpp"
#include "boost/lambda/lambda.hpp"
#include "boost/algorithm/string/classification.hpp"
#include "boost/algorithm/string/trim.hpp"
#include "boost/algorithm/string/split.hpp"
#include "shared/GCL/str/str_conv.h"
#include "boost/bind.hpp"

namespace ContextSearch {

//////////////////////////////////////////////////////////////////////////////////////////
// nested implementation
// —писок названий мес€цев в родительном падеже
const std::string ContextUtility::MONTHS_GEN [] = {"яЌ¬ј–я", "‘≈¬–јЋя", "ћј–“ј", "јѕ–≈Ћя", "ћјя", "»ёЌя", "»ёЋя", "ј¬√”—“ј", "—≈Ќ“яЅ–я", "ќ “яЅ–я", "ЌќяЅ–я", "ƒ≈ јЅ–я", ""};


// —писок названий мес€цев
const std::string ContextUtility::MONTHS [] = {"яЌ¬ј–№", "‘≈¬–јЋ№", "ћј–“", "јѕ–≈Ћ№", "ћј…", "»ёЌ№", "»ёЋ№", "ј¬√”—“", "—≈Ќ“яЅ–№", "ќ “яЅ–№", "ЌќяЅ–№", "ƒ≈ јЅ–№", ""};


//  онстанты дл€ дат
const short ContextUtility::MIN_DATE = 1920; // минимальна€ дата
const short ContextUtility::MAX_DATE = 2020; // максимальна€ дата

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// возвратить первое слово и смещение на второе  в исходной строке
size_t ContextUtility::get_first_word (std::string& out, const char* src) {
	//#UC START# *4C5FC6AC01E3*
	size_t pos = 0, offset = 0;

	for (const char* ptr = src; *ptr; ++ptr) {
		if (is_valid_char (*ptr) || is_special_char (*ptr)) {
			++offset;
		} else if (offset) {
			break;
		} else {
			++pos;
		}
	}

	if (offset) {
		out.assign (src + pos, offset);

		if (offset != strlen (src)) {
			++offset;
		}
	} else {
		out.clear ();
	}

	return offset;
	//#UC END# *4C5FC6AC01E3*
}

// мес€ц как строка
const char* ContextUtility::get_month (size_t num) {
	//#UC START# *53A80748039E*
	GDS_ASSERT (num > 0 && num <= 12);
	return (num == 0 || num > 12)? 0 : MONTHS [num - 1].c_str ();
	//#UC END# *53A80748039E*
}

// номер мес€ца
size_t ContextUtility::get_month_num (const std::string& str) {
	//#UC START# *53A447970310*
	const std::string* it = std::find (MONTHS, MONTHS + 12, str);

	if (it != MONTHS + 12) {
		return (unsigned char) (std::distance (MONTHS, it) + 1);
	} 

	it = std::find (MONTHS_GEN, MONTHS_GEN + 12, str);
	return (it == MONTHS_GEN + 12)? 0 : (unsigned char) (std::distance (MONTHS_GEN, it) + 1);
	//#UC END# *53A447970310*
}

// получить количество слов во фразе
size_t ContextUtility::get_words_count (const std::string& str) {
	//#UC START# *4B5AC93D0310*
	return (str.empty ())? 0 : std::count_if (str.begin (), str.end (), boost::is_any_of (" -~")) + 1;
	//#UC END# *4B5AC93D0310*
}

// проверка на наличие в строке кириллических символов
bool ContextUtility::has_cyrillic (const std::string& str) {
	//#UC START# *516C054601D8*
	return std::find_if (str.begin (), str.end (), boost::is_from_range ('ј', 'я')) != str.end ();
	//#UC END# *516C054601D8*
}

// проверка на наличие в строке цифр
bool ContextUtility::has_digit (const std::string& str) {
	//#UC START# *4BCD38390292*
	return std::find_if (str.begin (), str.end (), boost::is_from_range ('0', '9')) != str.end ();
	//#UC END# *4BCD38390292*
}

// проверка на наличие значени€ в заданном диапазоне
bool ContextUtility::in_range (short value, short first, short last) {
	//#UC START# *4C638B960219*
	return (value >= first && value <= last);
	//#UC END# *4C638B960219*
}

// проверка на буквоцифры
bool ContextUtility::is_alnum (const std::string& str) {
	//#UC START# *537A17710027*
	if (std::find_if (str.begin (), str.end (), boost::is_from_range ('0', '9')) != str.end ()) {
		if (std::find_if (str.begin (), str.end (), !boost::is_from_range ('0', '9')) != str.end ()) {
			return (std::find_if (str.begin (), str.end (), boost::is_punct ()) == str.end ());
		}
	}
	return false;
	//#UC END# *537A17710027*
}

// проверка на дату
bool ContextUtility::is_date (const std::string& str) {
	//#UC START# *4BCD40E60176*
	if (str.empty () == false) {
		if (str.size () == 4 && is_digit (str)) {
			return in_range (boost::lexical_cast <short> (str), MIN_DATE, MAX_DATE);
		} else {
			GCL::StrVector data;
			ContextUtility::split (data, str, false);
			return ContextUtility::is_date (data);
		}
	}
	return false;
	//#UC END# *4BCD40E60176*
}

// проверка на дату
bool ContextUtility::is_date (const GCL::StrVector& in) {
	//#UC START# *535A6A6D00D5*
	return (in.size () > 2 && is_date (in [0], in [1], in [2]));
	//#UC END# *535A6A6D00D5*
}

// проверка на дату
bool ContextUtility::is_date (const std::string& d, const std::string& m, const std::string& y) {
	//#UC START# *546F3F6B004B*
	if (d.size () < 3 && (y.size () == 2 || y.size () == 4)) {
		if (d.size () + m.size () + y.size () > 4 && is_digit (d) && is_digit (y)) {
			short day = boost::lexical_cast <short> (d);

			if (is_digit (m) && m.size () < 3) {
				short val = boost::lexical_cast <short> (m);

				if (in_range (val, 1, 12) && is_day_valid (day, val)) {
					if (y.size () == 4) {
						return in_range (boost::lexical_cast <short> (y), MIN_DATE, MAX_DATE);
					} else {
						return true;
					}
				}
			} else if (is_month (m) && in_range (day, 1, 31)) {
				if (y.size () == 4) {
					return in_range (boost::lexical_cast <short> (y), MIN_DATE, MAX_DATE);
				} else {
					return true;
				}
			}
		}
	}
	return false;
	//#UC END# *546F3F6B004B*
}

// проверка значени€ дн€ на валидность
bool ContextUtility::is_day_valid (short day, short month) {
	//#UC START# *53D12C410360*
	if (day == 0 || month == 0) {
		return false;
	} else if (month == 2) {
		return (day <= 29);
	} else if (month == 4 || month == 6 || month == 9 || month == 11) {
		return (day <= 30);
	} 
	return (day <= 31);
	//#UC END# *53D12C410360*
}

// проверка на то, что строка состоит только из цифр
bool ContextUtility::is_digit (const std::string& str) {
	//#UC START# *4BCD3D730175*
	return std::find_if (str.begin (), str.end (), boost::lambda::_1 < '0' || boost::lambda::_1 > '9') == str.end ();
	//#UC END# *4BCD3D730175*
}

// сравнение дат
bool ContextUtility::is_equal_date (const GCL::StrVector& x, const GCL::StrVector& y) {
	//#UC START# *53A19CC300EE*
	GDS_ASSERT (x.size () >= 3 && y.size () >= 3);

	if (boost::lexical_cast <short> (x [0]) != boost::lexical_cast <short> (y [0])) {
		return false;
	}

	if (x [1].size () > y [1].size ()) {
		if (ContextUtility::get_month_num (x [1]) != boost::lexical_cast <size_t> (y [1])) {
			return false;
		}
	} else if (x [1].size () < y [1].size ()) {
		if (ContextUtility::get_month_num (y [1]) != boost::lexical_cast <size_t> (x [1])) {
			return false;
		}
	} else if (x [1] != y [1]) {
		return false;
	}

	if (x [2].size () > y [2].size ()) {
		return (y [2].compare (0, y [2].size (), x [2], 2, y [2].size ()) == 0);
	} else if (x [2].size () < y [2].size ()) {
		return (x [2].compare (0, x [2].size (), y [2], 2, x [2].size ()) == 0);
	} 
	
	return x [2] == y [2];
	//#UC END# *53A19CC300EE*
}

// проверка строки на название мес€ца
bool ContextUtility::is_month (const std::string& str) {
	//#UC START# *4BCD511100B7*
	if (str == "ћј≈") {
		return true;
	} else if (std::find (MONTHS_GEN, MONTHS_GEN + 12, str) != MONTHS_GEN + 12) {
		return true;
	} else if (std::find (MONTHS, MONTHS + 12, str) != MONTHS + 12) {
		return true;
	}
	return false;
	//#UC END# *4BCD511100B7*
}

// проверка на специальный символ
bool ContextUtility::is_special_char (char ch) {
	//#UC START# *4C7280A502F9*
	return (
		ch == '_'
		|| ch == '='
		|| ch == '-'
		|| ch == '~'
		|| ch == '/'
		|| ch == '\\' 
		|| ch == '('
		|| ch == ')'
		|| ch == '.'
	);
	//#UC END# *4C7280A502F9*
}

// проверка символа на валидность
bool ContextUtility::is_valid_char (char ch) {
	//#UC START# *4C5AB978011F*
	return (
		ch == '%' || ch == '®' || ch == '*' || ch == '!' || ch == 'є'
		|| ((unsigned char) ch >= (unsigned char) 'ј' && (unsigned char) ch <= (unsigned char) 'я')
		|| ((unsigned char) ch >= (unsigned char) '0' && (unsigned char) ch <= (unsigned char) '9')
		|| ((unsigned char) ch >= (unsigned char) 'A' && (unsigned char) ch <= (unsigned char) 'Z')
	);
	//#UC END# *4C5AB978011F*
}

// замена лексем на их соответствие
void ContextUtility::replace (std::string& out, const StrStrMap& in) {
	//#UC START# *528E0B5F00A9*
	std::string res;
	std::string::const_iterator it = out.begin (), it_end = out.end (), _it = it;

	for (; it != it_end; _it = it) {
		std::string word (_it, it = std::find_if (it, it_end, boost::is_any_of (" -~")));

		StrStrMap::const_iterator f_it = in.find (word);
		res += (f_it != in.end ())? f_it->second : word;

		if (it != it_end) {
			res += *it;
			++it;
		}
	}

	out = res;
	//#UC END# *528E0B5F00A9*
}

// распил строки на отдельные слова с валидацией контекста
void ContextUtility::split (GCL::StrVector& out, const std::string& str, bool is_ext) {
	//#UC START# *4C5BD80802A2*
	out.clear ();
	out.reserve (32);

	std::string word;

	std::string::const_iterator it = str.begin (), find_it = it, it_end = str.end ();

	for (; find_it != it_end && it != it_end; ) {
		for (find_it = it; find_it != it_end; ++find_it) {
			char ch = GCL::char_upper (*find_it);

			if (is_valid_char (ch) == false	&& (is_ext == false || is_special_char (ch) == false)) {
				break;
			}
		}

		if (it != find_it) {
			word.assign (it, find_it);

			GCL::to_upper (word);

			std::replace (word.begin (), word.end (), '®', '≈');
			std::replace (word.begin (), word.end (), 'є', 'N');

			if (is_valid_char (*(word.begin ())) == false) {
				boost::trim_left_if (word, boost::bind (&is_valid_char, _1) == false);
			}

			if (word.empty () == false) {
				if (is_valid_char (*(word.end () - 1)) == false) {
					boost::trim_right_if (word, boost::bind (&is_valid_char, _1) == false);
				} 

				out.push_back (word);
			}
		}

		if (find_it != it_end) {
			it = find_it + 1;
		}
	}
	//#UC END# *4C5BD80802A2*
}

} // namespace ContextSearch

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

