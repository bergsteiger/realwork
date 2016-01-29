////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/impl/Relevancy_i/SimpleAlgorithm_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::ContextSearch::Relevancy_i::SimpleAlgorithm_i
// Заголовок реализации класса серванта для интерфеса IAlgorithm
//
// Реализация расчета релевантности для простого запроса (без рамочных/строгих связей)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_RELEVANCY_I_SIMPLEALGORITHM_I_H__
#define __SHARED_CONTEXTSEARCH_RELEVANCY_I_SIMPLEALGORITHM_I_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/Relevancy/Relevancy.h"
#include "shared/ContextSearch/Defs/Defs.h"
#include "shared/ContextSearch/RelevancyCore/RelevancyCore.h"

namespace ContextSearch {
namespace Relevancy_i {

class SimpleAlgorithm_i; // self forward Var
typedef ::Core::Var<SimpleAlgorithm_i> SimpleAlgorithm_i_var;
typedef ::Core::Var<const SimpleAlgorithm_i> SimpleAlgorithm_i_cvar;

class SimpleAlgorithm_i_factory;

// Реализация расчета релевантности для простого запроса (без рамочных/строгих связей)
class SimpleAlgorithm_i:
	virtual public Relevancy::IAlgorithm
	, virtual public ::Core::RefCountObjectBase
	, virtual public RelevancyCore
{
	SET_OBJECT_COUNTER (SimpleAlgorithm_i)
	friend class SimpleAlgorithm_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	SimpleAlgorithm_i (const Relevancy::Data& req_data, const Relevancy::AlgorithmProperties& properties);

	virtual ~SimpleAlgorithm_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// добавить перестановку
	void add_chain ();

	// расчет релевантности
	Defs::RelevancyType get_relevancy (const Defs::PositionsRel& rel_data, size_t point, size_t max);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	Defs::IRelevancyInfo* m_collector;

	size_t m_count;

	Relevancy::IAlgorithm_var m_def_algo;

	Relevancy::IndexChain m_index;

	size_t m_max_fragment;

	Defs::RelevancyType m_max_rel;

	Defs::RelevancyParam m_param;

	size_t m_rcount;

	bool m_search_in_doc;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Relevancy::IAlgorithm
	// сбросить свойство
	virtual void clear_property (unsigned long value);

	// implemented method from Relevancy::IAlgorithm
	// получить список релевантных фрагментов приписанных к блочному невидимому тексту
	virtual Relevancy::Fragments* get_block_fragments (
		const Relevancy::DataVector& positions
		, const Defs::InvisibleData& inv_data
	);

	// implemented method from Relevancy::IAlgorithm
	// получить список релевантных фрагментов
	virtual Relevancy::Fragments* get_fragments (const Relevancy::DataVector& positions);

	// implemented method from Relevancy::IAlgorithm
	// расчет релевантности для невидимого блочного
	virtual void get_inv_block_relevancy (
		Defs::RelevancyInfo& info
		, const Relevancy::DataVector& positions
		, const Defs::InvisibleData& inv_data
		, const Defs::PositionsRel& rel_data
	);

	// implemented method from Relevancy::IAlgorithm
	// расчет релевантности
	virtual void get_relevancy_info (
		Defs::RelevancyInfo& info
		, const Relevancy::DataVector& positions
		, const Defs::InvisibleData& inv_data
		, const Defs::PositionsRel& rel_data
		, bool has_block
	);

	// implemented method from Relevancy::IAlgorithm
	// установить свойство
	virtual void set_property (unsigned long value);
}; // class SimpleAlgorithm_i

} // namespace Relevancy_i
} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_RELEVANCY_I_SIMPLEALGORITHM_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
