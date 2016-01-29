////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/RelevancyCore/RelevancyCore.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::ContextSearch::RelevancyCore::RelevancyCore
//
// Базовая реализация алгоритма релевантности
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_RELEVANCYCORE_RELEVANCYCORE_H__
#define __SHARED_CONTEXTSEARCH_RELEVANCYCORE_RELEVANCYCORE_H__

#include "shared/Core/sys/std_inc.h"
#include <vector>
#include "shared/ContextSearch/Relevancy/Relevancy.h"
#include "shared/ContextSearch/RelevancyCore/RelevancyUtility.h"
#include "shared/ContextSearch/Defs/Defs.h"

//#UC START# *4B34CB2302C8_CUSTOM_INCLUDES*
//#UC END# *4B34CB2302C8_CUSTOM_INCLUDES*

namespace ContextSearch {

// Базовая реализация алгоритма релевантности
class RelevancyCore {
	SET_OBJECT_COUNTER (RelevancyCore)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declarations
public:
	// Контейнер для хранения найденных в документе позиций слов
	typedef std::vector < Relevancy::Positions > Chains;

private:
	// Релевантность и позиция фрагмента (для кэширования)
	struct CachedFragment {
		// позиция фрагмента
		size_t pos;
		// релевантность фрагмента
		Defs::RelevancyType rel;
		// длина фрагмента
		size_t len;
		CachedFragment () : pos(0), rel(0), len(0) {
			//#UC START# *4B3A0D0703CB_DEF_INIT_CTOR*
			//#UC END# *4B3A0D0703CB_DEF_INIT_CTOR**cpp*
		}
		//#UC START# *4B3A0D0703CB*
		CachedFragment& operator = (const CachedFragment& copy) {
			pos = copy.pos;
			rel = copy.rel;
			return *this;
		}
		//#UC END# *4B3A0D0703CB*
	};

	// Вектор кэшируемых фрагментов
	typedef std::vector < CachedFragment > CachedFragments;

public:
	// Тип алгоритма расчета релевантности
	enum AlgorithmType {
		rt_None // неизвестный тип
		, rt_SearchDocs // вычисление релевантности при поиске документов
		, rt_SearchInDoc // вычисление релевантности при поиске внутри документа
	};

protected:
	// Класс для вывода данных на консоль (для отладочных целей)
	class DebugInfo {
		SET_OBJECT_COUNTER (DebugInfo)
	//////////////////////////////////////////////////////////////////////////////////////////
	// self methods
	public:
		// печать вектора фрагментов
		static void print (const Relevancy::Fragments& data);

		// печать вектора перестановок
		static void print (const Chains& data, const char* text);

		// печать вектора с позициями
		static void print_positions (const Relevancy::Positions& data);

	private:
		// печать позиции
		static void print_position (unsigned long val);

	}; // class DebugInfo

public:
	// Размеры резервирования памяти
	static const size_t MAX_CHAINS_SIZE; // максимально допустимое количество цепочек
	static const size_t RESERVE_SIZE; // размер резервирования

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
public:
	// вычисление значения релевантности позиции невидимого текста
	static Defs::RelevancyType get_inv_factor (Defs::Position pos, const Defs::InvisibleData& inv_data, const Defs::PositionsRel& rel_data);

protected:
	// сокращение количества блочных цепочек
	static void inv_deflate (Chains& data);

private:
	// слияние цепочек
	static void chains_merge (Relevancy::Positions& x, const Relevancy::Positions& y, size_t pos, bool has_identical);

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	// конструктор
	RelevancyCore (const Relevancy::Data& req_data, const Relevancy::AlgorithmProperties& properties);

public:
	virtual ~RelevancyCore ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
protected:
	// контейнер цепочек (перестановок)
	Chains& chains ();

	// сокращение количества цепочек
	void deflate (Chains& data, const Relevancy::Positions& min_data, size_t pos, bool has_identical);

	// получить фрагменты
	Relevancy::Fragments* get_fragments (const Relevancy::Positions& vect, size_t point);

	// получить фрагменты приписанные к блокам
	Relevancy::Fragments* get_fragments_invb (const Defs::InvisibleData& data);

	// получить инфо о релевантности документа
	void get_relevancy_info (
		Defs::RelevancyInfo& info
		, const Defs::InvisibleData& inv_data
		, const Defs::PositionsRel& rel_data
		, bool has_block
	);

	// получить релевантность для фрагмента
	void get_relevancy_info (
		Defs::RelevancyInfo& info
		, const Relevancy::Positions& vect
		, const Defs::InvisibleData& inv_data
		, const Defs::PositionsRel& rel_data
	);

	// параметры алгоритма релевантности
	const Relevancy::AlgorithmProperties& properties () const;

	// позиции устойчивых словосочетаний
	const Relevancy::Positions& strongs () const;

private:
	// сформировать и добавить фрагмент
	void add_fragment (Defs::RelevancyType rel, const Relevancy::Positions& chain, Relevancy::Fragments& out);

	// вычисление значения релевантности
	Defs::RelevancyType calculate (const RelevancyUtility::RelevancyProperties& prop);

	// вычисление значения релевантности для невидимой блочной перестановки
	Defs::RelevancyType calculate_invb (const RelevancyUtility::RelevancyProperties& prop);

	// проверка на устойчивость и рамочность
	bool check (const Relevancy::Positions& vect);

	// получить релевантность для блочного фрагмента
	void get_relevancy_info_invb (
		Defs::RelevancyInfo& info
		, const Relevancy::Positions& vect
		, const Defs::InvisibleData& inv_data
		, const Defs::PositionsRel& rel_data
	);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	CachedFragments m_cached;

	Chains m_chains;

	size_t m_count;

	size_t m_ext_fragment;

	unsigned long m_flags;

	Relevancy::AlgorithmProperties m_properties;

	size_t m_rcount;

	Relevancy::Data m_req_data;

	AlgorithmType m_type;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
protected:
	unsigned long get_flags () const;

	void set_flags (unsigned long flags);

//#UC START# *4B34CB2302C8*
private:
	struct StrongSpan {
		size_t pos;
		Defs::Positions tmp;
		Defs::Positions first;
		Chains second;

		StrongSpan () : pos (0) {
		}
	};

	Defs::Positions m_chain;
	Defs::Positions m_no_strong;
	Defs::RelevancyParam m_param;
	Defs::InvisibleData m_inv_fake;

	bool m_is_check;

	std::vector <StrongSpan> m_spans;
	Relevancy::IndexChain m_index;

protected:
	bool make_strong (const Relevancy::DataVector& data, StrongSpan& chains);

	void get_relevancy_partial_strong (
		Defs::RelevancyInfo& info
		, const Relevancy::DataVector& data
		, const Defs::PositionsRel& rel_data
	);
//#UC END# *4B34CB2302C8*
}; // class RelevancyCore

} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_RELEVANCYCORE_RELEVANCYCORE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

