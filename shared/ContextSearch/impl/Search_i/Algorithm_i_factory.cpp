////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/impl/Search_i/Algorithm_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::ContextSearch::Search_i::Algorithm_i
//
// Реализация интерфейса поискового алгоритма
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/impl/Search_i/Algorithm_i_factory.h"
#include "shared/ContextSearch/impl/Search_i/Algorithm_i.h"

namespace ContextSearch {
namespace Search_i {

Algorithm_i_factory::Algorithm_i_factory () {
}

void Algorithm_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	Search::IAlgorithmFactoryManager::register_factory (this, priority);
}

const Search::AlgorithmSelector Algorithm_i_factory::key () const {
	return Search::as_Default;
}

Search::IAlgorithm* Algorithm_i_factory::make (
	Search::IRequestView* view
	, DBComm::IProgress* progress
	, const Search::AlgorithmProperties& properties
) {
	Algorithm_i_var ret = new Algorithm_i (view, progress, properties);
	return ret._retn ();
}

} // namespace Search_i
} // namespace ContextSearch

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

