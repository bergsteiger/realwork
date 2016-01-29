////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/impl/Relevancy_i/StrongAlgorithm_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::ContextSearch::Relevancy_i::StrongAlgorithm_i
//
// Реализация расчета релевантности для послностью строгого запроса
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/impl/Relevancy_i/StrongAlgorithm_i_factory.h"
#include "shared/ContextSearch/impl/Relevancy_i/StrongAlgorithm_i.h"

namespace ContextSearch {
namespace Relevancy_i {

StrongAlgorithm_i_factory::StrongAlgorithm_i_factory () {
}

void StrongAlgorithm_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	Relevancy::IAlgorithmFactoryManager::register_factory (this, priority);
}

const Relevancy::AlgorithmSelector StrongAlgorithm_i_factory::key () const {
	return Relevancy::as_Strong;
}

Relevancy::IAlgorithm* StrongAlgorithm_i_factory::make (
	const Relevancy::Data& req_data
	, const Relevancy::AlgorithmProperties& properties
) {
	StrongAlgorithm_i_var ret = new StrongAlgorithm_i (req_data, properties);
	return ret._retn ();
}

} // namespace Relevancy_i
} // namespace ContextSearch

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

