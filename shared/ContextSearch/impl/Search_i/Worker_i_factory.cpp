////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/impl/Search_i/Worker_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::ContextSearch::Search_i::Worker_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/impl/Search_i/Worker_i_factory.h"
#include "shared/ContextSearch/impl/Search_i/Worker_i.h"

namespace ContextSearch {
namespace Search_i {

Worker_i_factory::Worker_i_factory () {
}

void Worker_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	Search::IWorkerFactoryManager::register_factory (this, priority);
}

const char* Worker_i_factory::key () const {
	return "Worker_i";
}

Search::IWorker* Worker_i_factory::make () {
	Worker_i_var ret = new Worker_i ();
	return ret._retn ();
}

} // namespace Search_i
} // namespace ContextSearch

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

