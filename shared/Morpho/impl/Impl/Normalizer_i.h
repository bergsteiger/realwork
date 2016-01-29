////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Morpho/impl/Impl/Normalizer_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::Morpho::Impl::Normalizer_i
//
// Реализация интерфейса нормализатора
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_MORPHO_IMPL_NORMALIZER_I_H__
#define __SHARED_MORPHO_IMPL_NORMALIZER_I_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCL/data/std_defs.h"
#include "shared/Morpho/Def/Def.h"
#include "shared/Morpho/impl/Impl/MorphoFilter.h"
#include "shared/Morpho/impl/Impl/MorphoAnalyzer.h"

namespace Morpho {
namespace Impl {

// Реализация интерфейса нормализатора
class Normalizer_i;
typedef Core::Var<Normalizer_i> Normalizer_i_var;
typedef Core::Var<const Normalizer_i> Normalizer_i_cvar;

class Normalizer_i :
	virtual public Def::INormalizer
	, virtual public Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (Normalizer_i)
//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
private:
	// добавить строку
	static void add (GCL::StrVector& out, const std::string& str, char delim = ' ');

	// добавить значения
	static void add_ (const GCL::StrSet& in, GCL::StrVector& out, const std::string& word, const std::string& prev, Def::StrStrMap& pseudo);

	// добавить варианты лемм
	static GCL::StrVector* correct (const std::string& in);

	// сделать ключ
	static const std::string& make_key (const std::string& in, std::string& out, bool is_pseudo);

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	Normalizer_i (Def::ICache* cache, Def::IMorphoAdapter* adapter);

public:
	virtual ~Normalizer_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// генерация норм для заданной словоформы
	void add (const std::string& word, std::string& forma, GCL::StrSet& out, const Def::NSettings& info);

	// нормализация устойчивой фразы
	void add_strong (const std::string& str, GCL::StrVector& out);

	// добавить морфо-синонимы
	void add_syns (GCL::StrSet& normas, bool as_key);

	// добавить леммы
	void add_word (GCL::StrSet& normas, const std::string& word, bool is_pseudo, bool as_key);

	// нормализация слова
	bool get (GCL::StrSet& normas, const std::string& word, bool use_filter, bool as_key);

	// нормализация
	void normalize (const std::string& word, char delim, GCL::StrVector& reqs, Def::StrStrMap& pseudo);

	// нормализация слова
	bool normalize (GCL::StrSet& normas, const std::string& word, bool use_filter, bool as_key);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	Core::Box<MorphoAnalyzer> m_analyzer;

	Def::ICache_var m_cache;

	Core::Box<MorphoFilter> m_filter;

	Def::AnalysisInfo m_info;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Def::INormalizer
	// нормализация слова (если слово оканчивается символом '!', то forma будет не пуст)
	virtual GCL::StrSet* execute (const std::string& word, std::string& forma, const Def::NSettings& info);

	// implemented method from Def::INormalizer
	// нормализация строки
	virtual GCL::StrSet* execute (const std::string& str);

	// implemented method from Def::INormalizer
	// нормализация слова
	virtual GCL::StrSet* execute (const std::string& word, bool as_key);

	// implemented method from Def::INormalizer
	// нормализация слова (если слово оканчивается символом '!', то forma будет не пуст)
	virtual GCL::StrSet* execute (const GCL::StrSet& in, std::string& forma, const Def::NSettings& info);

	// implemented method from Def::INormalizer
	// нормализация фразы
	virtual void execute_for_phrase (const std::string& str, GCL::StrVector& out);

	// implemented method from Def::INormalizer
	// нормализация фразы
	virtual GCL::StrVector* execute_for_phrase (const std::string& in, Def::StrStrMap& pseudo);

	// implemented method from Def::INormalizer
	// инфа о морфоразборе
	virtual const Def::AnalysisInfo& get_info () const;

	// implemented method from Def::INormalizer
	// части речи для слова
	virtual void get_parts_of_speech (const std::string& word, Def::UCharSet& out);

	// implemented method from Def::INormalizer
	// проверка лексемы на то, что она  имеет заданную нормальную форму
	virtual bool has_norma (const std::string& word, const std::string& norma);

	// implemented method from Def::INormalizer
	// инициализация вектора с позициями идентичных
	virtual void init_identical (const Def::PhraseEx& phrase, Def::Positions& out);

	// implemented method from Def::INormalizer
	// лемматизация
	virtual size_t lemmatize (const char* in, char* out);
}; // class Normalizer_i

} // namespace Impl
} // namespace Morpho


#endif //__SHARED_MORPHO_IMPL_NORMALIZER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

