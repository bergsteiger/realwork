////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/MainMenu/MainMenuFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::MainMenu
//
// Основное меню
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "boost/lexical_cast.hpp"
#include "boost/bind.hpp"
#include "garant6x/implementation/Garant/GblAdapterLib/MainMenu/MainMenuFactories.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for SectionItem
bool SectionItemFactoryManager::s_was_destroyed = false;

SectionItemFactoryManager::SectionItemFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

SectionItemFactoryManager::~SectionItemFactoryManager () {
	s_was_destroyed = true;
}

void SectionItemFactoryManager::register_factory (
	SectionItemAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void SectionItemFactoryManager::register_factory_i (
	SectionItemAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::MainMenu::SectionItemFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = SectionItemAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = SectionItemAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

SectionItem* SectionItemFactoryManager::make (const GblPilot::SectionItem& section_item) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::MainMenu::SectionItemFactory");
	}
	SectionItem* ret_ = m_single_active_factory->make (section_item);
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::MainMenu::SectionItemFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for Section
bool SectionFactoryManager::s_was_destroyed = false;

SectionFactoryManager::SectionFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

SectionFactoryManager::~SectionFactoryManager () {
	s_was_destroyed = true;
}

void SectionFactoryManager::register_factory (
	SectionAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

SectionFactory::KeySet* SectionFactoryManager::keys () {
	Core::Aptr<SectionFactory::KeySet> keys (new SectionFactory::KeySet (Singleton::instance()->m_factories_map.size ()));
	
	std::transform (
		Singleton::instance()->m_factories_map.begin ()
		, Singleton::instance()->m_factories_map.end ()
		, std::back_inserter(*keys)
		, boost::bind (&FactoryMap::value_type::first, _1)
	);
	
	return keys.forget ();
}

void SectionFactoryManager::register_factory_i (
	SectionAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::MainMenu::SectionFactory"
			, boost::lexical_cast<std::string> (factory->key()).c_str ()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = SectionAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = SectionAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

const Section& SectionFactoryManager::make (SectionType key) /*throw (Core::Root::UnknownFactoryKey)*/ {
	GUARD(m_mutex_for_make);
	CachedObjectsForMake::iterator f = m_cached_objects_for_make.find (ObjectCreationIdForMake(key));
	if (f == m_cached_objects_for_make.end()) {
		FactoryMap::iterator f_fct = m_factories_map.find (key);
		if (f_fct == m_factories_map.end()) {
			throw Core::Root::UnknownFactoryKey (
				"GblAdapterLib::MainMenu::SectionFactory"
				, boost::lexical_cast<std::string> (key).c_str ()
			);
		}
		f = m_cached_objects_for_make.insert (
			CachedObjectsForMake::value_type(
				ObjectCreationIdForMake(key)
				, f_fct->second.factory->make ()
			)
		).first;
		m_cached_objects_index_for_make.insert (
			CachedObjectsIndexForMake::value_type (
				f->second.in()
				, f
			)
		);
	
	}
	GDS_ASSERT_MSG (f->second.in () != 0, ("GblAdapterLib::MainMenu::SectionFactory impl can't return zerro"));
	return *f->second;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for MainMenu
bool MainMenuFactoryManager::s_was_destroyed = false;

MainMenuFactoryManager::MainMenuFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

MainMenuFactoryManager::~MainMenuFactoryManager () {
	s_was_destroyed = true;
}

void MainMenuFactoryManager::register_factory (
	MainMenuAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void MainMenuFactoryManager::register_factory_i (
	MainMenuAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::MainMenu::MainMenuFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = MainMenuAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = MainMenuAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

MainMenu& MainMenuFactoryManager::make () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_cached_object_for_make.ptr() == 0) {
		GUARD(m_mutex_for_make);
		if (m_cached_object_for_make.ptr() == 0) {
			if (m_single_active_factory.is_nil()) {
				throw Core::Root::NoActiveFactory ("GblAdapterLib::MainMenu::MainMenuFactory");
			}
			m_cached_object_for_make = m_single_active_factory->make ();
		
			GDS_ASSERT_MSG (m_cached_object_for_make.ptr() != 0, ("GblAdapterLib::MainMenu::MainMenuFactory impl can't return zerro"));
		}
	}
	return *m_cached_object_for_make;
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

