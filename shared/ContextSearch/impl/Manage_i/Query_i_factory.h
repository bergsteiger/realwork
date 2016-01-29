////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/impl/Manage_i/Query_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::ContextSearch::Manage_i::Query_i
// Заголовк реализации фабрик интерфеса IQuery для серванта Query_i
//
// Реализация интерфейса менеджера поисковых запросов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_MANAGE_I_QUERY_I_FCTR_H__
#define __SHARED_CONTEXTSEARCH_MANAGE_I_QUERY_I_FCTR_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/Manage/ManageFactories.h"

namespace ContextSearch {
namespace Manage_i {

/// Interface-factory implementation for Query_i
class Query_i_factory: virtual public ::Core::RefCountObjectBase, virtual public Manage::IQueryAbstractFactory {
public:
	Query_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	Manage::IQuery* make (const Manage::Env& in, DBComm::IDBCommunicator* comm);

};

typedef ::Core::Var<Query_i_factory> Query_i_factory_var;

} // namespace Manage_i
} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_MANAGE_I_QUERY_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

