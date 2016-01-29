////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/impl/Manage_i/Query_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::ContextSearch::Manage_i::Query_i
//
// Реализация интерфейса менеджера поисковых запросов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/impl/Manage_i/Query_i_factory.h"
#include "shared/ContextSearch/impl/Manage_i/Query_i.h"

namespace ContextSearch {
namespace Manage_i {

Query_i_factory::Query_i_factory () {
}

void Query_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	Manage::IQueryFactoryManager::register_factory (this, priority);
}

const char* Query_i_factory::key () const {
	return "Query_i";
}

Manage::IQuery* Query_i_factory::make (const Manage::Env& in, DBComm::IDBCommunicator* comm) {
	Query_i_var ret = new Query_i (in, comm);
	return ret._retn ();
}

} // namespace Manage_i
} // namespace ContextSearch

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

