////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Internet/Inet/InetFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> shared::Internet::Inet
//
// Интерфейсы и типы для работы с интернет.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "shared/Internet/Inet/InetFactories.h"

namespace Internet {

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for IConnection
bool IConnectionFactoryManager::s_was_destroyed = false;

IConnectionFactoryManager::IConnectionFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

IConnectionFactoryManager::~IConnectionFactoryManager () {
	s_was_destroyed = true;
}

void IConnectionFactoryManager::register_factory (
	IConnectionAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void IConnectionFactoryManager::register_factory_i (
	IConnectionAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"Internet::Inet::IConnectionFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = IConnectionAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = IConnectionAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

IConnection* IConnectionFactoryManager::make (void* data, unsigned long flags) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("Internet::Inet::IConnectionFactory");
	}
	IConnection* ret_ = m_single_active_factory->make (data, flags);
	GDS_ASSERT_MSG (ret_ != 0, ("Internet::Inet::IConnectionFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for IConnect
bool IConnectFactoryManager::s_was_destroyed = false;

IConnectFactoryManager::IConnectFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

IConnectFactoryManager::~IConnectFactoryManager () {
	s_was_destroyed = true;
}

void IConnectFactoryManager::register_factory (
	IConnectAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void IConnectFactoryManager::register_factory_i (
	IConnectAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"Internet::Inet::IConnectFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = IConnectAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = IConnectAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

IConnect* IConnectFactoryManager::make (const InternetAccessInfo& info) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("Internet::Inet::IConnectFactory");
	}
	IConnect* ret_ = m_single_active_factory->make (info);
	GDS_ASSERT_MSG (ret_ != 0, ("Internet::Inet::IConnectFactory impl can't return zerro"));
	return ret_;
}
} // namespace Internet

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

