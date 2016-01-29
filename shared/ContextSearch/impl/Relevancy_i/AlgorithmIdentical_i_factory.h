////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/impl/Relevancy_i/AlgorithmIdentical_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::ContextSearch::Relevancy_i::AlgorithmIdentical_i
// Заголовк реализации фабрик интерфеса IAlgorithm для серванта AlgorithmIdentical_i
//
// Реализация агоритма расчета релевантности для запроса состоящего из одинаковых слов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_RELEVANCY_I_ALGORITHMIDENTICAL_I_FCTR_H__
#define __SHARED_CONTEXTSEARCH_RELEVANCY_I_ALGORITHMIDENTICAL_I_FCTR_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/Relevancy/RelevancyFactories.h"

namespace ContextSearch {
namespace Relevancy_i {

/// Interface-factory implementation for AlgorithmIdentical_i
class AlgorithmIdentical_i_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public Relevancy::IAlgorithmAbstractFactory
{
public:
	AlgorithmIdentical_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const Relevancy::AlgorithmSelector key () const;

	Relevancy::IAlgorithm* make (const Relevancy::Data& req_data, const Relevancy::AlgorithmProperties& properties);

};

typedef ::Core::Var<AlgorithmIdentical_i_factory> AlgorithmIdentical_i_factory_var;

} // namespace Relevancy_i
} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_RELEVANCY_I_ALGORITHMIDENTICAL_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

