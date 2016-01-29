////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/MorphoAdapterLib/Def/DefFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garantCore::MorphoAdapterLib::Def
//
// Интерфейсы и типы морфо-адаптера
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "garantCore/MorphoAdapterLib/Def/DefFactories.h"

namespace MorphoAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for MorphoAdapter
bool MorphoAdapterFactoryManager::s_was_destroyed = false;

MorphoAdapterFactoryManager::MorphoAdapterFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

MorphoAdapterFactoryManager::~MorphoAdapterFactoryManager () {
	s_was_destroyed = true;
}

void MorphoAdapterFactoryManager::register_factory (
	MorphoAdapterAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void MorphoAdapterFactoryManager::register_factory_i (
	MorphoAdapterAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"MorphoAdapterLib::Def::MorphoAdapterFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = MorphoAdapterAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = MorphoAdapterAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

MorphoAdapter* MorphoAdapterFactoryManager::make () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("MorphoAdapterLib::Def::MorphoAdapterFactory");
	}
	MorphoAdapter* ret_ = m_single_active_factory->make ();
	GDS_ASSERT_MSG (ret_ != 0, ("MorphoAdapterLib::Def::MorphoAdapterFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for MlmaRu
bool MlmaRuFactoryManager::s_was_destroyed = false;

MlmaRuFactoryManager::MlmaRuFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

MlmaRuFactoryManager::~MlmaRuFactoryManager () {
	s_was_destroyed = true;
}

void MlmaRuFactoryManager::register_factory (
	MlmaRuAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void MlmaRuFactoryManager::register_factory_i (
	MlmaRuAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"MorphoAdapterLib::Def::MlmaRuFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = MlmaRuAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = MlmaRuAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

MlmaRu* MlmaRuFactoryManager::make () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("MorphoAdapterLib::Def::MlmaRuFactory");
	}
	MlmaRu* ret_ = m_single_active_factory->make ();
	GDS_ASSERT_MSG (ret_ != 0, ("MorphoAdapterLib::Def::MlmaRuFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for MorphoManager
bool MorphoManagerFactoryManager::s_was_destroyed = false;

MorphoManagerFactoryManager::MorphoManagerFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

MorphoManagerFactoryManager::~MorphoManagerFactoryManager () {
	s_was_destroyed = true;
}

void MorphoManagerFactoryManager::register_factory (
	MorphoManagerAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void MorphoManagerFactoryManager::register_factory_i (
	MorphoManagerAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"MorphoAdapterLib::Def::MorphoManagerFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = MorphoManagerAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = MorphoManagerAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

MorphoManager* MorphoManagerFactoryManager::make () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("MorphoAdapterLib::Def::MorphoManagerFactory");
	}
	MorphoManager* ret_ = m_single_active_factory->make ();
	GDS_ASSERT_MSG (ret_ != 0, ("MorphoAdapterLib::Def::MorphoManagerFactory impl can't return zerro"));
	return ret_;
}
} // namespace MorphoAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

