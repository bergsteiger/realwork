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

bool Synonymizer::is_exist (
	std::string& str
	, std::string& span
	, std::string::const_iterator s_beg
	, std::string::const_iterator s_end
) {
	using namespace boost::xpressive;

	sregex re = +~(set = ',');
	sregex_token_iterator cur (s_beg, s_end, re), end;

	for (; cur != end; ++cur) {
		const std::string& val = *cur;

		if (val.size () <= str.size ()) {
			if (val.compare (0, val.size (), str, 0, val.size ()) == 0) {
				span = val;
				str.erase (str.begin (), str.begin () + span.size ());
				return true;
			}
		}
	}

	return false;
}

bool Synonymizer::is_exist (
	const std::string& str
	, std::string::const_iterator s_beg
	, std::string::const_iterator s_end
) {
	using namespace boost::xpressive;

	sregex re = +~(set = ',');
	sregex_token_iterator cur (s_beg, s_end, re), end;

	for (; cur != end; ++cur) {
		const std::string& val = *cur;

		if (val == str) {
			return true;
		}
	}

	return false;
}

bool Synonymizer::check (const std::string& str, char attr) {
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
}

bool Synonymizer::check (
	const std::string& str
	, std::string::const_iterator beg
	, std::string::const_iterator end
) {
	if (str.empty ()) {
		return false;
	}

	size_t sz = std::distance (beg, end);

	GDS_ASSERT (sz);

	if (sz == 1 && this->check (str, *beg)) {
		return true;
	}
	
	if (sz > 2) {
		if (std::find (beg, end, '|') != end) {
			using namespace boost::xpressive;

			sregex re = +~(set = '|');
			sregex_token_iterator cur (beg, end, re), _end;

			for (; cur != _end; ++cur) {
				const std::string& val = *cur;

				if (this->check (str, val.begin (), val.end ())) {
					return true;
				}
			}
		} else {
			if (sz < 5 && *(beg + 1) == ':') {
				size_t len = boost::lexical_cast <size_t> (std::string (beg + 2, end));
				return (len == str.size () && this->check (str, *beg));
			}

			std::string::const_iterator f_it, l_it;
			f_it = std::search (beg, end, str_SET.begin (), str_SET.end ());

			if (f_it != end) {
				f_it = std::find (f_it, end, '(');
				l_it = std::find (f_it, end, ')');

				if (f_it != end && l_it != end) {
					return Synonymizer::is_exist (str, f_it + 1, l_it);
				}
			}
		}
	} else if (std::find_if (beg, end, !boost::is_digit ()) == end) {
		unsigned short val = boost::lexical_cast <unsigned short> (std::string (beg, end));
		return this->check (str, (unsigned char) (val & 0xFF), (unsigned char) (val & 0xFF));
	}

	return false;
}

bool Synonymizer::check (
	std::string& str
	, std::string& span
	, std::string::const_iterator beg
	, std::string::const_iterator end
) {
	if (str.empty ()) {
		return false;
	}

	size_t sz = std::distance (beg, end);

	GDS_ASSERT (sz);

	if (sz == 1) {
		std::string::iterator it;

		char attr = *beg;

		if (attr == 'Z') {
			it = str.end (); // неизвестно где граница
		} else if (attr == 'X') {
			it = std::find_if (str.begin (), str.end (), !boost::is_digit ());
		} else {
			it = std::find_if (str.begin (), str.end (),  boost::is_digit ());
		}

		if (it != str.begin ()) {
			span.assign (str.begin (), it);
			str.erase (str.begin (), it);

			if (attr == 'X' || attr == 'W' || attr == 'Z') {
				return true;
			} else {
				return this->check (span, attr);
			}
		}
	}
	
	if (sz > 2) {
		if (sz < 5 && *(beg + 1) == ':') {
			size_t len = boost::lexical_cast <size_t> (std::string (beg + 2, end));

			if (len <= str.size ()) {
				span = str.substr (0, len);

				if (this->check (span, *beg)) {
					str = str.substr (len);
					return true;
				} 
			}
		} else {
			std::string::const_iterator f_it, l_it;
			f_it = std::search (beg, end, str_SET.begin (), str_SET.end ());

			if (f_it != end) {
				f_it = std::find (f_it, end, '(');
				l_it = std::find (f_it, end, ')');

				if (f_it != end && l_it != end) {
					return Synonymizer::is_exist (str, span, f_it + 1, l_it);
				}
			}
		}
	} else if (std::find_if (beg, end, !boost::is_digit ()) == end) {
		unsigned short val = boost::lexical_cast <unsigned short> (std::string (beg, end));

		if (this->check (str, (unsigned char) (val & 0xFF), (unsigned char) (val & 0xFF))) {
			span = str;
			return true;
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

// возвратить список синонимичных замен для шаблона
Search::Phrase* Synonymizer::get_for_template (const Search::Phrase& values, const Search::Phrase& data) {
	//#UC START# *536B5A6E0008*
	GDS_ASSERT (values.empty () == false);

	EnvMap env;

	for (size_t i = 0; i < values.size (); ++i) {
		env [boost::lexical_cast <std::string> (i + 1)] = values [i];
	}

	Core::Aptr <Search::Phrase> ret = new Search::Phrase (data);
	std::for_each (ret->begin (), ret->end (), boost::bind (&Synonymizer::transform, _1, env));
	return ret._retn ();
	//#UC END# *536B5A6E0008*
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

// проверка на шаблон
bool Synonymizer::is_template (const std::string& str, const std::string& syn, Pattern& out) {
	//#UC START# *535FA333010A*
	out.len = 0;
	out.values.clear ();

	TemplateType type;

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

		if (count == 0) {
			type = tt_None;
		} else if (count == 1 && *syn_it_ == '<' && *(syn_it - 1) == '>') {
			type = tt_Simple;
		} else {
			type = tt_Complex;
		}

		if (type == tt_Simple) {
			std::string str_val (str_it_, str_it);

			if (this->check (str_val, syn_it_ + 1, syn_it - 1)) {
				out.values.push_back (str_val);
			} else {
				return false;
			}
		} else if (type == tt_Complex) {
			std::string str_val, val;

			if (Synonymizer::check (str_val, str_it_, str_it, syn_it_, syn_it)) {
				std::string::const_iterator it = syn_it_, l_it = it;

				for (; it != syn_it;) {
					it = std::find (l_it, syn_it, '<');

					if (it != syn_it) {
						l_it = std::find (it + 1, syn_it, '>');

						if (l_it != syn_it) {
							if (this->check (str_val, val, it + 1, l_it)) {
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
		} else if (type == tt_None) {
			if (std::distance (str_it_, str_it) != std::distance (syn_it_, syn_it)) {
				return false;
			}

			if (std::equal (str_it_, str_it, syn_it_) == false) {
				return false;
			}
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

