////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/Search_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Impl::Category>> garant6x::GblAdapterLib::Search_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/Search_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/Search_iFactories.h"


namespace GblAdapterLib {

// factory interface wrapper for FoldersQueryFactories
FoldersQueryFactories* FoldersQueryFactoriesFactory::make_query (
	GblUserJournal::JournalQuery* journal_query
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return FoldersQueryFactoriesFactoryManager::Singleton::instance ()->make_query (journal_query);
}

FoldersQueryFactories* FoldersQueryFactoriesFactory::make_query (
	GblFolders::SavedQuery* saved_query
	, bool load_on_demand
	, FoldersNode* folders_node
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return FoldersQueryFactoriesFactoryManager::Singleton::instance ()->make_query (saved_query, load_on_demand, folders_node);
}

FoldersQueryFactories* FoldersQueryFactoriesFactory::make_query (
	const GblPilotQueryDef::Query& query
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return FoldersQueryFactoriesFactoryManager::Singleton::instance ()->make_query (query);
}

FoldersQueryFactories* FoldersQueryFactoriesFactory::make (
	QueryType type
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	FoldersQueryFactories* ret = dynamic_cast<FoldersQueryFactories*> (QueryFactory::make (type));
	if (ret == 0) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Search_i::FoldersQueryFactoriesFactory");
	}
	return ret;
}



} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

