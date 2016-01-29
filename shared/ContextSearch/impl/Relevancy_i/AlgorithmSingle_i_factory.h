////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/impl/Relevancy_i/AlgorithmSingle_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::ContextSearch::Relevancy_i::AlgorithmSingle_i
// Заголовк реализации фабрик интерфеса IAlgorithm для серванта AlgorithmSingle_i
//
// Реализация агоритма расчета релевантности для запроса состоящего из одного слова
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_RELEVANCY_I_ALGORITHMSINGLE_I_FCTR_H__
#define __SHARED_CONTEXTSEARCH_RELEVANCY_I_ALGORITHMSINGLE_I_FCTR_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/Relevancy/RelevancyFactories.h"

namespace ContextSearch {
namespace Relevancy_i {

/// Interface-factory implementation for AlgorithmSingle_i
class AlgorithmSingle_i_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public Relevancy::IAlgorithmAbstractFactory
{
public:
	AlgorithmSingle_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const Relevancy::AlgorithmSelector key () const;

	Relevancy::IAlgorithm* make (const Relevancy::Data& req_data, const Relevancy::AlgorithmProperties& properties);

};

typedef ::Core::Var<AlgorithmSingle_i_factory> AlgorithmSingle_i_factory_var;

} // namespace Relevancy_i
} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_RELEVANCY_I_ALGORITHMSINGLE_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

