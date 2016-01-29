////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/ChatImplementationFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Impl::Category>> garant6x::NemesisChatImplementation::ChatImplementation
//
// реализация чата
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/ChatImplementationFactories.h"

namespace NemesisChatImplementation {
namespace ChatImplementation {

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for LocalChatManager
bool LocalChatManagerFactoryManager::s_was_destroyed = false;

LocalChatManagerFactoryManager::LocalChatManagerFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

LocalChatManagerFactoryManager::~LocalChatManagerFactoryManager () {
	s_was_destroyed = true;
}

void LocalChatManagerFactoryManager::register_factory (
	LocalChatManagerAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
	ChatLibrary::ChatService::ChatManagerFactoryManager::register_factory (factory, priority);
	
}

void LocalChatManagerFactoryManager::register_factory_i (
	LocalChatManagerAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"NemesisChatImplementation::ChatImplementation::LocalChatManagerFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = LocalChatManagerAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = LocalChatManagerAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}
} // namespace ChatImplementation
} // namespace NemesisChatImplementation

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

