////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/Query_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Search_i::Query_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/Query_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/Query_i.h"

namespace GblAdapterLib {

Query_i_factory* Query_i_factory::s_instance = 0;

Query_i_factory::Query_i_factory () {
}

void Query_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	FoldersQueryFactoriesFactoryManager::register_factory (this, priority);
	s_instance = this;
}

const char* Query_i_factory::key () const {
	return "Query_i";
}

FoldersQueryFactories* Query_i_factory::make_query (GblUserJournal::JournalQuery* journal_query) {
	Query_i_var ret = new Query_i (journal_query);
	return ret._retn ();
}

FoldersQueryFactories* Query_i_factory::make_query (
	GblFolders::SavedQuery* saved_query
	, bool load_on_demand
	, FoldersNode* folders_node
) {
	Query_i_var ret = new Query_i (saved_query, load_on_demand, folders_node);
	return ret._retn ();
}

FoldersQueryFactories* Query_i_factory::make_query (const GblPilotQueryDef::Query& query) {
	Query_i_var ret = new Query_i (query);
	return ret._retn ();
}

Query* Query_i_factory::make (QueryType type) {
	Query_i_var ret = new Query_i (type);
	return ret._retn ();
}

Query_i* Query_iServantFactory::make_query (GblUserJournal::JournalQuery* journal_query) {
	if (Query_i_factory::s_instance) {
		return dynamic_cast<Query_i*>(Query_i_factory::s_instance->make_query (journal_query));
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Search_i::Query_i_factory");
	}
}

Query_i* Query_iServantFactory::make_query (GblFolders::SavedQuery* saved_query, bool load_on_demand, FoldersNode* folders_node) {
	if (Query_i_factory::s_instance) {
		return dynamic_cast<Query_i*>(Query_i_factory::s_instance->make_query (saved_query, load_on_demand, folders_node));
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Search_i::Query_i_factory");
	}
}

Query_i* Query_iServantFactory::make_query (const GblPilotQueryDef::Query& query) {
	if (Query_i_factory::s_instance) {
		return dynamic_cast<Query_i*>(Query_i_factory::s_instance->make_query (query));
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Search_i::Query_i_factory");
	}
}

Query_i* Query_iServantFactory::make (QueryType type) {
	if (Query_i_factory::s_instance) {
		return dynamic_cast<Query_i*>(Query_i_factory::s_instance->make (type));
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Search_i::Query_i_factory");
	}
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

