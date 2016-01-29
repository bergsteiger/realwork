////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/Search_iFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Impl::Category>> garant6x::GblAdapterLib::Search_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/Search_iFactories.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for FoldersQueryFactories
bool FoldersQueryFactoriesFactoryManager::s_was_destroyed = false;

FoldersQueryFactoriesFactoryManager::FoldersQueryFactoriesFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

FoldersQueryFactoriesFactoryManager::~FoldersQueryFactoriesFactoryManager () {
	s_was_destroyed = true;
}

void FoldersQueryFactoriesFactoryManager::register_factory (
	FoldersQueryFactoriesAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
	QueryFactoryManager::register_factory (factory, priority);
	
}

void FoldersQueryFactoriesFactoryManager::register_factory_i (
	FoldersQueryFactoriesAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::Search_i::FoldersQueryFactoriesFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = FoldersQueryFactoriesAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = FoldersQueryFactoriesAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

FoldersQueryFactories* FoldersQueryFactoriesFactoryManager::make_query (GblUserJournal::JournalQuery* journal_query) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Search_i::FoldersQueryFactoriesFactory");
	}
	FoldersQueryFactories* ret_ = m_single_active_factory->make_query (journal_query);
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::Search_i::FoldersQueryFactoriesFactory impl can't return zerro"));
	return ret_;
}

FoldersQueryFactories* FoldersQueryFactoriesFactoryManager::make_query (GblFolders::SavedQuery* saved_query, bool load_on_demand, FoldersNode* folders_node) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Search_i::FoldersQueryFactoriesFactory");
	}
	FoldersQueryFactories* ret_ = m_single_active_factory->make_query (saved_query, load_on_demand, folders_node);
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::Search_i::FoldersQueryFactoriesFactory impl can't return zerro"));
	return ret_;
}

FoldersQueryFactories* FoldersQueryFactoriesFactoryManager::make_query (const GblPilotQueryDef::Query& query) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Search_i::FoldersQueryFactoriesFactory");
	}
	FoldersQueryFactories* ret_ = m_single_active_factory->make_query (query);
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::Search_i::FoldersQueryFactoriesFactory impl can't return zerro"));
	return ret_;
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

