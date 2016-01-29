////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/Relevancy/Relevancy.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> shared::ContextSearch::Relevancy
//
// Интерфейсы и типы для алгоритма вычисления релевантности.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_RELEVANCY_H__
#define __SHARED_CONTEXTSEARCH_RELEVANCY_H__

#include "shared/Core/sys/std_inc.h"
#include <vector>
#include "shared/ContextSearch/Defs/Defs.h"

namespace ContextSearch {
namespace Relevancy {

// Вектор позиций слов в документе
typedef Defs::Positions Positions;

// Вектор фрагментов
typedef Defs::Fragments Fragments;

#pragma pack (push, 1)

// Настройки для алгоритма
struct AlgorithmProperties {
	// максимальный размер фрагмента для найденного контекста
	size_t max_fragment;
	// количество слов
	size_t count;
	// реальное кол-во слов
	size_t rcount;
	// сборщик детальной информации о релевантности
	Defs::IRelevancyInfo* info;
	// позиции идентичных
	Positions identical;
	//#UC START# *49DF39F400C1*
	AlgorithmProperties () : count (0), rcount (0), max_fragment (0), info (0) {
	}

	AlgorithmProperties (const AlgorithmProperties& copy) {
		max_fragment = copy.max_fragment;
		identical = copy.identical;
		rcount = copy.rcount;
		count = copy.count;
		info = copy.info;
	}
	//#UC END# *49DF39F400C1*
};

#pragma pack (pop)

// Флаги
static const unsigned long SHOW_INFO = 0x00000010; // показывать отладочную информацию

// Селектор для фабрики
enum AlgorithmSelector {
	as_Default // алгоритм по умолчанию
	, as_Identical // алгоритм для запросов из одинаковых слов
	, as_Single // алгоритм для запросов из одного слова
	, as_Strong // алгоритм для полностью строгих запросов
	, as_Simple // алгоритм для простых запросов
};

#pragma pack (push, 1)

// Данные о рамочном словосочетании
struct Frame {
	// позиция первого слова
	size_t pos;
	// количество слов в рамочном словосочетании
	size_t count;
	//#UC START# *4C9B4F9D036B*
	bool operator == (const Frame& val) const {
		return (pos == val.pos && count == val.count);
	}
	//#UC END# *4C9B4F9D036B*
};

#pragma pack (pop)

// Рамочные фрагменты во фразе
typedef std::vector < Frame > Frames;

#pragma pack (push, 1)

// Входные данные для алгоритма
struct Data {
	// устойчивые позиции
	Positions strongs;
	// список вхождений рамочных фрагментов фразы
	Frames frames;
	//#UC START# *4C9B4EBB004C*
	Data& operator = (const Data& copy) {
		strongs = copy.strongs;
		frames = copy.frames;
		return *this;
	}
	bool operator == (const Data& val) const {
		return (strongs == val.strongs && frames == val.frames);
	}
	//#UC END# *4C9B4EBB004C*
};

#pragma pack (pop)

// Вектор всех позиций слов запроса
typedef std::vector < Positions > DataVector;

class IAlgorithm;
typedef ::Core::Var<IAlgorithm> IAlgorithm_var;
typedef ::Core::Var<const IAlgorithm> IAlgorithm_cvar;
// Интерфейс алгоритма расчета релевантности документа
class IAlgorithm
	: virtual public ::Core::IObject
{
public:
	// расчет релевантности
	virtual void get_relevancy_info (
		Defs::RelevancyInfo& info
		, const DataVector& positions
		, const Defs::InvisibleData& inv_data
		, const Defs::PositionsRel& rel_data
		, bool has_block
	) = 0;

	// получить список релевантных фрагментов
	virtual Fragments* get_fragments (const DataVector& positions) = 0;

	// установить свойство
	virtual void set_property (unsigned long value) = 0;

	// сбросить свойство
	virtual void clear_property (unsigned long value) = 0;

	// получить список релевантных фрагментов приписанных к блочному невидимому тексту
	virtual Fragments* get_block_fragments (const DataVector& positions, const Defs::InvisibleData& inv_data) = 0;

	// расчет релевантности для невидимого блочного
	virtual void get_inv_block_relevancy (
		Defs::RelevancyInfo& info
		, const DataVector& positions
		, const Defs::InvisibleData& inv_data
		, const Defs::PositionsRel& rel_data
	) = 0;
};

/// factory interface for IAlgorithm
class IAlgorithmFactory {
public:
	typedef std::vector<AlgorithmSelector> KeySet;
	
	static KeySet* keys ();
public:
	// фабрика
	static IAlgorithm* make (const Data& req_data, const AlgorithmProperties& properties, AlgorithmSelector key)
		/*throw (Core::Root::UnknownFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;
};

// Интерфейс для сбора детальной информации о релевантности
typedef Defs::IRelevancyInfo IRelevancyInfo;
typedef Defs::IRelevancyInfo_var IRelevancyInfo_var;
typedef Defs::IRelevancyInfo_cvar IRelevancyInfo_cvar;

// Константы
static const unsigned short BASE_FACTOR = 10; // основной коэффициент
static const unsigned short Z_FACTOR = 12; // константа для вычисления параметра Z
static const unsigned short EXT_LEN = 20; // расширение для размера очка

// IndexChain
typedef std::vector < Defs::Positions::const_iterator > IndexChain;

class IBlockAlgorithm;
typedef ::Core::Var<IBlockAlgorithm> IBlockAlgorithm_var;
typedef ::Core::Var<const IBlockAlgorithm> IBlockAlgorithm_cvar;
// Интерфейс алгоритма расчета релевантности документа (для блочных невидимых)
class IBlockAlgorithm
	: virtual public ::Core::IObject
{
public:
	// расчет релевантности
	virtual void get_relevancy_info (
		Defs::RelevancyInfo& info
		, const DataVector& positions
		, const Defs::InvisibleData& inv_data
		, const Defs::PositionsRel& rel_data
	) = 0;

	// список релевантных фрагментов
	virtual Defs::Fragments* get_fragments (const DataVector& positions, const Defs::InvisibleData& inv_data) = 0;
};

/// factory interface for IBlockAlgorithm
class IBlockAlgorithmFactory {
public:
	// фабрика
	static IBlockAlgorithm* make (const Data& req_data, const AlgorithmProperties& properties)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

#pragma pack (push, 1)

// Настройки для операции пересечения цепочек позиций
struct IntersectProp {
	// позиция в цепочке не уникальна
	bool is_identical;
	// позиция в цепочке меньше минимальной
	bool is_first;
	// цепочки привязаны к невидимому блочному тексту
	bool is_block_chain;
	// устойчивая/рамочная позиция
	bool is_strong;
	IntersectProp () : is_block_chain(false) {
		//#UC START# *4A1FCD6900C3_DEF_INIT_CTOR*
			//#UC END# *4A1FCD6900C3_DEF_INIT_CTOR**cpp*
	}
};

#pragma pack (pop)

// Документ  и его релевантность
typedef Defs::RelevancyDocInfo RelevancyDocInfo;

} // namespace Relevancy
} // namespace ContextSearch

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <ContextSearch::Relevancy::IAlgorithm> {
	typedef ContextSearch::Relevancy::IAlgorithmFactory Factory;
};
template <>
struct TypeTraits <ContextSearch::Relevancy::IBlockAlgorithm> {
	typedef ContextSearch::Relevancy::IBlockAlgorithmFactory Factory;
};
} // namespace Core


#endif //__SHARED_CONTEXTSEARCH_RELEVANCY_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
