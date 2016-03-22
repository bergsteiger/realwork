////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/MorphoBase/Synonymizer.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::ContextSearch::MorphoBase::Synonymizer
//
// Синонимизатор
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/MorphoBase/Synonymizer.h"
// by <<uses>> dependencies
#include "boost/bind.hpp"
#include "boost/algorithm/string/classification.hpp"
#include "boost/lexical_cast.hpp"
#include "shared/ContextSearch/Common/ContextUtility.h"
#include "boost/algorithm/string/split.hpp"

//#UC START# *53567E4D0007_CUSTOM_INCLUDES*
#include "boost/algorithm/string/trim.hpp"
#include "boost/xpressive/xpressive.hpp"
#include "boost/xpressive/regex_actions.hpp"
//#UC END# *53567E4D0007_CUSTOM_INCLUDES*

namespace ContextSearch {

//#UC START# *53567E4D0007*
static const std::string str_SET = "SET";

Synonymizer::ExprType Synonymizer::get_expr_type (
	std::string::const_iterator beg, std::string::const_iterator end
) {
	size_t sz = std::distance (beg, end);

	bool is_digit = (*beg >= '0' && *beg <= '9');

	if (sz == 0) {
		GDS_ASSERT (0);
	} else if (sz == 1) {
		return (is_digit)? et_Digit : et_Simple;
	} else if (sz > 2 && sz < 5 && *(beg + 1) == ':') {
		return et_Colon;
	} else if (is_digit && std::find_if (beg, end, !boost::is_digit ()) == end) {
		return et_Digit;
	} else if (sz > 2 && std::find_if (beg, end, boost::is_any_of ("^|")) != end) {
		return et_Bool;
	} else if (sz > 5 && *beg == 'S') {
		return et_Set;
	}

	return et_None;
}

bool Synonymizer::check (
	std::string& out
	, std::string::const_iterator i_beg
	, std::string::const_iterator i_end
	, std::string::const_iterator s_beg
	, std::string::const_iterator s_end
) {
	using namespace boost::xpressive;

	sregex re = '<' >> +~(set = '>') >> '>';
	sregex_token_iterator cur (s_beg, s_end, re, -1), end;

	std::string::const_iterator prev, it = i_beg;

	for (; cur != end; ++cur) {
		const std::string& span = *cur;

		if (span.empty () == false) {
			it = std::search (prev = it, i_end, span.begin (), span.end ());

			if (it == i_end) {
				return false;
			} 
			
			if (prev != it) {
				out.append (prev, it);
			}

			it += span.size ();
		}
	}

	if (it != i_end) {
		out.append (it, i_end);
	}

	return true;
}

bool Synonymizer::check_set (
	std::string& str
	, std::string& span
	, std::string::const_iterator s_beg
	, std::string::const_iterator s_end
	, bool strong
) {
	std::string::const_iterator f_it, l_it;
	f_it = std::search (s_beg, s_end, str_SET.begin (), str_SET.end ());

	if (f_it != s_end) {
		f_it = std::find (f_it, s_end, '(');
		l_it = std::find (f_it, s_end, ')');

		if (f_it != s_end && l_it != s_end) {
			return Synonymizer::is_exist (str, span, f_it + 1, l_it, strong);
		}
	}

	return false;
}

bool Synonymizer::is_exist (
	std::string& str
	, std::string& span
	, std::string::const_iterator s_beg
	, std::string::const_iterator s_end
	, bool strong
) {
	using namespace boost::xpressive;

	sregex re = +~(set = ',');
	sregex_token_iterator cur (s_beg, s_end, re), end;

	for (; cur != end; ++cur) {
		const std::string& val = *cur;

		if (strong) {
			if (val == str) {
				return true;
			}
		} else if (val.size () <= str.size ()) {
			if (val.compare (0, val.size (), str, 0, val.size ()) == 0) {
				span = val;
				str.erase (str.begin (), str.begin () + span.size ());
				return true;
			}
		}
	}

	return false;
}

bool Synonymizer::check_simple (std::string& str, std::string& span, char attr, bool strong) {
	if (strong) {
		return this->check (str, attr);
	} else {
		std::string::iterator it;

		if (attr == 'X') {
			it = std::find_if (str.begin (), str.end (), !boost::is_digit ());
		} else if (attr == 'W') {
			it = std::find_if (str.begin (), str.end (),  boost::is_digit ());
		} else {
			it = str.end (); // неизвестно где граница
		}

		if (it != str.begin ()) {
			span.assign (str.begin (), it);

			if (attr == 'X' || attr == 'W' || attr == 'Z' || this->check (span, attr)) {
				str.erase (str.begin (), it);
				return true;
			}
		}
	}

	return false;
}

bool Synonymizer::check_bool (
	std::string& str
	, std::string& span
	, std::string::const_iterator beg
	, std::string::const_iterator end
	, bool strong
) {
	GDS_ASSERT (beg != end);

	bool ret = false;

	char op = '|';

	for (std::string::const_iterator it = beg, it_end = beg; ; ++it_end) {
		it_end = std::find_if (it = it_end, end, boost::is_any_of ("^|"));

		if (op == '|') {
			if (ret == false) {
				ret = this->check (str, span, it, it_end, strong);

				if (ret && strong) {
					span = str;
				}
			}
		} else if (op == '^') {
			if (ret == false || this->check (span, span, it, it_end, true)) {
				return false;
			}
		} else {
			GDS_ASSERT (0); // неизвестная операция
		}

		if (it_end == end) {
			break;
		} 

		op = *it_end;
	}

	return ret;
}

bool Synonymizer::check_len (
   std::string& str
   , std::string& span
   , std::string::const_iterator beg
   , std::string::const_iterator end
   , bool strong
) {
	GDS_ASSERT (beg != end);

	size_t len = boost::lexical_cast <size_t> (std::string (beg + 2, end));

	if (strong) {
		return (len == str.size () && this->check (str, *beg));
	} else if (len <= str.size ()) {
		std::string::iterator it = std::find_if (str.begin (), str.end (), !boost::is_digit ());

		if (it == str.end ()) {
			span = str.substr (0, len);
		} else {
			span.assign (str.begin (), it);
		}

		if (len == span.size () && this->check (span, *beg)) {
			str = str.substr (len);
			return true;
		}
	}

	return false;
}

bool Synonymizer::check (
	std::string& str
	, std::string& span
	, std::string::const_iterator beg
	, std::string::const_iterator end
	, bool strong
) {
	if (str.empty ()) {
		return false;
	}

	switch (Synonymizer::get_expr_type (beg, end)) {
		case et_Simple:
			return this->check_simple (str, span, *beg, strong);
		case et_Colon:
			return this->check_len (str, span, beg, end, strong);
		case et_Bool:
			return this->check_bool (str, span, beg, end, strong);
		case et_Set:
			return Synonymizer::check_set (str, span, beg, end, strong);
		case et_Digit:
			{
				unsigned short val = boost::lexical_cast <unsigned short> (std::string (beg, end));

				if (this->check (str, (unsigned char) (val & 0xFF), (unsigned char) (val & 0xFF))) {
					span = str;
					return true;
				}
			}
	}

	return false;
}
//#UC END# *53567E4D0007*

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods

// поиск синонимичного вхождения
bool Synonymizer::find (const std::string& str, const DBComm::Synonyms& syns, DBComm::Synonyms::const_iterator& it) {
	//#UC START# *5356829202C0*
	DBComm::SynPair pair;
	pair.key = str;

	it = std::lower_bound (syns.begin (), syns.end (), pair);

	if (it != syns.end ()) {
		it = std::find_if (it, syns.end ()
			, boost::bind (&is_syn, str, boost::bind (&DBComm::Synonyms::value_type::key, _1))
		);
	}

	return (it != syns.end ());
	//#UC END# *5356829202C0*
}

// проверка на синоним
bool Synonymizer::is_syn (const std::string& str, const std::string& syn) {
	//#UC START# *5356836B03D8*
	if (str [0] == syn [0]) {
		if (syn.size () == str.size ()) {
			return (syn == str);
		} else if (syn.size () < str.size () && str [syn.size ()] == ' ') {
			return (syn.compare (0, syn.size (), str, 0, syn.size ()) == 0);
		}
	}

	return false;
	//#UC END# *5356836B03D8*
}

// трансформация шаблонного выражения
void Synonymizer::transform (std::string& str, EnvMap& env) {
	//#UC START# *5369E19C0156*
	using namespace boost::xpressive;
	sregex re = '[' >> (s1 = +_d) >> ']';
	str = regex_replace (str, re, boost::xpressive::ref (env) [s1]);
	//#UC END# *5369E19C0156*
}

// разделение буквоцифр
const std::string& Synonymizer::split (std::string& str) {
	//#UC START# *5370A9BC0006*
	using namespace boost::xpressive;

	EnvMap env;
	{
		placeholder <EnvMap> _map;

		sregex re = (s1 = +~_d) [boost::xpressive::ref (env) [s1] = as <std::string> (s1)];
		sregex_iterator it (str.begin (), str.end (), re, let (_map = env));
		sregex_iterator end;

		while (it != end) {
			++it;
		}
	}

	std::string delim ("-");

	for (EnvMap::iterator it = env.begin (); it != env.end (); ++it) {
		it->second = delim + it->second + delim;
	}

	sregex re = (s1 = +~_d);
	str = regex_replace (str, re, boost::xpressive::ref (env)[s1]);
	boost::trim_if (str, boost::is_any_of (" -"));
	return str;
	//#UC END# *5370A9BC0006*
}

// синонимизация даты
Search::Phrase* Synonymizer::get_dates (const std::string& str, size_t& offset) {
	//#UC START# *53A416AC0109*
	offset = 0;

	if (str [0] >= '0' && str [0] <= '9') {
		GCL::StrVector parts;
		boost::split (parts, str, boost::is_space ());

		if (ContextUtility::is_date (parts)) {
			offset = parts [0].size () + parts [1].size () + parts [2].size () + 2;

			std::string src;

			if (parts [1].size () == 1) {
				src = parts [0] + '-' + parts [1] + '-' + parts [2];
			}

			Core::Aptr <Search::Phrase> ret = new Search::Phrase (2);

			if (parts [0].size () == 1) {
				ret->at (0) += '0';
				ret->at (0) += parts [0];
			} else if (parts [0].at (0) == '0') {
				ret->at (0) += parts [0].at (1);
			} else {
				ret->at (0) += parts [0];
			}

			ret->at (0) += '-';
			ret->at (1) += parts [0] + '-';

			{
				size_t val = 0;

				if (ContextUtility::is_digit (parts [1])) {
					val = boost::lexical_cast <size_t> (parts [1]);
				} else {
					val = ContextUtility::get_month_num (parts [1]);
				}

				GDS_ASSERT (val);

				if (val < 10) {
					ret->at (0) += '0';
				}

				ret->at (0) += boost::lexical_cast <std::string> (val);
				ret->at (0) += '-';
				ret->at (0) += parts [2];

				ret->at (1) += ContextUtility::get_month (val);
				ret->at (1) += '-';
			}

			if (parts [2].size () == 2) {
				short year = boost::lexical_cast <short> (parts [2]);

				ret->at (1) += (year > 20)? "19" : "20";
				ret->at (1) += parts [2];
			} else {
				ret->at (1) += parts [2].erase (0, 2);
			} 

			if (src.empty () == false) {
				ret->push_back (src.c_str ());
			}

			return ret._retn ();
		}
	}

	return 0;
	//#UC END# *53A416AC0109*
}


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

Synonymizer::Synonymizer (DBComm::IDBCommunicator* comm, Morpho::Def::INormalizer* normalizer)
//#UC START# *53567E7A0000_BASE_INIT*
	: m_communicator (comm)
	, m_normalizer (normalizer)
//#UC END# *53567E7A0000_BASE_INIT*
{
	//#UC START# *53567E7A0000_BODY*
	//#UC END# *53567E7A0000_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// проверка на принадлежность к части речи
bool Synonymizer::check (const std::string& str, unsigned char x, unsigned char y) {
	//#UC START# *535FE04F02B3*
	PartsSpeechCache::iterator it = m_cache.find (str);

	if (it == m_cache.end ()) {
		it = m_cache.insert (PartsSpeechCache::value_type (str, Morpho::Def::UCharSet ())).first;
		m_normalizer->get_parts_of_speech (str, it->second);
	} 

	return (std::find_if (it->second.begin (), it->second.end (), boost::is_from_range (x, y)) != it->second.end ());
	//#UC END# *535FE04F02B3*
}

// проверка на соответствие стереотипу
bool Synonymizer::check (const std::string& str, char attr) {
	//#UC START# *56A0DA8502F7*
	switch (attr) {
		case 'X':
			return (std::find_if (str.begin (), str.end (), !boost::is_digit ()) == str.end ());
		case 'W':
			return (std::find_if (str.begin (), str.end (),  boost::is_digit ()) == str.end ());
		case 'V':
			return this->check (str, 1, 6);
		case 'N':
			return this->check (str, 7, 24);
		case 'A':
			return this->check (str, 25, 26);
		case 'P':
			return this->check (str, 27, 32);
		case 'D':
			return this->check (str, 33, 36);
		case 'I':
			return this->check (str, 37, 42);
		case 'G':
			return this->check (str, 43, 47);
		case 'U':
			return this->check (str, 48, 54);
		case 'S':
			return this->check (str, 59, 60);
		case 'Z':
			return true;
	}

	return false;
	//#UC END# *56A0DA8502F7*
}

// поиск синонимичного вхождения удовлетворяющего шаблону
bool Synonymizer::find_template (
	const std::string& str
	, const DBComm::Synonyms& syns
	, DBComm::Synonyms::const_iterator& it
	, Pattern& out
) {
	//#UC START# *5369DA1F0249*
	if (syns.empty ()) {
		return false;
	}

	size_t count = std::count_if (str.begin (), str.end (), boost::is_any_of (" -~"));

	for (it = syns.begin (); it != syns.end (); ++it) {
		size_t _count = std::count_if (it->key.begin (), it->key.end (), boost::is_any_of (" -~"));

		if (_count <= count) {
			break;
		}
	}

	if (it != syns.end ()) {
		it = std::find_if (it, syns.end ()
			, boost::bind (&Synonymizer::is_template, this, str
			, boost::bind (&DBComm::Synonyms::value_type::key, _1), boost::ref (out))
		);
	}

	return (it != syns.end ());
	//#UC END# *5369DA1F0249*
}

// генерация
void Synonymizer::generate (const std::string& str, Search::PhraseEx& out) {
	//#UC START# *53567ECC0088*
	Search::PhraseEx tmp;

	std::string word, rest;

	size_t offset = 0;

	for (const char* req = str.c_str (); *req; req += offset) {
		rest = req;

		Core::Aptr <Search::Phrase> res = this->get (rest, offset);

		if (offset) {
			tmp.push_back (Search::StringSet (res->begin (), res->end ()));
		} else {
			offset = ContextUtility::get_first_word (word, req);
			tmp.push_back (Search::StringSet ());
			tmp.back ().insert (word);

			if (ContextUtility::is_alnum (word)) {
				tmp.back ().insert (Synonymizer::split (word));
			}
		}
	}

	if (out.empty ()) {
		out = tmp;
	} else if (out.size () == tmp.size ()) {
		for (size_t i = 0; i < out.size (); ++i) {
			out [i].insert (tmp [i].begin (), tmp [i].end ()); // merge
		}
	} else {
		throw Search::InvalidSpans ();
	}
	//#UC END# *53567ECC0088*
}

// синонимизация
Search::PhraseEx* Synonymizer::get (const Search::Phrase& in) {
	//#UC START# *53568B0E0310*
	GDS_ASSERT (in.empty () == false);

	Core::Aptr <Search::PhraseEx> ret = new Search::PhraseEx ();

	std::for_each (in.begin (), in.end () // синонимизация
		, boost::bind (&Synonymizer::generate, this, _1, boost::ref (*ret))
	);

	return ret._retn ();
	//#UC END# *53568B0E0310*
}

// синонимизация
Search::Phrase* Synonymizer::get (const std::string& str, size_t& offset) {
	//#UC START# *5370F5E20174*
	DBComm::Synonyms::const_iterator it, t_it;

	Core::Aptr <Search::Phrase> res;

	size_t key_size = 0;

	if (Synonymizer::find (str, m_communicator->get_syns (), it)) {
		key_size = it->key.size ();
		res = new Search::Phrase (it->data);
	} else {
		res = Synonymizer::get_dates (str, key_size);
	}

	Pattern pattern;

	if (this->find_template (str, m_communicator->get_templates_syns (), t_it, pattern)) {
		if (pattern.len > key_size) {
			offset = (str.size () == pattern.len)? pattern.len : pattern.len + 1;
			return Synonymizer::get_for_template (pattern.values, t_it->data);
		}
	}

	if (key_size) {
		offset = (str.size () == key_size)? key_size : key_size + 1;
		return res._retn ();
	}

	offset = 0;
	return 0;
	//#UC END# *5370F5E20174*
}

// возвратить список синонимичных замен для шаблона
Search::Phrase* Synonymizer::get_for_template (const Search::Phrase& values, const Search::Phrase& data) {
	//#UC START# *536B5A6E0008*
	GDS_ASSERT (values.empty () == false);

	EnvMap env;

	for (size_t i = 0; i < values.size (); ++i) {
		env [boost::lexical_cast <std::string> (i + 1)] = values [i];
	}

	Core::Aptr <Search::Phrase> ret = new Search::Phrase ();

	for (Search::Phrase::const_iterator it = data.begin (); it != data.end (); ++it) {
		std::string copy_str = *it;
		Synonymizer::transform (copy_str, env);
		Core::Aptr <Search::Phrase> res = m_normalizer->execute_for_phrase (copy_str);
		ret->insert (ret->end (), res->begin (), res->end ());
	}

	return ret._retn ();
	//#UC END# *536B5A6E0008*
}

// проверка на шаблон
bool Synonymizer::is_template (const std::string& str, const std::string& syn, Pattern& out) {
	//#UC START# *535FA333010A*
	out.len = 0;
	out.values.clear ();

	std::string::const_iterator str_it_, str_it = str.begin ();
	std::string::const_iterator syn_it_, syn_it = syn.begin ();

	for (; ; ++str_it, ++syn_it) {
		if (*syn_it != '<' && *syn_it != *str_it) {
			return false;
		}

		str_it = std::find_if (str_it_ = str_it, str.end (), boost::is_any_of (" -~"));
		syn_it = std::find_if (syn_it_ = syn_it, syn.end (), boost::is_any_of (" -~"));

		if (syn_it != syn.end ()) {
			if (str_it == str.end ()) {
				return false;
			} else if (*str_it != *syn_it) {
				return false;
			}
		} else if (str_it != str.end ()) {
			if (*str_it == '-' || *str_it == '~') {
				return false;
			}
		}

		size_t count = std::count (syn_it_, syn_it, '<');

		std::string str_val, val;

		if (count == 0) { // no expression
			if (std::distance (str_it_, str_it) != std::distance (syn_it_, syn_it)) {
				return false;
			}
			if (std::equal (str_it_, str_it, syn_it_) == false) {
				return false;
			}
		} else if (count == 1 && *syn_it_ == '<' && *(syn_it - 1) == '>') { // simple
			str_val.assign (str_it_, str_it);

			if (this->check (str_val, val, syn_it_ + 1, syn_it - 1, true)) {
				out.values.push_back (str_val);
			} else {
				return false;
			}
		} else if (Synonymizer::check (str_val, str_it_, str_it, syn_it_, syn_it)) { // complex
			for (std::string::const_iterator it = syn_it_, l_it = it; it != syn_it;) {
				it = std::find (l_it, syn_it, '<');

				if (it != syn_it) {
					l_it = std::find (it + 1, syn_it, '>');

					if (l_it != syn_it) {
						if (this->check (str_val, val, it + 1, l_it, false)) {
							out.values.push_back (val);
						} else {
							return false;
						}
						++l_it;
					}
				}
			}

			if (str_val.empty () == false) {
				return false;
			}
		} else {
			return false;
		}

		if (syn_it == syn.end ()) {
			break;
		}
	}

	out.len = std::distance (str.begin (), str_it);
	return true;
	//#UC END# *535FA333010A*
}

// нормализация фразы
const std::string& Synonymizer::normalize (std::string& out) const {
	//#UC START# *53ECC2560035*
	std::string str, rest;

	size_t offset = 0;

	DBComm::StrPair pair;
	DBComm::StrPairVector::const_iterator it;

	const DBComm::StrPairVector& data = m_communicator->get_phrasal_replacement ();

	for (const char* req = out.c_str (); *req; req += offset) {
		if (str.empty () == false) {
			str += ' ';
		}

		pair.first = req;

		it = std::lower_bound (data.begin (), data.end (), pair);

		if (it != data.end ()) {
			it = std::find_if (it, data.end ()
				, boost::bind (&is_syn, pair.first
				, boost::bind (&DBComm::StrPairVector::value_type::first, _1))
			);

			if (it != data.end ()) {
				offset = it->first.size ();

				if (pair.first.size () != it->first.size ()) {
					++offset;
				} 

				str += it->second;
				continue;
			}
		}

		offset = ContextUtility::get_first_word (rest, req);
		str += rest;
	}

	if (out != str) {
		out = str;
	}

	return out;
	//#UC END# *53ECC2560035*
}

} // namespace ContextSearch

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

