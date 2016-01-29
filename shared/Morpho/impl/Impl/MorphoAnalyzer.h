////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Morpho/impl/Impl/MorphoAnalyzer.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::Morpho::Impl::MorphoAnalyzer
//
// Сервант реализующий интерфейс алгоритма морфоанализа
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_MORPHO_IMPL_MORPHOANALYZER_H__
#define __SHARED_MORPHO_IMPL_MORPHOANALYZER_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCL/data/std_defs.h"
#include "shared/Morpho/Def/Def.h"

//#UC START# *4E046AA602AA_CUSTOM_INCLUDES*
//#UC END# *4E046AA602AA_CUSTOM_INCLUDES*

namespace Morpho {
namespace Impl {

// Сервант реализующий интерфейс алгоритма морфоанализа
class MorphoAnalyzer {
	SET_OBJECT_COUNTER (MorphoAnalyzer)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declarations
private:
	// Константы алгоритма морфоанализа
	static const size_t LEMMA_BUF_LEN; // размер буффера лемм
	static const size_t MAX_WORD_END; // максимальная длина окончания слова
	static const size_t MIN_LEFT_SIZE; // минимальный размер левой части после отбрасывания окончания

	// Константы для грамматического анализа
	static const unsigned short GRAM_SIZE; // размер буффера
	static const unsigned char DIGIT_PART; // значение части речи для числа
	static const unsigned char UNKNOWN_PART; // значение для неизвестной части речи

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
private:
	// конвертация буффера с леммами в вектор
	static void convert (const char* buf, size_t count, GCL::StrVector& out);

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	MorphoAnalyzer (Def::ICache* cache, Def::IMorphoAdapter* adapter);

public:
	virtual ~MorphoAnalyzer ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// части речи для слова
	void get_parts_of_speech (const std::string& word, Def::UCharSet& out);

	// выполнить
	bool lemmatize (const std::string& word, GCL::StrVector& lemmas, Def::AnalysisInfo& info);

private:
	// лемматизация
	short lemmatize (const char* in, char* buf);

	// обработка постфиксов
	void postfixes_analysis (const std::string& word, GCL::StrVector& out);

	// обработка префиксов
	void prefixes_analysis (const std::string& word, GCL::StrVector& out);

	// псевдоморфология
	void pseudo_analysis (const std::string& word, GCL::StrVector& out);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	Def::IMorphoAdapter_var m_adapter;

	Def::ICache_var m_cache;

//#UC START# *4E046AA602AA*
//#UC END# *4E046AA602AA*
}; // class MorphoAnalyzer

} // namespace Impl
} // namespace Morpho


#endif //__SHARED_MORPHO_IMPL_MORPHOANALYZER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

