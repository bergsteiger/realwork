////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/impl/MMapComImpl/MMapComImplFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Impl::Category>> shared::GCI::MMapComImpl
//
// платформонезависимая часть реализации MMAP
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/impl/MMapComImpl/MMapComImplFactories.h"

#if defined(WIN32)
namespace GCI {
namespace MMapComImpl {

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for PoolListHandler
bool PoolListHandlerFactoryManager::s_was_destroyed = false;

PoolListHandlerFactoryManager::PoolListHandlerFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

PoolListHandlerFactoryManager::~PoolListHandlerFactoryManager () {
	s_was_destroyed = true;
}

void PoolListHandlerFactoryManager::register_factory (
	PoolListHandlerAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
	MMap::MemoryPoolFactoryManager::register_factory (factory, priority);
	
}

void PoolListHandlerFactoryManager::register_factory_i (
	PoolListHandlerAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GCI::MMapComImpl::PoolListHandlerFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = PoolListHandlerAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = PoolListHandlerAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}
} // namespace MMapComImpl
} // namespace GCI

#endif //WIN32
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

