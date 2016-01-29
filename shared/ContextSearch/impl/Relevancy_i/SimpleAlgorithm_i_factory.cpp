////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/impl/Relevancy_i/SimpleAlgorithm_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::ContextSearch::Relevancy_i::SimpleAlgorithm_i
//
// Реализация расчета релевантности для простого запроса (без рамочных/строгих связей)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/impl/Relevancy_i/SimpleAlgorithm_i_factory.h"
#include "shared/ContextSearch/impl/Relevancy_i/SimpleAlgorithm_i.h"

namespace ContextSearch {
namespace Relevancy_i {

SimpleAlgorithm_i_factory::SimpleAlgorithm_i_factory () {
}

void SimpleAlgorithm_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	Relevancy::IAlgorithmFactoryManager::register_factory (this, priority);
}

const Relevancy::AlgorithmSelector SimpleAlgorithm_i_factory::key () const {
	return Relevancy::as_Simple;
}

Relevancy::IAlgorithm* SimpleAlgorithm_i_factory::make (
	const Relevancy::Data& req_data
	, const Relevancy::AlgorithmProperties& properties
) {
	SimpleAlgorithm_i_var ret = new SimpleAlgorithm_i (req_data, properties);
	return ret._retn ();
}

} // namespace Relevancy_i
} // namespace ContextSearch

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

