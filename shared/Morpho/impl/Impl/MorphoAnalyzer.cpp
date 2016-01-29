////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Morpho/impl/Impl/MorphoAnalyzer.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::Morpho::Impl::MorphoAnalyzer
//
// Сервант реализующий интерфейс алгоритма морфоанализа
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/Morpho/impl/Impl/MorphoAnalyzer.h"
// by <<uses>> dependencies
#include "shared/GCL/str/str_conv.h"
#include "boost/bind.hpp"
#include "boost/lambda/lambda.hpp"

//#UC START# *4E046AA602AA_CUSTOM_INCLUDES*
#include "shared/Adapters/mlmaru/MLMARUAdapter.h"
//#UC END# *4E046AA602AA_CUSTOM_INCLUDES*

namespace Morpho {
namespace Impl {

//#UC START# *4E046AA602AA*
//#UC END# *4E046AA602AA*

//////////////////////////////////////////////////////////////////////////////////////////
// nested implementation
// Константы алгоритма морфоанализа
const size_t MorphoAnalyzer::LEMMA_BUF_LEN = 128; // размер буффера лемм
const size_t MorphoAnalyzer::MAX_WORD_END = 15; // максимальная длина окончания слова
const size_t MorphoAnalyzer::MIN_LEFT_SIZE = 2; // минимальный размер левой части после отбрасывания окончания

// Константы для грамматического анализа
const unsigned short MorphoAnalyzer::GRAM_SIZE = 256; // размер буффера
const unsigned char MorphoAnalyzer::DIGIT_PART = 128; // значение части речи для числа
const unsigned char MorphoAnalyzer::UNKNOWN_PART = 255; // значение для неизвестной части речи

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods

// конвертация буффера с леммами в вектор
void MorphoAnalyzer::convert (const char* buf, size_t count, GCL::StrVector& out) {
	//#UC START# *4E046B5B0271*
	for (char* ptr = const_cast <char*> (buf); count > 0; --count) {
		out.push_back (ptr);
		GCL::to_upper (out.back ());
		ptr += out.back ().size () + 1;
	}
	//#UC END# *4E046B5B0271*
}


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

MorphoAnalyzer::MorphoAnalyzer (Def::ICache* cache, Def::IMorphoAdapter* adapter)
//#UC START# *5151B50003D6_BASE_INIT*
//#UC END# *5151B50003D6_BASE_INIT*
{
	//#UC START# *5151B50003D6_BODY*
	m_cache = Def::ICache::_duplicate (cache);
	m_adapter = Def::IMorphoAdapter::_duplicate (adapter);
	//#UC END# *5151B50003D6_BODY*
}

MorphoAnalyzer::~MorphoAnalyzer () {
	//#UC START# *4E046AA602AA_DESTR_BODY*
	//#UC END# *4E046AA602AA_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// части речи для слова
void MorphoAnalyzer::get_parts_of_speech (const std::string& word, Def::UCharSet& out) {
	//#UC START# *5508160E02F9*
	char gram [GRAM_SIZE];

	short count = 0;

	if (m_adapter.is_nil ()) {
		Adapters::MLMA32RUAdapter* adapter = Adapters::MLMA32RUAdapterSingleton::instance ();

		if (adapter) {
			count = adapter->lemmatize (word.c_str (), 0, 0, 0, gram, 0, 0, GRAM_SIZE);
		}
	} else {
		count = m_adapter->get_gramm (word.c_str (), gram, GRAM_SIZE);
	}

	if (count) {
		char* ptr = gram;

		for (short i = 0; i < count; ++i) {
			int ngrams = *ptr++;

			SGramInfo* info = (SGramInfo*) ptr;
			ptr += ngrams * sizeof (SGramInfo);

			for (; ngrams-- > 0; ++info) {
				out.insert (info->wInfo);
			}
		}
	} else if (std::find_if (word.begin (), word.end (), boost::lambda::_1 < '0' || boost::lambda::_1 > '9') == word.end ()) {
		out.insert (DIGIT_PART);
	} else {
		out.insert (UNKNOWN_PART);
	}
	//#UC END# *5508160E02F9*
}

// выполнить
bool MorphoAnalyzer::lemmatize (const std::string& word, GCL::StrVector& lemmas, Def::AnalysisInfo& info) {
	//#UC START# *5151B4AC0396*
	bool ret = true;

	info.kind = Def::ak_Unknown;

	char buf [LEMMA_BUF_LEN];

	short count = this->lemmatize (word.c_str (), buf);

	if (count > 0) {
		info.kind = Def::ak_Morpho;
		this->convert (buf, (size_t) count, lemmas);
	}

	if (lemmas.empty () && m_cache.is_nil () == false) {
		this->prefixes_analysis (word, lemmas);

		if (lemmas.empty ()) {
			ret = false; // считаем лемму "псевдо"

			this->postfixes_analysis (word, lemmas);

			if (lemmas.empty ()) {
				this->pseudo_analysis (word, lemmas);
				info.kind = (lemmas.empty ())? Def::ak_Pseudo : Def::ak_NPseudo;
			} else {
				info.kind = Def::ak_Postfix;
			}
		} else {
			info.kind = Def::ak_Prefix;
		}
	}

	info.is_pseudo = !ret;
	return ret;
	//#UC END# *5151B4AC0396*
}

// лемматизация
short MorphoAnalyzer::lemmatize (const char* in, char* buf) {
	//#UC START# *51B71EF602E5*
	if (m_adapter.is_nil ()) {
		Adapters::MLMA32RUAdapter* adapter = Adapters::MLMA32RUAdapterSingleton::instance ();

		if (adapter) {
			return adapter->lemmatize (in, 2, buf, 0, 0, LEMMA_BUF_LEN, 0, 0);
		} 
	} else {
		return m_adapter->lemmatize (in, buf, LEMMA_BUF_LEN);
	}

	GDS_ASSERT (0);
	return 0;
	//#UC END# *51B71EF602E5*
}

// обработка постфиксов
void MorphoAnalyzer::postfixes_analysis (const std::string& word, GCL::StrVector& out) {
	//#UC START# *4E046AE2022F*
	const Def::MorphoData& data = m_cache->get_morpho_data ();

	if (data.postfixes.empty ()) {
		return;
	}

	const size_t word_size = word.size ();

	// После отбрасывания постфиксов в слове должно оставаться не менее 2 символов (+ минимум 3 на окончание)
	if (word_size < MIN_LEFT_SIZE + 3) {
		return;
	}

	std::string postfix;

	GCL::StrVector::const_iterator it_begin = data.postfixes.begin (), it_end = data.postfixes.end ();

	for (size_t i = word_size - MIN_LEFT_SIZE; i > 2; --i) {
		postfix = word.substr (i - 1);

		GCL::StrVector::const_iterator find_it = std::find (it_begin, it_end, postfix);

		if (find_it != it_end) {
			for (; find_it->empty () == false; --find_it);
			out.push_back (word.substr (0, i - 1) + *(find_it + 1));
			break;
		}
	}
	//#UC END# *4E046AE2022F*
}

// обработка префиксов
void MorphoAnalyzer::prefixes_analysis (const std::string& word, GCL::StrVector& out) {
	//#UC START# *4E046B070042*
	const Def::MorphoData& data = m_cache->get_morpho_data ();

	if (data.prefixes.empty ()) {
		return;
	}

	const size_t word_size = word.size ();

	// После отбрасывания префиксов в слове должно оставаться не менее 3 символов
	if (word_size < 4) {
		return;
	}

	std::string prefix, part;

	char buf [LEMMA_BUF_LEN];

	for (size_t i = word_size - 3; i > 1; --i) {
		prefix = word.substr (0, i);

		if (std::binary_search (data.prefixes.begin (), data.prefixes.end (), prefix)) {
			part = word.substr (i);

			short count = this->lemmatize (part.c_str (), buf);

			if (count > 0) {
				this->convert (buf, (size_t) count, out);
				break;
			} 
		}
	}

	bool has_stop_lemmas = false;

	GCL::StrVector::iterator it, lemm_end = out.end ();

	// Проверка на принадлежность к списку стоп-лемм
	for (it = out.begin (); it != lemm_end; ++it) {
		if (std::binary_search (data.stop_lemmas.begin (), data.stop_lemmas.end (), *it)) {
			it->clear ();
			has_stop_lemmas = true;
		} else {
			*it = prefix + *it;
		}
	}

	// Если были найдены леммы из списка стоп-слов, то удалим их
	if (has_stop_lemmas) {
		it = std::remove_if (out.begin (), lemm_end, boost::bind (&std::string::empty, _1));
		out.erase (it, lemm_end);
	}
	//#UC END# *4E046B070042*
}

// псевдоморфология
void MorphoAnalyzer::pseudo_analysis (const std::string& word, GCL::StrVector& out) {
	//#UC START# *4E046B3C0129*
	const Def::MorphoData& data = m_cache->get_morpho_data ();

	if (data.pseudo.empty ()) {
		return;
	}

	const size_t word_size = word.size ();

	// Левый остаток и окончание должны составлять не менее 2 символов каждый
	if (word_size < MIN_LEFT_SIZE + 2) {
		return;
	}

	size_t i = (word_size < MAX_WORD_END + MIN_LEFT_SIZE)? MIN_LEFT_SIZE : word_size - MAX_WORD_END;

	Def::StrStrMap::const_iterator find_it, pseudo_end = data.pseudo.end ();

	for (; i < word_size - 1; ++i) {
		find_it = data.pseudo.find (word.substr (i));

		if (find_it != pseudo_end) {
			out.push_back (word.substr (0, i) + find_it->second);
			break;
		}
	}
	//#UC END# *4E046B3C0129*
}

} // namespace Impl
} // namespace Morpho

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

