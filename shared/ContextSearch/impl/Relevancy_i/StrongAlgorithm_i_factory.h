////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/impl/Relevancy_i/StrongAlgorithm_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::ContextSearch::Relevancy_i::StrongAlgorithm_i
// Заголовк реализации фабрик интерфеса IAlgorithm для серванта StrongAlgorithm_i
//
// Реализация расчета релевантности для послностью строгого запроса
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_RELEVANCY_I_STRONGALGORITHM_I_FCTR_H__
#define __SHARED_CONTEXTSEARCH_RELEVANCY_I_STRONGALGORITHM_I_FCTR_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/Relevancy/RelevancyFactories.h"

namespace ContextSearch {
namespace Relevancy_i {

/// Interface-factory implementation for StrongAlgorithm_i
class StrongAlgorithm_i_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public Relevancy::IAlgorithmAbstractFactory
{
public:
	StrongAlgorithm_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const Relevancy::AlgorithmSelector key () const;

	Relevancy::IAlgorithm* make (const Relevancy::Data& req_data, const Relevancy::AlgorithmProperties& properties);

};

typedef ::Core::Var<StrongAlgorithm_i_factory> StrongAlgorithm_i_factory_var;

} // namespace Relevancy_i
} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_RELEVANCY_I_STRONGALGORITHM_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

