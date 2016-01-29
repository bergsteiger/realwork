////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ServerGate/Users/UsersFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<ServerInterfaces::Category>> MDProcess::ServerGate::Users
//
// все ответсвенности связанные с авторизованным доступом
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ServerGate/Users/UsersFactories.h"
#include "MDProcess/ServerGate/LibHome.h"

namespace ServerGate {
namespace Users {

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for Accessor
bool AccessorFactoryManager::s_was_destroyed = false;

AccessorFactoryManager::AccessorFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

AccessorFactoryManager::~AccessorFactoryManager () {
	s_was_destroyed = true;
}

void AccessorFactoryManager::register_factory (
	AccessorAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void AccessorFactoryManager::publish_self () {
	if (Singleton::instance()->m_has_registred_factories) {
		AccessorFactoryManagerSrv_var ref = Singleton::instance()->_this();
		CoreSrv::bind_path (&LibHomeFactory::get().get_orb_facet().get_ns_root(), ref.in(), "ServerGate::Users::Accessor");
	}
}

void AccessorFactoryManager::register_factory_i (
	AccessorAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"ServerGate::Users::AccessorFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = AccessorAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = AccessorAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

Accessor* AccessorFactoryManager::make () throw (CORBA::SystemException, CoreSrv::NoActiveFactory) {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("ServerGate::Users::AccessorFactory");
	}
	Accessor* ret_ = m_single_active_factory->make ();
	GDS_ASSERT_MSG (ret_ != 0, ("ServerGate::Users::AccessorFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for User
bool UserFactoryManager::s_was_destroyed = false;

UserFactoryManager::UserFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

UserFactoryManager::~UserFactoryManager () {
	s_was_destroyed = true;
}

void UserFactoryManager::register_factory (
	UserAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void UserFactoryManager::publish_self () {
	if (Singleton::instance()->m_has_registred_factories) {
		UserFactoryManagerSrv_var ref = Singleton::instance()->_this();
		CoreSrv::bind_path (&LibHomeFactory::get().get_orb_facet().get_ns_root(), ref.in(), "ServerGate::Users::User");
	}
}

void UserFactoryManager::register_factory_i (
	UserAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"ServerGate::Users::UserFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = UserAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = UserAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

User* UserFactoryManager::make (CoreSrv::UserID uid) throw (CORBA::SystemException, CoreSrv::NoActiveFactory) {
	GUARD(m_mutex_for_make);
	CachedObjectsForMake::iterator f = m_cached_objects_for_make.find (ObjectCreationIdForMake(uid));
	if (f == m_cached_objects_for_make.end()) {
		if (m_single_active_factory.is_nil()) {
			throw Core::Root::NoActiveFactory ("ServerGate::Users::UserFactory");
		}
		f = m_cached_objects_for_make.insert (
			CachedObjectsForMake::value_type(
				ObjectCreationIdForMake(uid)
				, m_single_active_factory->make (uid)
			)
		).first;
		m_cached_objects_index_for_make.insert (
			CachedObjectsIndexForMake::value_type (
				f->second->_hash (std::numeric_limits<CORBA::ULong>::max ())
				, f
			)
		);
	
	}
	GDS_ASSERT_MSG (f->second.in () != 0, ("ServerGate::Users::UserFactory impl can't return zerro"));
	return User::_duplicate(f->second.in ());
}
} // namespace Users
} // namespace ServerGate

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

