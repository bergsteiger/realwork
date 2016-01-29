////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/impl/Relevancy_i/StrongAlgorithm_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::ContextSearch::Relevancy_i::StrongAlgorithm_i
// Заголовок реализации класса серванта для интерфеса IAlgorithm
//
// Реализация расчета релевантности для послностью строгого запроса
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_RELEVANCY_I_STRONGALGORITHM_I_H__
#define __SHARED_CONTEXTSEARCH_RELEVANCY_I_STRONGALGORITHM_I_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/Relevancy/Relevancy.h"
#include "shared/ContextSearch/Defs/Defs.h"

namespace ContextSearch {
namespace Relevancy_i {

class StrongAlgorithm_i; // self forward Var
typedef ::Core::Var<StrongAlgorithm_i> StrongAlgorithm_i_var;
typedef ::Core::Var<const StrongAlgorithm_i> StrongAlgorithm_i_cvar;

class StrongAlgorithm_i_factory;

// Реализация расчета релевантности для послностью строгого запроса
class StrongAlgorithm_i:
	virtual public Relevancy::IAlgorithm
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (StrongAlgorithm_i)
	friend class StrongAlgorithm_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	StrongAlgorithm_i (const Relevancy::Data& req_data, const Relevancy::AlgorithmProperties& properties);

	virtual ~StrongAlgorithm_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// релевантность для фрагмента
	Defs::RelevancyType get_relevancy (const Defs::PositionsRel& data, const Defs::InvisibleData& inv_data);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	Defs::RelevancyType m_base_rel;

	Defs::IRelevancyInfo* m_collector;

	size_t m_count;

	Defs::Fragments* m_fragments;

	Relevancy::IndexChain m_index;

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
}; // class StrongAlgorithm_i

} // namespace Relevancy_i
} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_RELEVANCY_I_STRONGALGORITHM_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
