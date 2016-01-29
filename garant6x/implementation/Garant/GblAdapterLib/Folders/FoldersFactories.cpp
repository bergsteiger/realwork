////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Folders/FoldersFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Folders
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Folders/FoldersFactories.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for FoldersNode
bool FoldersNodeFactoryManager::s_was_destroyed = false;

FoldersNodeFactoryManager::FoldersNodeFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

FoldersNodeFactoryManager::~FoldersNodeFactoryManager () {
	s_was_destroyed = true;
}

void FoldersNodeFactoryManager::register_factory (
	FoldersNodeAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void FoldersNodeFactoryManager::register_factory_i (
	FoldersNodeAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::Folders::FoldersNodeFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = FoldersNodeAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = FoldersNodeAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

FoldersNode* FoldersNodeFactoryManager::make (Containers::Content* content, Folders* folders) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Folders::FoldersNodeFactory");
	}
	FoldersNode* ret_ = m_single_active_factory->make (content, folders);
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::Folders::FoldersNodeFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for Folders
bool FoldersFactoryManager::s_was_destroyed = false;

FoldersFactoryManager::FoldersFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

FoldersFactoryManager::~FoldersFactoryManager () {
	s_was_destroyed = true;
}

void FoldersFactoryManager::register_factory (
	FoldersAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void FoldersFactoryManager::register_factory_i (
	FoldersAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::Folders::FoldersFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = FoldersAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = FoldersAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

Folders& FoldersFactoryManager::make () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_cached_object_for_make.ptr() == 0) {
		GUARD(m_mutex_for_make);
		if (m_cached_object_for_make.ptr() == 0) {
			if (m_single_active_factory.is_nil()) {
				throw Core::Root::NoActiveFactory ("GblAdapterLib::Folders::FoldersFactory");
			}
			m_cached_object_for_make = m_single_active_factory->make ();
		
			GDS_ASSERT_MSG (m_cached_object_for_make.ptr() != 0, ("GblAdapterLib::Folders::FoldersFactory impl can't return zerro"));
		}
	}
	return *m_cached_object_for_make;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for Folder
bool FolderFactoryManager::s_was_destroyed = false;

FolderFactoryManager::FolderFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

FolderFactoryManager::~FolderFactoryManager () {
	s_was_destroyed = true;
}

void FolderFactoryManager::register_factory (
	FolderAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void FolderFactoryManager::register_factory_i (
	FolderAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::Folders::FolderFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = FolderAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = FolderAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

Folder* FolderFactoryManager::make (GblFolders::Folder* folder_content, FoldersNode* folders_node) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Folders::FolderFactory");
	}
	Folder* ret_ = m_single_active_factory->make (folder_content, folders_node);
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::Folders::FolderFactory impl can't return zerro"));
	return ret_;
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

