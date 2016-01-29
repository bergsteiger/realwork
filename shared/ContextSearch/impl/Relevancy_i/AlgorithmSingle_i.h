////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/impl/Relevancy_i/AlgorithmSingle_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::ContextSearch::Relevancy_i::AlgorithmSingle_i
// Заголовок реализации класса серванта для интерфеса IAlgorithm
//
// Реализация агоритма расчета релевантности для запроса состоящего из одного слова
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_RELEVANCY_I_ALGORITHMSINGLE_I_H__
#define __SHARED_CONTEXTSEARCH_RELEVANCY_I_ALGORITHMSINGLE_I_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/Relevancy/Relevancy.h"
#include "shared/ContextSearch/Defs/Defs.h"

namespace ContextSearch {
namespace Relevancy_i {

class AlgorithmSingle_i; // self forward Var
typedef ::Core::Var<AlgorithmSingle_i> AlgorithmSingle_i_var;
typedef ::Core::Var<const AlgorithmSingle_i> AlgorithmSingle_i_cvar;

class AlgorithmSingle_i_factory;

// Реализация агоритма расчета релевантности для запроса состоящего из одного слова
class AlgorithmSingle_i:
	virtual public Relevancy::IAlgorithm
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (AlgorithmSingle_i)
	friend class AlgorithmSingle_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	AlgorithmSingle_i (const Relevancy::Data& req_data, const Relevancy::AlgorithmProperties& properties);

	virtual ~AlgorithmSingle_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	Defs::RelevancyType m_base_rel;

	Defs::IRelevancyInfo* m_info;

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
}; // class AlgorithmSingle_i

} // namespace Relevancy_i
} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_RELEVANCY_I_ALGORITHMSINGLE_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
