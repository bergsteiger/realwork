////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/impl/Relevancy_i/AlgorithmIdentical_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::ContextSearch::Relevancy_i::AlgorithmIdentical_i
//
// Реализация агоритма расчета релевантности для запроса состоящего из одинаковых слов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/impl/Relevancy_i/AlgorithmIdentical_i_factory.h"
#include "shared/ContextSearch/impl/Relevancy_i/AlgorithmIdentical_i.h"

namespace ContextSearch {
namespace Relevancy_i {

AlgorithmIdentical_i_factory::AlgorithmIdentical_i_factory () {
}

void AlgorithmIdentical_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	Relevancy::IAlgorithmFactoryManager::register_factory (this, priority);
}

const Relevancy::AlgorithmSelector AlgorithmIdentical_i_factory::key () const {
	return Relevancy::as_Identical;
}

Relevancy::IAlgorithm* AlgorithmIdentical_i_factory::make (
	const Relevancy::Data& req_data
	, const Relevancy::AlgorithmProperties& properties
) {
	AlgorithmIdentical_i_var ret = new AlgorithmIdentical_i (req_data, properties);
	return ret._retn ();
}

} // namespace Relevancy_i
} // namespace ContextSearch

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

