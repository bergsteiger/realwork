////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Morpho/impl/Impl/Normalizer_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::Morpho::Impl::Normalizer_i
//
// Реализация интерфейса нормализатора
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/Morpho/impl/Impl/Normalizer_i.h"
// by <<uses>> dependencies
#include "boost/bind.hpp"
#include "boost/algorithm/string/classification.hpp"
#include "boost/algorithm/string/split.hpp"
#include "boost/algorithm/string/trim.hpp"
#include "boost/xpressive/xpressive.hpp"
#include "boost/lambda/lambda.hpp"
#include "shared/GCL/str/str_conv.h"
#include "shared/Morpho/impl/Impl/Stemmer.h"

namespace Morpho {
namespace Impl {

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods

// добавить строку
void Normalizer_i::add (GCL::StrVector& out, const std::string& str, char delim) {
	//#UC START# *5478811802FD*
	if (out.empty ()) {
		out.push_back (str);
	} else {
		std::string add_str (1, delim);
		add_str += str;
		std::for_each (out.begin (), out.end (), boost::lambda::_1 += boost::lambda::var (add_str));
	}
	//#UC END# *5478811802FD*
}

// сделать ключ
const std::string& Normalizer_i::make_key (const std::string& in, std::string& out, bool is_pseudo) {
	//#UC START# *54F5C0420278*
	out.resize (1, (char) (in.size () + 1));
	out += in;

	if (is_pseudo) {
		out [0] |= 0x80;
	}

	return out;
	//#UC END# *54F5C0420278*
}


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

Normalizer_i::Normalizer_i (Def::ICache* cache, Def::IMorphoAdapter* adapter)
//#UC START# *51508FBA02C2_BASE_INIT*
//#UC END# *51508FBA02C2_BASE_INIT*
{
	//#UC START# *51508FBA02C2_BODY*
	m_cache = Def::ICache::_duplicate (cache);

	m_analyzer = new MorphoAnalyzer (cache, adapter);
	m_filter = new MorphoFilter (cache);
	//#UC END# *51508FBA02C2_BODY*
}

Normalizer_i::~Normalizer_i () {
	//#UC START# *4E00BF3402C9_DESTR_BODY*
	//#UC END# *4E00BF3402C9_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// генерация норм для заданной словоформы
void Normalizer_i::add (const std::string& word, GCL::StrSet& out, const Def::NSettings& info) {
	//#UC START# *4E00D91000B4*
	if (word.empty ()) {
		return;
	}

	std::string copy_word = word;
	GCL::to_upper (copy_word);

	try {
		char ch = *(word.rbegin ());

		if (ch == '*' || ch == '!') {
			out.insert (copy_word);
		} else {
			if (copy_word.size () > Def::MAX_WORD_LEN) {
				copy_word.erase (Def::MAX_WORD_LEN);
			}
			this->get (out, copy_word, info.use_filter, info.as_key);
		}
	} catch (...) {
		LOG_UEX ((GDS_CURRENT_FUNCTION));
	}
	//#UC END# *4E00D91000B4*
}

// добавить леммы
void Normalizer_i::add_word (GCL::StrSet& normas, const std::string& word, bool is_pseudo, bool as_key) {
	//#UC START# *4E01900202CD*
	if (m_cache.is_nil () == false) {
		const Def::FixedPairs& pairs = m_cache->get_syn_pairs ();

		Def::FixedPair item;
		item.mistake = word;

		Def::FixedPairs::const_iterator it = std::lower_bound (pairs.begin (), pairs.end (), item);

		if (it != pairs.end () && it->mistake == item.mistake) {
			if (as_key) {
				std::string key;
				normas.insert (Normalizer_i::make_key (it->correct, key, is_pseudo));
			} else {
				normas.insert (it->correct);
			}
			return;
		} 
	}

	if (as_key) {
		std::string key;
		normas.insert (Normalizer_i::make_key (word, key, is_pseudo));
	} else {
		normas.insert (word);
	}
	//#UC END# *4E01900202CD*
}

// нормализация слова
bool Normalizer_i::get (GCL::StrSet& normas, const std::string& word, bool use_filter, bool as_key) {
	//#UC START# *4E00D416013E*
	if (m_filter->is_lemmatize (word)) {
		if (m_cache.is_nil () == false) {
			const Def::FixedPairs& pairs = m_cache->get_fixed_pairs ();

			Def::FixedPair item;
			item.mistake = word;

			Def::FixedPairs::const_iterator it = std::lower_bound (pairs.begin (), pairs.end (), item);

			if (it != pairs.end () && it->mistake == word) {
				return this->normalize (normas, it->correct, use_filter, as_key);
			}
		}

		return this->normalize (normas, word, use_filter, as_key);
	} 

	this->add_word (normas, word, false, as_key);
	return true;
	//#UC END# *4E00D416013E*
}

// нормализация
void Normalizer_i::normalize (const std::string& word, char delim, GCL::StrVector& reqs) {
	//#UC START# *54787FDB036D*
	if (std::find_if (word.begin (), word.end (), !boost::is_digit ()) == word.end ()) {
		Normalizer_i::add (reqs, word, delim);
	} else if (*(word.rbegin ()) == '*' || *(word.rbegin ()) == '!') {
		Normalizer_i::add (reqs, word, delim);
	} else {
		Core::Aptr <GCL::StrSet> res = this->execute (word, false);

		if (reqs.size ()) {
			GCL::StrVector tmp;

			for (GCL::StrVector::const_iterator it = reqs.begin (); it != reqs.end (); ++it) {
				std::string prev = *it + delim;

				for (GCL::StrSet::const_iterator _it = res->begin (); _it != res->end (); ++_it) {
					tmp.push_back (prev + *_it);
				}
			}

			reqs.swap (tmp);
		} else {
			reqs.assign (res->begin (), res->end ());
		}
	}
	//#UC END# *54787FDB036D*
}

// нормализация слова
bool Normalizer_i::normalize (GCL::StrSet& normas, const std::string& word, bool use_filter, bool as_key) {
	//#UC START# *5499A60C00CA*
	GCL::StrVector lemmas;

	bool ret = m_analyzer->lemmatize (word, lemmas, m_info);

	if (lemmas.empty ())  {
		size_t word_len = Stemmer::execute (word); // стемминг

		if (word.size () == word_len) {
			this->add_word (normas, word, true, as_key);
		} else {
			std::string truncated_word = word.substr (0, word_len);

			if (m_analyzer->lemmatize (truncated_word, lemmas, m_info)) {
				this->add_word (normas, word, true, as_key);
			} else {
				this->add_word (normas, truncated_word, true, as_key);
			}
		}
	} else {
		if (use_filter) {
			m_filter->execute (word, lemmas);
		}

		std::for_each (lemmas.begin (), lemmas.end ()
			, boost::bind (&Normalizer_i::add_word, this, boost::ref (normas), _1, !ret, as_key)
		);
	}

	return ret;
	//#UC END# *5499A60C00CA*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Def::INormalizer
// нормализация слова
GCL::StrSet* Normalizer_i::execute (const std::string& word, const Def::NSettings& info) {
	//#UC START# *4E009A4F0317_4E00BF3402C9*
	Core::Aptr <GCL::StrSet> ret = new GCL::StrSet ();
	this->add (word, *ret, info);
	return ret._retn ();
	//#UC END# *4E009A4F0317_4E00BF3402C9*
}

// implemented method from Def::INormalizer
// нормализация строки
GCL::StrSet* Normalizer_i::execute (const std::string& str) {
	//#UC START# *4E009EE70005_4E00BF3402C9*
	Core::Aptr <GCL::StrSet> ret = new GCL::StrSet ();

	GCL::StrVector parts;
	boost::split (parts, str, boost::is_punct () || boost::is_space (), boost::token_compress_on);

	for (GCL::StrVector::const_iterator it = parts.begin (); it != parts.end (); ++it) {
		Core::Aptr <GCL::StrSet> res = this->execute (*it, false);

		if (res.is_nil () == false) {
			ret->insert (res->begin (), res->end ());
		}
	}

	return ret._retn ();
	//#UC END# *4E009EE70005_4E00BF3402C9*
}

// implemented method from Def::INormalizer
// нормализация слова
GCL::StrSet* Normalizer_i::execute (const std::string& word, bool as_key) {
	//#UC START# *4E09F6100220_4E00BF3402C9*
	Def::NSettings info;
	info.as_key = as_key;
	return this->execute (word, info);
	//#UC END# *4E09F6100220_4E00BF3402C9*
}

// implemented method from Def::INormalizer
// нормализация фразы
GCL::StrVector* Normalizer_i::execute_for_phrase (const std::string& in) {
	//#UC START# *54787669018C_4E00BF3402C9*
	Core::Aptr <GCL::StrVector> ret = new GCL::StrVector ();

	std::string trim_str = boost::trim_copy_if (in, boost::is_any_of (" -~"));

	GCL::StrVector parts;
	boost::split (parts, trim_str, boost::is_space (), boost::token_compress_on);

	using namespace boost::xpressive;

	for (GCL::StrVector::const_iterator it = parts.begin (); it != parts.end (); ++it) {
		if (std::find_if (it->begin (), it->end (), boost::is_any_of ("~-")) != it->end ()) {
			GCL::StrVector words, delim;

			sregex re = repeat <1,10> ((set = '-', '~'));
			sregex_token_iterator end;

			delim.assign (sregex_token_iterator (it->begin (), it->end (), re), end);
			words.assign (sregex_token_iterator (it->begin (), it->end (), re, -1), end);

			for (size_t i = 0; i < words.size (); ++i) {
				this->normalize (words [i], (i)? delim [i - 1].at (0) : ' ', *ret);
			}
		} else {
			this->normalize (*it, ' ', *ret);
		}
	}

	return ret._retn ();
	//#UC END# *54787669018C_4E00BF3402C9*
}

// implemented method from Def::INormalizer
// инфа о морфоразборе
const Def::AnalysisInfo& Normalizer_i::get_info () const {
	//#UC START# *515318480147_4E00BF3402C9*
	return m_info;
	//#UC END# *515318480147_4E00BF3402C9*
}

// implemented method from Def::INormalizer
// части речи для слова
void Normalizer_i::get_parts_of_speech (const std::string& word, Def::UCharSet& out) {
	//#UC START# *55082B670369_4E00BF3402C9*
	m_analyzer->get_parts_of_speech (word, out);
	//#UC END# *55082B670369_4E00BF3402C9*
}

// implemented method from Def::INormalizer
// проверка лексемы на то, что она  имеет заданную нормальную форму
bool Normalizer_i::has_norma (const std::string& word, const std::string& norma) {
	//#UC START# *4E64F05F0180_4E00BF3402C9*
	if (norma.size () > 1) {
		std::string key = norma;
		GCL::to_upper (key);

		Core::Aptr <GCL::StrSet> normas = this->execute (word, false);
		return std::binary_search (normas->begin (), normas->end (), key);
	}

	return false;
	//#UC END# *4E64F05F0180_4E00BF3402C9*
}

// implemented method from Def::INormalizer
// проверка на псевдо
bool Normalizer_i::is_pseudo (const std::string& in) {
	//#UC START# *565DBBD502E9_4E00BF3402C9*
	if (m_filter->is_lemmatize (in)) {
		GCL::StrVector data;
		return !m_analyzer->lemmatize (in, data, m_info);
	}
	return false;
	//#UC END# *565DBBD502E9_4E00BF3402C9*
}

// implemented method from Def::INormalizer
// лемматизация
size_t Normalizer_i::lemmatize (const char* in, char* out) {
	//#UC START# *4E009DD60296_4E00BF3402C9*
	if (strchr (in, '|')) {
		strcpy (out, in);
		for (char *ptr = out; *ptr; ptr++) {
			if (*ptr == '|') {
				*ptr = '-';
			}
		}
		return 1;
	}

	std::string copy_word = in;

	GCL::to_upper (copy_word);

	GCL::StrSet normas;

	bool is_pseudo = (this->get (normas, copy_word, true, false) == false);

	size_t cur_size = 0;

	char* ptr = out;

	for (GCL::StrSet::const_iterator it = normas.begin (); it != normas.end (); ++it) {
		cur_size = std::min <size_t> (it->size () + 1, Def::MAX_WORD_LEN);
		::memcpy (ptr, it->c_str (), cur_size);
		ptr += cur_size;
	}

	*ptr = 0;

	return (is_pseudo)? 0 : normas.size ();
	//#UC END# *4E009DD60296_4E00BF3402C9*
}
} // namespace Impl
} // namespace Morpho

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

