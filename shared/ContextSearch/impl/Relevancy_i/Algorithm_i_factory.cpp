////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/impl/Relevancy_i/Algorithm_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::ContextSearch::Relevancy_i::Algorithm_i
//
// Сервант реализующий алгоритм расчета релевантности
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/impl/Relevancy_i/Algorithm_i_factory.h"
#include "shared/ContextSearch/impl/Relevancy_i/Algorithm_i.h"

namespace ContextSearch {
namespace Relevancy_i {

Algorithm_i_factory::Algorithm_i_factory () {
}

void Algorithm_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	Relevancy::IAlgorithmFactoryManager::register_factory (this, priority);
}

const Relevancy::AlgorithmSelector Algorithm_i_factory::key () const {
	return Relevancy::as_Default;
}

Relevancy::IAlgorithm* Algorithm_i_factory::make (
	const Relevancy::Data& req_data
	, const Relevancy::AlgorithmProperties& properties
) {
	Algorithm_i_var ret = new Algorithm_i (req_data, properties);
	return ret._retn ();
}

} // namespace Relevancy_i
} // namespace ContextSearch

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

