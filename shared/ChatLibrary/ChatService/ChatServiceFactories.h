////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ChatLibrary/ChatService/ChatServiceFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<ServerInterfaces::Category>> shared::ChatLibrary::ChatService
//
// сервис обмена сообщениями. Интерфейсы подразумевают, что работа с чатом происходит в рамках
// сессии, которая позволяет идентифицировать текущего пользователя.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CHATLIBRARY_CHATSERVICE_FCTR_H__
#define __SHARED_CHATLIBRARY_CHATSERVICE_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "shared/ChatLibrary/ChatService/ChatService.h"
#include "shared/ChatLibrary/ChatService/ChatServiceS.h"

namespace ChatLibrary {
namespace ChatService {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for UsersListManager

class UsersListManagerAbstractFactory;

/// factory manager for UsersListManager
class UsersListManagerFactoryManager: virtual public POA_ChatLibrary::ChatService::UsersListManagerFactoryManagerSrv {
public:
	static void register_factory (UsersListManagerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

	static void publish_self ();

protected:
	UsersListManagerFactoryManager ();
	
	~UsersListManagerFactoryManager ();
	
	void register_factory_i (UsersListManagerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	UsersListManager* get () throw (CORBA::SystemException, CoreSrv::NoActiveFactory);

	UsersListManager* get_by_uid (CoreSrv::UserID uid) throw (CORBA::SystemException, CoreSrv::NoActiveFactory);

	friend class UsersListManagerFactory;
	typedef ACE_Singleton <UsersListManagerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <UsersListManagerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<UsersListManagerAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<UsersListManagerAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;

	// for cached factory get
	struct ObjectCreationIdForGet {
		CoreSrv::UserID uid_arg;

		ObjectCreationIdForGet (CoreSrv::UserID uid) : uid_arg (uid) {
		}

		bool operator < (const ObjectCreationIdForGet& c) const {
			return uid_arg < c.uid_arg;
		}
	};

	typedef std::map<ObjectCreationIdForGet, UsersListManager_var> CachedObjectsForGet;
	typedef std::map<CORBA::ULong, CachedObjectsForGet::iterator> CachedObjectsIndexForGet;
	CachedObjectsForGet m_cached_objects_for_get;
	CachedObjectsIndexForGet m_cached_objects_index_for_get;

	Core::Mutex m_mutex_for_get;

	// for cached factory get_by_uid
	struct ObjectCreationIdForGetByUid {
		CoreSrv::UserID uid_arg;

		ObjectCreationIdForGetByUid (CoreSrv::UserID uid) : uid_arg (uid) {
		}

		bool operator < (const ObjectCreationIdForGetByUid& c) const {
			return uid_arg < c.uid_arg;
		}
	};

	typedef std::map<ObjectCreationIdForGetByUid, UsersListManager_var> CachedObjectsForGetByUid;
	typedef std::map<CORBA::ULong, CachedObjectsForGetByUid::iterator> CachedObjectsIndexForGetByUid;
	CachedObjectsForGetByUid m_cached_objects_for_get_by_uid;
	CachedObjectsIndexForGetByUid m_cached_objects_index_for_get_by_uid;

	Core::Mutex m_mutex_for_get_by_uid;
};

/// abstract factory for UsersListManager
class UsersListManagerAbstractFactory : virtual public Core::IObject {
	friend class UsersListManagerFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual UsersListManager* get (CoreSrv::UserID uid) = 0;

	virtual UsersListManager* get_by_uid (CoreSrv::UserID uid) = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for MessageListener

class MessageListenerAbstractFactory;

/// factory manager for MessageListener
class MessageListenerFactoryManager: virtual public MessageListenerFactoryManagerLocal {
public:
	static void register_factory (MessageListenerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

	static void publish_self ();

protected:
	MessageListenerFactoryManager ();
	
	~MessageListenerFactoryManager ();
	
	void register_factory_i (MessageListenerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	MessageListener& make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class MessageListenerFactory;
	typedef ACE_Singleton <MessageListenerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <MessageListenerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<MessageListenerAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<MessageListenerAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;

	// for cached factory make
	MessageListener_var m_cached_object_for_make;

	Core::Mutex m_mutex_for_make;
};

/// abstract factory for MessageListener
class MessageListenerAbstractFactory : virtual public Core::IObject {
	friend class MessageListenerFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual MessageListener* make () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for ChatManager

class ChatManagerAbstractFactory;

/// factory manager for ChatManager
class ChatManagerFactoryManager: virtual public POA_ChatLibrary::ChatService::ChatManagerFactoryManagerSrv {
public:
	static void register_factory (ChatManagerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

	static void publish_self ();

protected:
	ChatManagerFactoryManager ();
	
	~ChatManagerFactoryManager ();
	
	void register_factory_i (ChatManagerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	ChatManager* make () throw (CORBA::SystemException, CoreSrv::NoActiveFactory);

	friend class ChatManagerFactory;
	typedef ACE_Singleton <ChatManagerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <ChatManagerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<ChatManagerAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<ChatManagerAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;

	// for cached factory make
	ChatManager_var m_cached_object_for_make;

	Core::Mutex m_mutex_for_make;
};

/// abstract factory for ChatManager
class ChatManagerAbstractFactory : virtual public Core::IObject {
	friend class ChatManagerFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual ChatManager* make () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for MessageManager

class MessageManagerAbstractFactory;

/// factory manager for MessageManager
class MessageManagerFactoryManager: virtual public POA_ChatLibrary::ChatService::MessageManagerFactoryManagerSrv {
public:
	static void register_factory (MessageManagerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

	static void publish_self ();

protected:
	MessageManagerFactoryManager ();
	
	~MessageManagerFactoryManager ();
	
	void register_factory_i (MessageManagerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	MessageManager* get () throw (CORBA::SystemException, CoreSrv::NoActiveFactory);

	friend class MessageManagerFactory;
	typedef ACE_Singleton <MessageManagerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <MessageManagerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<MessageManagerAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<MessageManagerAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;

	// for cached factory get
	struct ObjectCreationIdForGet {
		CoreSrv::UserID uid_arg;

		ObjectCreationIdForGet (CoreSrv::UserID uid) : uid_arg (uid) {
		}

		bool operator < (const ObjectCreationIdForGet& c) const {
			return uid_arg < c.uid_arg;
		}
	};

	typedef std::map<ObjectCreationIdForGet, MessageManager_var> CachedObjectsForGet;
	typedef std::map<CORBA::ULong, CachedObjectsForGet::iterator> CachedObjectsIndexForGet;
	CachedObjectsForGet m_cached_objects_for_get;
	CachedObjectsIndexForGet m_cached_objects_index_for_get;

	Core::Mutex m_mutex_for_get;
};

/// abstract factory for MessageManager
class MessageManagerAbstractFactory : virtual public Core::IObject {
	friend class MessageManagerFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual MessageManager* get (CoreSrv::UserID uid) = 0;
};

} // namespace ChatService
} // namespace ChatLibrary


#endif //__SHARED_CHATLIBRARY_CHATSERVICE_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

