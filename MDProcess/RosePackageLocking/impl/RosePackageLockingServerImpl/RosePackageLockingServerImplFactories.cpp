////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/RosePackageLocking/impl/RosePackageLockingServerImpl/RosePackageLockingServerImplFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Impl::Category>> MDProcess::RosePackageLocking::RosePackageLockingServerImpl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/RosePackageLocking/impl/RosePackageLockingServerImpl/RosePackageLockingServerImplFactories.h"

namespace RosePackageLocking {
namespace RosePackageLockingServerImpl {

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for PackageManagerEx
bool PackageManagerExFactoryManager::s_was_destroyed = false;

PackageManagerExFactoryManager::PackageManagerExFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

PackageManagerExFactoryManager::~PackageManagerExFactoryManager () {
	s_was_destroyed = true;
}

void PackageManagerExFactoryManager::register_factory (
	PackageManagerExAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
	RosePackageLockingServer::PackageManagerFactoryManager::register_factory (factory, priority);
	
}

void PackageManagerExFactoryManager::register_factory_i (
	PackageManagerExAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"RosePackageLocking::RosePackageLockingServerImpl::PackageManagerExFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = PackageManagerExAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = PackageManagerExAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}
} // namespace RosePackageLockingServerImpl
} // namespace RosePackageLocking

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

