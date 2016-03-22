////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Morpho/Def/Def.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> shared::Morpho::Def
//
// Интерфейсы и типы данных, используемые в алгоритмах  морфоанализа и нормализации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_MORPHO_DEF_H__
#define __SHARED_MORPHO_DEF_H__

#include "shared/Core/sys/std_inc.h"
#include <set>
#include <map>
#include <vector>
#include "shared/DB/DBCore/DBCore.h"
#include "shared/GCL/data/std_defs.h"

namespace Morpho {
namespace Def {

#pragma pack (push, 1)

// Настройки для алгоритма нормализации
struct NSettings {
	// использовать фильтр
	bool use_filter;
	// результат нормализации в виде ключей
	bool as_key;
	NSettings () : use_filter(true), as_key(true) {
		//#UC START# *4E009F7E02D3_DEF_INIT_CTOR*
		//#UC END# *4E009F7E02D3_DEF_INIT_CTOR**cpp*
	}
};

#pragma pack (pop)

// Вид морфологического разбора
enum AnalysisKind {
	ak_Morpho // слово из морфологии Коваленко
	, ak_Prefix // разбор при помощи блока префиксов
	, ak_Postfix // разбор при помощи блока опорных слов
	, ak_NPseudo // разбор при помощи новой псевдоморфологии
	, ak_Pseudo // разбор при помощи старой псевдоморфологии (усечение концов)
	, ak_Unknown // разбор не произошел (например, латиница, цифры)
};

// Окончания для псевдоморфологии
typedef std::map < std::string, std::string > StrStrMap;

#pragma pack (push, 1)

// Данные для морфоанализа
struct MorphoData {
	// список постфиксов
	GCL::StrVector postfixes;
	// список префиксов
	GCL::StrVector prefixes;
	// список стоп-лемм
	GCL::StrVector stop_lemmas;
	// список окончаний для псевдоморфологии
	StrStrMap pseudo;
};

#pragma pack (pop)

// Исключаемые лексемы
typedef std::map < std::string, GCL::StrVector > Exclude;

#pragma pack (push, 1)

// Инфо о морфологическом разборе
struct AnalysisInfo {
	// признак псевдо
	bool is_pseudo;
	// вид разбора
	AnalysisKind kind;
	AnalysisInfo () : is_pseudo(true) {
		//#UC START# *4E733EBB0283_DEF_INIT_CTOR*
		kind = ak_Unknown;
		//#UC END# *4E733EBB0283_DEF_INIT_CTOR**cpp*
	}
};

#pragma pack (pop)

// Множество символов
typedef std::set < unsigned char > UCharSet;

class IMorphoAdapter;
typedef ::Core::Var<IMorphoAdapter> IMorphoAdapter_var;
typedef ::Core::Var<const IMorphoAdapter> IMorphoAdapter_cvar;
// Морфо адаптер
class IMorphoAdapter
	: virtual public ::Core::IObject
{
public:
	// грамматика
	virtual short get_gramm (const char* in, char* out, unsigned short size) = 0;

	// лемматизация
	virtual short lemmatize (const char* in, char* buf, size_t buf_len) = 0;
};

#pragma pack (push, 1)

// Данные кэша
struct CacheData {
	// данные для морфоанализа
	MorphoData data;
	// ненормализуемые лексемы
	GCL::StrVector stops;
	// исключаемые из результата нормализации лексемы
	Exclude exclude;
};

#pragma pack (pop)

#pragma pack (push, 1)

// Опечатка - Исправление
struct FixedPair {
	// опечатка
	std::string mistake;
	// исправление
	std::string correct;
	//#UC START# *5499947E0206*
	bool operator < (const FixedPair& val) const {
		return mistake < val.mistake;
	}
	//#UC END# *5499947E0206*
};

#pragma pack (pop)

// Вектор опечаток и их исправлений
typedef std::vector < FixedPair > FixedPairs;

class ICache;
typedef ::Core::Var<ICache> ICache_var;
typedef ::Core::Var<const ICache> ICache_cvar;
// Интерфейс кэша данных
class ICache
	: virtual public ::Core::IObject
{
public:
	// очистить кэш
	virtual void clear () = 0;

	// исключаемые
	virtual const Exclude& get_exclude () const = 0;

	// вектор опечаток и их исправлений
	virtual const FixedPairs& get_fixed_pairs () const = 0;

	// данные для морфоанализа
	virtual const MorphoData& get_morpho_data () const = 0;

	// ненормализуемые
	virtual const GCL::StrVector& get_not_normalized () const = 0;

	// вектор синонимичных пар
	virtual const FixedPairs& get_syn_pairs () const = 0;

	// загрузка
	virtual void load (DBCore::IBase* base) = 0;
};

// Константы алгоритма нормализации
static const size_t MAX_WORD_LEN = 31; // максимальная длина слова

class INormalizer;
typedef ::Core::Var<INormalizer> INormalizer_var;
typedef ::Core::Var<const INormalizer> INormalizer_cvar;
// Интерфейс алгоритма нормализации формы слова
class INormalizer
	: virtual public ::Core::IObject
{
public:
	// нормализация слова
	virtual GCL::StrSet* execute (const std::string& word, const NSettings& info) = 0;

	// нормализация строки
	virtual GCL::StrSet* execute (const std::string& str) = 0;

	// нормализация слова
	virtual GCL::StrSet* execute (const std::string& word, bool as_key) = 0;

	// нормализация фразы
	virtual GCL::StrVector* execute_for_phrase (const std::string& in) = 0;

	// инфа о морфоразборе
	virtual const AnalysisInfo& get_info () const = 0;

	// части речи для слова
	virtual void get_parts_of_speech (const std::string& word, UCharSet& out) = 0;

	// проверка лексемы на то, что она  имеет заданную нормальную форму
	virtual bool has_norma (const std::string& word, const std::string& norma) = 0;

	// проверка на псевдо
	virtual bool is_pseudo (const std::string& in) = 0;

	// лемматизация
	virtual size_t lemmatize (const char* in, char* out) = 0;
};

} // namespace Def
} // namespace Morpho


#endif //__SHARED_MORPHO_DEF_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
