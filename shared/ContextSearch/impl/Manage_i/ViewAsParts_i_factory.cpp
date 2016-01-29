////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/impl/Manage_i/ViewAsParts_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::ContextSearch::Manage_i::ViewAsParts_i
//
// Представление запроса в виде фразальных частей
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/impl/Manage_i/ViewAsParts_i_factory.h"
#include "shared/ContextSearch/impl/Manage_i/ViewAsParts_i.h"

namespace ContextSearch {
namespace Manage_i {

ViewAsParts_i_factory::ViewAsParts_i_factory () {
}

void ViewAsParts_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	Search::IRequestViewFactoryManager::register_factory (this, priority);
}

const Search::AlgorithmSelector ViewAsParts_i_factory::key () const {
	return Search::as_Partial;
}

Search::IRequestView* ViewAsParts_i_factory::make (
	DBComm::IDBCommunicator* comm
	, Morpho::Def::INormalizer* normalizer
) {
	ViewAsParts_i_var ret = new ViewAsParts_i (comm, normalizer);
	return ret._retn ();
}

} // namespace Manage_i
} // namespace ContextSearch

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

