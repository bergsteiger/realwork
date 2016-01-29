////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ChatLibrary/ChatService/ChatServiceFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<ServerInterfaces::Category>> shared::ChatLibrary::ChatService
//
// сервис обмена сообщениями. Интерфейсы подразумевают, что работа с чатом происходит в рамках
// сессии, которая позволяет идентифицировать текущего пользователя.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/ChatLibrary/ChatService/ChatServiceFactories.h"
#include "shared/ChatLibrary/LibHome.h"

namespace ChatLibrary {
namespace ChatService {

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for UsersListManager
bool UsersListManagerFactoryManager::s_was_destroyed = false;

UsersListManagerFactoryManager::UsersListManagerFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

UsersListManagerFactoryManager::~UsersListManagerFactoryManager () {
	s_was_destroyed = true;
}

void UsersListManagerFactoryManager::register_factory (
	UsersListManagerAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void UsersListManagerFactoryManager::publish_self () {
	if (Singleton::instance()->m_has_registred_factories) {
		UsersListManagerFactoryManagerSrv_var ref = Singleton::instance()->_this();
		CoreSrv::bind_path (&LibHomeFactory::get().get_orb_facet().get_ns_root(), ref.in(), "ChatLibrary::ChatService::UsersListManager");
	}
}

void UsersListManagerFactoryManager::register_factory_i (
	UsersListManagerAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"ChatLibrary::ChatService::UsersListManagerFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = UsersListManagerAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = UsersListManagerAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

UsersListManager* UsersListManagerFactoryManager::get () throw (CORBA::SystemException, CoreSrv::NoActiveFactory) {
	GUARD(m_mutex_for_get);
	CoreSrv::UserID uid;
	//#UC START# *4A3735D401C5_INIT_CUSTOM_CACHE_ARGS*
	uid = CoreSrv::SessionFactory::get ().get_context_uid ();
	//#UC END# *4A3735D401C5_INIT_CUSTOM_CACHE_ARGS*
	CachedObjectsForGet::iterator f = m_cached_objects_for_get.find (ObjectCreationIdForGet(uid));
	if (f == m_cached_objects_for_get.end()) {
		if (m_single_active_factory.is_nil()) {
			throw Core::Root::NoActiveFactory ("ChatLibrary::ChatService::UsersListManagerFactory");
		}
		f = m_cached_objects_for_get.insert (
			CachedObjectsForGet::value_type(
				ObjectCreationIdForGet(uid)
				, m_single_active_factory->get (uid)
			)
		).first;
		m_cached_objects_index_for_get.insert (
			CachedObjectsIndexForGet::value_type (
				f->second->_hash (std::numeric_limits<CORBA::ULong>::max ())
				, f
			)
		);
	
	}
	GDS_ASSERT_MSG (f->second.in () != 0, ("ChatLibrary::ChatService::UsersListManagerFactory impl can't return zerro"));
	return UsersListManager::_duplicate(f->second.in ());
}

UsersListManager* UsersListManagerFactoryManager::get_by_uid (CoreSrv::UserID uid) throw (CORBA::SystemException, CoreSrv::NoActiveFactory) {
	GUARD(m_mutex_for_get_by_uid);
	CachedObjectsForGetByUid::iterator f = m_cached_objects_for_get_by_uid.find (ObjectCreationIdForGetByUid(uid));
	if (f == m_cached_objects_for_get_by_uid.end()) {
		if (m_single_active_factory.is_nil()) {
			throw Core::Root::NoActiveFactory ("ChatLibrary::ChatService::UsersListManagerFactory");
		}
		f = m_cached_objects_for_get_by_uid.insert (
			CachedObjectsForGetByUid::value_type(
				ObjectCreationIdForGetByUid(uid)
				, m_single_active_factory->get_by_uid (uid)
			)
		).first;
		m_cached_objects_index_for_get_by_uid.insert (
			CachedObjectsIndexForGetByUid::value_type (
				f->second->_hash (std::numeric_limits<CORBA::ULong>::max ())
				, f
			)
		);
	
	}
	GDS_ASSERT_MSG (f->second.in () != 0, ("ChatLibrary::ChatService::UsersListManagerFactory impl can't return zerro"));
	return UsersListManager::_duplicate(f->second.in ());
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for MessageListener
bool MessageListenerFactoryManager::s_was_destroyed = false;

MessageListenerFactoryManager::MessageListenerFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

MessageListenerFactoryManager::~MessageListenerFactoryManager () {
	s_was_destroyed = true;
}

void MessageListenerFactoryManager::register_factory (
	MessageListenerAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void MessageListenerFactoryManager::publish_self () {
}

void MessageListenerFactoryManager::register_factory_i (
	MessageListenerAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"ChatLibrary::ChatService::MessageListenerFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = MessageListenerAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = MessageListenerAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

MessageListener& MessageListenerFactoryManager::make () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_cached_object_for_make.ptr() == 0) {
		GUARD(m_mutex_for_make);
		if (m_cached_object_for_make.ptr() == 0) {
			if (m_single_active_factory.is_nil()) {
				throw Core::Root::NoActiveFactory ("ChatLibrary::ChatService::MessageListenerFactory");
			}
			m_cached_object_for_make = m_single_active_factory->make ();
		
			GDS_ASSERT_MSG (m_cached_object_for_make.ptr() != 0, ("ChatLibrary::ChatService::MessageListenerFactory impl can't return zerro"));
		}
	}
	return *m_cached_object_for_make;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for ChatManager
bool ChatManagerFactoryManager::s_was_destroyed = false;

ChatManagerFactoryManager::ChatManagerFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

ChatManagerFactoryManager::~ChatManagerFactoryManager () {
	s_was_destroyed = true;
}

void ChatManagerFactoryManager::register_factory (
	ChatManagerAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void ChatManagerFactoryManager::publish_self () {
	if (Singleton::instance()->m_has_registred_factories) {
		ChatManagerFactoryManagerSrv_var ref = Singleton::instance()->_this();
		CoreSrv::bind_path (&LibHomeFactory::get().get_orb_facet().get_ns_root(), ref.in(), "ChatLibrary::ChatService::ChatManager");
	}
}

void ChatManagerFactoryManager::register_factory_i (
	ChatManagerAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"ChatLibrary::ChatService::ChatManagerFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = ChatManagerAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = ChatManagerAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

ChatManager* ChatManagerFactoryManager::make () throw (CORBA::SystemException, CoreSrv::NoActiveFactory) {
	if (m_cached_object_for_make.ptr() == 0) {
		GUARD(m_mutex_for_make);
		if (m_cached_object_for_make.ptr() == 0) {
			if (m_single_active_factory.is_nil()) {
				throw Core::Root::NoActiveFactory ("ChatLibrary::ChatService::ChatManagerFactory");
			}
			m_cached_object_for_make = m_single_active_factory->make ();
		
			GDS_ASSERT_MSG (m_cached_object_for_make.ptr() != 0, ("ChatLibrary::ChatService::ChatManagerFactory impl can't return zerro"));
		}
	}
	return ChatManager::_duplicate(m_cached_object_for_make.in ());
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for MessageManager
bool MessageManagerFactoryManager::s_was_destroyed = false;

MessageManagerFactoryManager::MessageManagerFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

MessageManagerFactoryManager::~MessageManagerFactoryManager () {
	s_was_destroyed = true;
}

void MessageManagerFactoryManager::register_factory (
	MessageManagerAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void MessageManagerFactoryManager::publish_self () {
	if (Singleton::instance()->m_has_registred_factories) {
		MessageManagerFactoryManagerSrv_var ref = Singleton::instance()->_this();
		CoreSrv::bind_path (&LibHomeFactory::get().get_orb_facet().get_ns_root(), ref.in(), "ChatLibrary::ChatService::MessageManager");
	}
}

void MessageManagerFactoryManager::register_factory_i (
	MessageManagerAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"ChatLibrary::ChatService::MessageManagerFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = MessageManagerAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = MessageManagerAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

MessageManager* MessageManagerFactoryManager::get () throw (CORBA::SystemException, CoreSrv::NoActiveFactory) {
	GUARD(m_mutex_for_get);
	CoreSrv::UserID uid;
	//#UC START# *4A3735BB039D_INIT_CUSTOM_CACHE_ARGS*
	uid = CoreSrv::SessionFactory::get ().get_context_uid ();
	//#UC END# *4A3735BB039D_INIT_CUSTOM_CACHE_ARGS*
	CachedObjectsForGet::iterator f = m_cached_objects_for_get.find (ObjectCreationIdForGet(uid));
	if (f == m_cached_objects_for_get.end()) {
		if (m_single_active_factory.is_nil()) {
			throw Core::Root::NoActiveFactory ("ChatLibrary::ChatService::MessageManagerFactory");
		}
		f = m_cached_objects_for_get.insert (
			CachedObjectsForGet::value_type(
				ObjectCreationIdForGet(uid)
				, m_single_active_factory->get (uid)
			)
		).first;
		m_cached_objects_index_for_get.insert (
			CachedObjectsIndexForGet::value_type (
				f->second->_hash (std::numeric_limits<CORBA::ULong>::max ())
				, f
			)
		);
	
	}
	GDS_ASSERT_MSG (f->second.in () != 0, ("ChatLibrary::ChatService::MessageManagerFactory impl can't return zerro"));
	return MessageManager::_duplicate(f->second.in ());
}
} // namespace ChatService
} // namespace ChatLibrary

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

