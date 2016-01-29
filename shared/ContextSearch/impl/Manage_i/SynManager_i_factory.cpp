////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/impl/Manage_i/SynManager_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::ContextSearch::Manage_i::SynManager_i
//
// Реализация интерфейса ISynManager
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/impl/Manage_i/SynManager_i_factory.h"
#include "shared/ContextSearch/impl/Manage_i/SynManager_i.h"

namespace ContextSearch {
namespace Manage_i {

SynManager_i_factory::SynManager_i_factory () {
}

void SynManager_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	Manage::ISynManagerFactoryManager::register_factory (this, priority);
}

const char* SynManager_i_factory::key () const {
	return "SynManager_i";
}

Manage::ISynManager* SynManager_i_factory::make (Morpho::Def::INormalizer* normalizer, DBComm::IDBCommunicator* comm) {
	SynManager_i_var ret = new SynManager_i (normalizer, comm);
	return ret._retn ();
}

} // namespace Manage_i
} // namespace ContextSearch

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

