////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/Search_iFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Impl::Category>> garant6x::GblAdapterLib::Search_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SEARCH_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_SEARCH_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/Search_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Search/SearchFactories.h"

namespace GblAdapterLib {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for FoldersQueryFactories

class FoldersQueryFactoriesAbstractFactory;

/// factory manager for FoldersQueryFactories
class FoldersQueryFactoriesFactoryManager {
public:
	static void register_factory (FoldersQueryFactoriesAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	FoldersQueryFactoriesFactoryManager ();
	
	~FoldersQueryFactoriesFactoryManager ();
	
	void register_factory_i (FoldersQueryFactoriesAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	FoldersQueryFactories* make_query (
		GblUserJournal::JournalQuery* journal_query
	) /*throw (Core::Root::NoActiveFactory)*/;

	FoldersQueryFactories* make_query (
		GblFolders::SavedQuery* saved_query
		, bool load_on_demand
		, FoldersNode* folders_node
	) /*throw (Core::Root::NoActiveFactory)*/;

	FoldersQueryFactories* make_query (const GblPilotQueryDef::Query& query) /*throw (Core::Root::NoActiveFactory)*/;

	friend class FoldersQueryFactoriesFactory;
	typedef ACE_Singleton <FoldersQueryFactoriesFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <FoldersQueryFactoriesFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<FoldersQueryFactoriesAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<FoldersQueryFactoriesAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for FoldersQueryFactories
class FoldersQueryFactoriesAbstractFactory : virtual public Core::IObject, virtual public QueryAbstractFactory {
	friend class FoldersQueryFactoriesFactoryManager;
protected:

	virtual FoldersQueryFactories* make_query (GblUserJournal::JournalQuery* journal_query) = 0;

	virtual FoldersQueryFactories* make_query (
		GblFolders::SavedQuery* saved_query
		, bool load_on_demand
		, FoldersNode* folders_node
	) = 0;

	virtual FoldersQueryFactories* make_query (const GblPilotQueryDef::Query& query) = 0;
};

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_SEARCH_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

