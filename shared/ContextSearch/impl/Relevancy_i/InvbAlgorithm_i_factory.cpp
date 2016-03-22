////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/impl/Relevancy_i/InvbAlgorithm_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::ContextSearch::Relevancy_i::InvbAlgorithm_i
//
// Имплементация для невидимых блочных
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/impl/Relevancy_i/InvbAlgorithm_i_factory.h"
#include "shared/ContextSearch/impl/Relevancy_i/InvbAlgorithm_i.h"

namespace ContextSearch {
namespace Relevancy_i {

InvbAlgorithm_i_factory::InvbAlgorithm_i_factory () {
}

void InvbAlgorithm_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	Relevancy::IBlocksAlgorithmFactoryManager::register_factory (this, priority);
}

const char* InvbAlgorithm_i_factory::key () const {
	return "InvbAlgorithm_i";
}

Relevancy::IBlocksAlgorithm* InvbAlgorithm_i_factory::make (
	const Relevancy::Data& req_data
	, const Relevancy::AlgorithmProperties& properties
) {
	InvbAlgorithm_i_var ret = new InvbAlgorithm_i (req_data, properties);
	return ret._retn ();
}

} // namespace Relevancy_i
} // namespace ContextSearch

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

