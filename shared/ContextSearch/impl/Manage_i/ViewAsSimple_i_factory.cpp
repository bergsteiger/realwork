////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/impl/Manage_i/ViewAsSimple_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::ContextSearch::Manage_i::ViewAsSimple_i
//
// Простое представление (без синонимов)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/impl/Manage_i/ViewAsSimple_i_factory.h"
#include "shared/ContextSearch/impl/Manage_i/ViewAsSimple_i.h"

namespace ContextSearch {
namespace Manage_i {

ViewAsSimple_i_factory::ViewAsSimple_i_factory () {
}

void ViewAsSimple_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	Search::IRequestViewFactoryManager::register_factory (this, priority);
}

const Search::AlgorithmSelector ViewAsSimple_i_factory::key () const {
	return Search::as_Simple;
}

Search::IRequestView* ViewAsSimple_i_factory::make (
	DBComm::IDBCommunicator* comm
	, Morpho::Def::INormalizer* normalizer
) {
	ViewAsSimple_i_var ret = new ViewAsSimple_i (comm, normalizer);
	return ret._retn ();
}

} // namespace Manage_i
} // namespace ContextSearch

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

