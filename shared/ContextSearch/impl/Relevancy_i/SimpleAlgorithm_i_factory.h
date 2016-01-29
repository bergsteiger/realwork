////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/impl/Relevancy_i/SimpleAlgorithm_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::ContextSearch::Relevancy_i::SimpleAlgorithm_i
// Заголовк реализации фабрик интерфеса IAlgorithm для серванта SimpleAlgorithm_i
//
// Реализация расчета релевантности для простого запроса (без рамочных/строгих связей)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_RELEVANCY_I_SIMPLEALGORITHM_I_FCTR_H__
#define __SHARED_CONTEXTSEARCH_RELEVANCY_I_SIMPLEALGORITHM_I_FCTR_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/Relevancy/RelevancyFactories.h"

namespace ContextSearch {
namespace Relevancy_i {

/// Interface-factory implementation for SimpleAlgorithm_i
class SimpleAlgorithm_i_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public Relevancy::IAlgorithmAbstractFactory
{
public:
	SimpleAlgorithm_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const Relevancy::AlgorithmSelector key () const;

	Relevancy::IAlgorithm* make (const Relevancy::Data& req_data, const Relevancy::AlgorithmProperties& properties);

};

typedef ::Core::Var<SimpleAlgorithm_i_factory> SimpleAlgorithm_i_factory_var;

} // namespace Relevancy_i
} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_RELEVANCY_I_SIMPLEALGORITHM_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

