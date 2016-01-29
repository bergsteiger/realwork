////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/Query_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Search_i::Query_i
// Заголовк реализации фабрик интерфеса FoldersQuery для серванта Query_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SEARCH_I_QUERY_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_SEARCH_I_QUERY_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/Search_iFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/Search_i.h"
// by <<uses>> back dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/Query_i.h"

/// Servant-factory implementation for Query_i
namespace GblAdapterLib {
	class LogEventData_i; //forward friend
} // namespace GblAdapterLib


namespace GblAdapterLib {

class Query_iServantFactory {
	friend class LogEventData_i;

	static Query_i* make_query (GblUserJournal::JournalQuery* journal_query);

	static Query_i* make_query (GblFolders::SavedQuery* saved_query, bool load_on_demand, FoldersNode* folders_node);

	static Query_i* make_query (const GblPilotQueryDef::Query& query);

	static Query_i* make (QueryType type);
};

/// Interface-factory implementation for Query_i
class Query_i_factory: virtual public ::Core::RefCountObjectBase, virtual public FoldersQueryFactoriesAbstractFactory {
	friend class Query_iServantFactory;

public:
	Query_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	static Query_i_factory* s_instance;

	const char* key () const;

	FoldersQueryFactories* make_query (GblUserJournal::JournalQuery* journal_query);

	FoldersQueryFactories* make_query (
		GblFolders::SavedQuery* saved_query
		, bool load_on_demand
		, FoldersNode* folders_node
	);

	FoldersQueryFactories* make_query (const GblPilotQueryDef::Query& query);

	Query* make (QueryType type);

};

typedef ::Core::Var<Query_i_factory> Query_i_factory_var;

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::Query_i> {
	typedef GblAdapterLib::Query_iServantFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_SEARCH_I_QUERY_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

