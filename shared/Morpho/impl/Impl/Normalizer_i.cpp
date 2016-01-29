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
#include "shared/GCL/str/str_conv.h"
#include "boost/algorithm/string/trim.hpp"
#include "shared/Morpho/impl/Impl/Stemmer.h"
#include "shared/Morpho/Common/Helper.h"

namespace Morpho {
namespace Impl {

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods

// добавить варианты лемм
GCL::StrVector* Normalizer_i::correct (const std::string& in) {
	//#UC START# *53B68FEF0309*
	Core::Aptr <GCL::StrVector> ret;

	if (in.size () > 2 && (in [0] == '0' || in [0] == '3')) {
		if (std::find_if (in.begin () + 1, in.end (), boost::is_digit ()) == in.end ()) {
			if (in [0] == '3') {
				ret = new GCL::StrVector (1, in);
				Helper::to_cyr (ret->front ());
				ret->front ().at (0) = 'З';
			} else {
				ret = new GCL::StrVector (2, in);
				Helper::to_cyr (ret->front ());
				ret->front ().at (0) = 'О';
				Helper::to_lat (ret->back ());
				ret->back ().at (0) = 'O';
			}

			return ret._retn ();
		}
	}

	if (Helper::has_lat (in) && Helper::has_cyr (in)) {
		if (Helper::is_cyr (in)) {
			ret = new GCL::StrVector (1, in);
			Helper::to_cyr (ret->front ());
		} else if (Helper::is_lat (in)) {
			ret = new GCL::StrVector (1, in);
			Helper::to_lat (ret->front ());
		} else {
			ret = new GCL::StrVector (2, in);
			Helper::to_cyr (ret->front ());
			Helper::to_lat (ret->back ());
		}
	} else if (Helper::is_surrogate_cyr (in)) {
		ret = new GCL::StrVector (1, in);
		Helper::to_cyr (ret->front ());
	} else if (Helper::is_surrogate_lat (in)) {
		ret = new GCL::StrVector (1, in);
		Helper::to_lat (ret->front ());
	} 

	return ret._retn ();
	//#UC END# *53B68FEF0309*
}

// добавить строку
void Normalizer_i::add (GCL::StrVector& out, const std::string& str, char delim) {
	//#UC START# *5478811802FD*
	if (out.empty ()) {
		out.push_back (str);
	} else {
		std::string add_str;
		add_str += delim;
		add_str += str;

		std::transform (out.begin (), out.end (), out.begin ()
			, boost::bind (std::plus <std::string> (), _1, boost::cref (add_str))
		);
	}
	//#UC END# *5478811802FD*
}

// добавить значения
void Normalizer_i::add_ (const GCL::StrSet& in, GCL::StrVector& out, const std::string& word, const std::string& prev, Def::StrStrMap& pseudo) {
	//#UC START# *5478820A002D*
	std::string val;

	for (GCL::StrSet::const_iterator it = in.begin (); it != in.end (); ++it) {
		val = it->substr (1);

		if (it->at (0) & 0x80) {
			pseudo [val] = word;
		}

		out.push_back (prev + val);
	}
	//#UC END# *5478820A002D*
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
void Normalizer_i::add (const std::string& word, std::string& forma, GCL::StrSet& out, const Def::NSettings& info) {
	//#UC START# *4E00D91000B4*
	size_t word_size = word.size ();

	forma.clear ();

	if (word_size) {
		std::string clear_word = word;

		char ch = word [word_size - 1];

		if (ch == '*' || ch == '!') {
			clear_word.erase (word_size - 1);
		}

		if (clear_word.size () > Def::MAX_WORD_LEN) {
			clear_word.erase (Def::MAX_WORD_LEN);
		}

		GCL::to_upper (clear_word);

		try {
			if (ch == '!') {
				forma = clear_word;
				this->add_word (out, clear_word, false, info.as_key);
			} else {
				this->get (out, clear_word, info.use_filter, info.as_key);

				if (info.is_extended) {
					this->add_syns (out, info.as_key);
				}
			}
		} catch (...) {
			LOG_UEX ((GDS_CURRENT_FUNCTION));
		}
	}
	//#UC END# *4E00D91000B4*
}

// нормализация устойчивой фразы
void Normalizer_i::add_strong (const std::string& str, GCL::StrVector& out) {
	//#UC START# *508936BC023F*
	typedef std::pair <std::string, char> Data;
	typedef std::vector <Data> Parts;

	Parts data;
	data.reserve (64);

	try {
		std::string::const_iterator it = str.begin (), it_end = str.end (), _it = it;

		Data item;

		for (item.second = ' '; it != it_end; _it = it) {
			item.first.assign (_it, it = std::find_if (it, it_end, boost::is_any_of ("-~")));
			data.push_back (item);
			if (it != it_end) {
				item.second = *it;
				++it;
			}
		}
	} catch (...) {
		GDS_ASSERT (0);
	}

	std::string forma;

	Def::NSettings info;
	info.as_key = false;

	for (Parts::const_iterator it = data.begin (); it != data.end (); ++it) {
		if (it->first.empty ()) {
			continue;
		}

		GCL::StrSet normas;

		char ch = *(it->first.rbegin ());

		if (ch == '*' || ch == '!') {
			normas.insert (it->first);
		} else {
			this->add (it->first, forma, normas, info);
		}

		if (out.empty ()) {
			out.insert (out.end (), normas.begin (), normas.end ());
		} else {
			GCL::StrVector tmp;

			for (GCL::StrVector::const_iterator r_it = out.begin (); r_it != out.end (); ++r_it) {
				for (GCL::StrSet::const_iterator _it = normas.begin (); _it != normas.end (); ++_it) {
					tmp.push_back (*r_it + it->second + *_it);
				}
			}

			out = tmp;
		}
	}
	//#UC END# *508936BC023F*
}

// добавить морфо-синонимы
void Normalizer_i::add_syns (GCL::StrSet& normas, bool as_key) {
	//#UC START# *53BC07A0032E*
	if (m_cache.is_nil ()) {
		return;
	}

	const Def::Synonyms& data = m_cache->get_syns ();

	if (data.empty () == false) {
		GCL::StrSet syns;
		GCL::StrVector::const_iterator data_it, it_end;

		GCL::StrSet::const_iterator it;

		for (it = normas.begin (); it != normas.end (); ++it) {
			Def::Synonyms::const_iterator find_it;

			if (as_key) {
				find_it = data.find (*it);
			} else {
				std::string str (1, (char) (it->size () + 1));
				find_it = data.find (str + *it);
			}

			if (find_it != data.end ()) {
				syns.insert (find_it->first);

				it_end = find_it->second.end ();

				for (data_it = find_it->second.begin (); data_it != it_end; ++data_it) {
					syns.insert (*data_it);
				}
			}
		}

		if (syns.empty () == false) {
			if (as_key) {
				normas.insert (syns.begin (), syns.end ());
			} else {
				for (it = syns.begin (); it != syns.end (); ++it) {
					normas.insert (it->substr (1));
				}
			}
		}
	}
	//#UC END# *53BC07A0032E*
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
void Normalizer_i::normalize (const std::string& word, char delim, GCL::StrVector& reqs, Def::StrStrMap& pseudo) {
	//#UC START# *54787FDB036D*
	if (word == "%") {
		Normalizer_i::add (reqs, word, delim);
	} else if (std::find_if (word.begin (), word.end (), boost::is_digit ()) != word.end ()) {
		Normalizer_i::add (reqs, word, delim);
	} else if (*(word.rbegin ()) == '*' || *(word.rbegin ()) == '!') {
		Normalizer_i::add (reqs, word, delim);
	} else {
		Core::Aptr <GCL::StrSet> res = this->execute (word, true);

		if (reqs.size ()) {
			GCL::StrVector tmp;

			for (GCL::StrVector::const_iterator it = reqs.begin (); it != reqs.end (); ++it) {
				Normalizer_i::add_ (*res, tmp, word, *it + delim, pseudo);
			}

			reqs.swap (tmp);
		} else {
			Normalizer_i::add_ (*res, reqs, word, std::string (), pseudo);
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

		if (word.size () != word_len) {
			this->add_word (normas, word.substr (0, word_len), true, as_key);
		} else {
			this->add_word (normas, word, true, as_key);
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
// нормализация слова (если слово оканчивается символом '!', то forma будет не пуст)
GCL::StrSet* Normalizer_i::execute (const std::string& word, std::string& forma, const Def::NSettings& info) {
	//#UC START# *4E009A4F0317_4E00BF3402C9*
	Core::Aptr <GCL::StrSet> ret = new GCL::StrSet ();
	this->add (word, forma, *ret, info);

	if (info.is_extended) {
		Core::Aptr <GCL::StrVector> res = this->correct (word);

		if (res.is_nil () == false) {
			std::string fake;

			std::for_each (res->begin (), res->end ()
				, boost::bind (&Normalizer_i::add, this, _1, fake, boost::ref (*ret), info)
			);
		}
	} 

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
	std::string forma;
	Def::NSettings info;
	info.as_key = as_key;
	return this->execute (word, forma, info);
	//#UC END# *4E09F6100220_4E00BF3402C9*
}

// implemented method from Def::INormalizer
// нормализация слова (если слово оканчивается символом '!', то forma будет не пуст)
GCL::StrSet* Normalizer_i::execute (const GCL::StrSet& in, std::string& forma, const Def::NSettings& info) {
	//#UC START# *4FABBCF80262_4E00BF3402C9*
	Core::Aptr <GCL::StrSet> ret = new GCL::StrSet ();

	for (GCL::StrSet::const_iterator it = in.begin (); it != in.end (); ++it) {
		Core::Aptr <GCL::StrSet> normas = this->execute (*it, forma, info);
		ret->insert (normas->begin (), normas->end ());

		if (forma.empty () == false) {
			GDS_ASSERT (in.size () == 1); // forma должен в этом случае быть пуст
		}
	}

	return ret._retn ();
	//#UC END# *4FABBCF80262_4E00BF3402C9*
}

// implemented method from Def::INormalizer
// нормализация фразы
void Normalizer_i::execute_for_phrase (const std::string& str, GCL::StrVector& out) {
	//#UC START# *4E43DC0E0051_4E00BF3402C9*
	std::string trim_str = boost::trim_left_copy_if (str, boost::is_any_of (" -~"));

	GCL::StrVector parts;
	boost::split (parts, trim_str, boost::is_space (), boost::token_compress_on);

	std::for_each (parts.begin (), parts.end ()
		, boost::bind (&Normalizer_i::add_strong, this, _1, boost::ref (out))
	);
	//#UC END# *4E43DC0E0051_4E00BF3402C9*
}

// implemented method from Def::INormalizer
// нормализация фразы
GCL::StrVector* Normalizer_i::execute_for_phrase (const std::string& in, Def::StrStrMap& pseudo) {
	//#UC START# *54787669018C_4E00BF3402C9*
	Core::Aptr <GCL::StrVector> ret = new GCL::StrVector ();

	GCL::StrVector parts;
	boost::split (parts, in, boost::is_space (), boost::token_compress_on);

	for (GCL::StrVector::const_iterator it = parts.begin (); it != parts.end (); ++it) {
		if (std::find (it->begin (), it->end (), '-') == it->end ()) {
			this->normalize (*it, ' ', *ret, pseudo);
		} else if (std::find_if (it->begin (), it->end (), boost::is_digit ()) == it->end ()) {
			GCL::StrVector words;
			boost::split (words, *it, boost::is_any_of ("-"));

			for (size_t i = 0; i < words.size (); ++i) {
				this->normalize (words [i], (i)? '-' : ' ', *ret, pseudo);
			}
		} else {
			Normalizer_i::add (*ret, *it, ' ');
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
// инициализация вектора с позициями идентичных
void Normalizer_i::init_identical (const Def::PhraseEx& phrase, Def::Positions& out) {
	//#UC START# *4FABB80A0148_4E00BF3402C9*
	typedef std::map <std::string, Def::Positions> IdenticalsMap;

	IdenticalsMap data;

	std::string forma;

	Def::NSettings info;
	info.is_extended = true;
	info.use_filter = false;

	out.clear ();

	for (size_t i = 0; i < phrase.size (); ++i) {
		GCL::StrSet normas;
		GCL::StrSet::const_iterator it;

		for (it = phrase [i].begin (); it != phrase [i].end (); ++it) {
			Core::Aptr <GCL::StrSet> res;

			if (*(it->rbegin ()) == '!') {
				res = this->execute (std::string (it->begin (), it->end () - 1), forma, info);
			} else {
				res = this->execute (*it, forma, info);
			}

			normas.insert (res->begin (), res->end ());
		}

		for (it = normas.begin (); it != normas.end (); ++it) {
			data [*it].push_back ((unsigned long) i);
		}
	}

	for (IdenticalsMap::const_iterator it = data.begin (); it != data.end (); ++it) {
		if (it->second.size () > 1) {
			out.insert (out.end (), it->second.begin (), it->second.end ());
		}
	}

	if (out.empty () == false) {
		std::sort (out.begin (), out.end ());
		out.erase (std::unique (out.begin (), out.end ()), out.end ());

#ifdef _DEBUG
		std::cout << std::endl;
		std::copy (out.begin (), out.end (), std::ostream_iterator <unsigned long> (std::cout, ", "));
		std::cout << std::endl << std::endl;
#endif
	}
	//#UC END# *4FABB80A0148_4E00BF3402C9*
}

// implemented method from Def::INormalizer
// лемматизация
size_t Normalizer_i::lemmatize (const char* in, char* out) {
	//#UC START# *4E009DD60296_4E00BF3402C9*
	if (strchr (in, '|')) {
		strcpy (out, in);
		for (char *ptr = out; *ptr; ptr++)
			if (*ptr == '|')
				*ptr = '-';
		return 1;
	}

	std::string clear_word = in;

	GCL::to_upper (clear_word);

	GCL::StrSet normas;

	bool is_pseudo = (this->get (normas, clear_word, true, false) == false);

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

