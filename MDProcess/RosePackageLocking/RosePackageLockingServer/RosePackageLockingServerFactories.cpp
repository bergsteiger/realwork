////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/RosePackageLocking/RosePackageLockingServer/RosePackageLockingServerFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<ServerInterfaces::Category>> MDProcess::RosePackageLocking::RosePackageLockingServer
//
// ответственности для работы с залочками пакетов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/RosePackageLocking/RosePackageLockingServer/RosePackageLockingServerFactories.h"
#include "MDProcess/RosePackageLocking/LibHome.h"

namespace RosePackageLocking {
namespace RosePackageLockingServer {

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for Package
bool PackageFactoryManager::s_was_destroyed = false;

PackageFactoryManager::PackageFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

PackageFactoryManager::~PackageFactoryManager () {
	s_was_destroyed = true;
}

void PackageFactoryManager::register_factory (
	PackageAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void PackageFactoryManager::publish_self () {
	if (Singleton::instance()->m_has_registred_factories) {
		PackageFactoryManagerSrv_var ref = Singleton::instance()->_this();
		CoreSrv::bind_path (&LibHomeFactory::get().get_orb_facet().get_ns_root(), ref.in(), "RosePackageLocking::RosePackageLockingServer::Package");
	}
}

void PackageFactoryManager::register_factory_i (
	PackageAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"RosePackageLocking::RosePackageLockingServer::PackageFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = PackageAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = PackageAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

Package* PackageFactoryManager::instance (PackageGUID_const guid) throw (CORBA::SystemException, CoreSrv::NoActiveFactory) {
	GUARD(m_mutex_for_instance);
	CachedObjectsForInstance::iterator f = m_cached_objects_for_instance.find (ObjectCreationIdForInstance(guid));
	if (f == m_cached_objects_for_instance.end()) {
		if (m_single_active_factory.is_nil()) {
			throw Core::Root::NoActiveFactory ("RosePackageLocking::RosePackageLockingServer::PackageFactory");
		}
		f = m_cached_objects_for_instance.insert (
			CachedObjectsForInstance::value_type(
				ObjectCreationIdForInstance(guid)
				, m_single_active_factory->instance (guid)
			)
		).first;
		m_cached_objects_index_for_instance.insert (
			CachedObjectsIndexForInstance::value_type (
				f->second->_hash (std::numeric_limits<CORBA::ULong>::max ())
				, f
			)
		);
	
	}
	GDS_ASSERT_MSG (f->second.in () != 0, ("RosePackageLocking::RosePackageLockingServer::PackageFactory impl can't return zerro"));
	return Package::_duplicate(f->second.in ());
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for PackageManager
bool PackageManagerFactoryManager::s_was_destroyed = false;

PackageManagerFactoryManager::PackageManagerFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

PackageManagerFactoryManager::~PackageManagerFactoryManager () {
	s_was_destroyed = true;
}

void PackageManagerFactoryManager::register_factory (
	PackageManagerAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void PackageManagerFactoryManager::publish_self () {
	if (Singleton::instance()->m_has_registred_factories) {
		PackageManagerFactoryManagerSrv_var ref = Singleton::instance()->_this();
		CoreSrv::bind_path (&LibHomeFactory::get().get_orb_facet().get_ns_root(), ref.in(), "RosePackageLocking::RosePackageLockingServer::PackageManager");
	}
}

void PackageManagerFactoryManager::register_factory_i (
	PackageManagerAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"RosePackageLocking::RosePackageLockingServer::PackageManagerFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = PackageManagerAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = PackageManagerAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

PackageManager* PackageManagerFactoryManager::instance () throw (CORBA::SystemException, CoreSrv::NoActiveFactory) {
	if (m_cached_object_for_instance.ptr() == 0) {
		GUARD(m_mutex_for_instance);
		if (m_cached_object_for_instance.ptr() == 0) {
			if (m_single_active_factory.is_nil()) {
				throw Core::Root::NoActiveFactory ("RosePackageLocking::RosePackageLockingServer::PackageManagerFactory");
			}
			m_cached_object_for_instance = m_single_active_factory->instance ();
		
			GDS_ASSERT_MSG (m_cached_object_for_instance.ptr() != 0, ("RosePackageLocking::RosePackageLockingServer::PackageManagerFactory impl can't return zerro"));
		}
	}
	return PackageManager::_duplicate(m_cached_object_for_instance.in ());
}
} // namespace RosePackageLockingServer
} // namespace RosePackageLocking

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

