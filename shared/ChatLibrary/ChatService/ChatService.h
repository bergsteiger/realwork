
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ChatLibrary/ChatService/ChatService.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<ServerInterfaces::Category>> shared::ChatLibrary::ChatService
//
// сервис обмена сообщениями. Интерфейсы подразумевают, что работа с чатом происходит в рамках
// сессии, которая позволяет идентифицировать текущего пользователя.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CHATLIBRARY_CHATSERVICE_H__
#define __SHARED_CHATLIBRARY_CHATSERVICE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/ChatLibrary/ChatService/ChatServiceC.h"
#include <vector>
#include "shared/CoreSrv/SecuritySrvComm/SecuritySrvComm.h"

namespace ChatLibrary {
namespace ChatService {

/// factory interface for UsersListManager
class UsersListManagerFactory {
public:
	// фабрика с кешированным параметром
	static UsersListManager& get ()
		/*throw (CoreSrv::NoActiveFactory)*/;

	//Реализация фабрики get для использования на стороне сервера
	static UsersListManager* get_srv ()
		/*throw (CoreSrv::NoActiveFactory)*/;

	// получить менеджер по идентификатору
	static UsersListManager& get_by_uid (CoreSrv::UserID uid)
		/*throw (CoreSrv::NoActiveFactory)*/;
private:
	typedef ACE_Singleton<UsersListManagerFactoryManagerSrv_var, ACE_SYNCH_RECURSIVE_MUTEX> FactoryManagerSrvSingleton;
	static Core::Mutex s_init_mutex;
	static bool s_renew_mode;

	// for cached factory get
	typedef ACE_Singleton <UsersListManager_var, ACE_SYNCH_RECURSIVE_MUTEX> CachedObjectForGet;
	static CORBA::ULong s_cached_object_hash_for_get;

	static Core::Mutex s_mutex_for_get;

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
	typedef ACE_Singleton <CachedObjectsForGetByUid, ACE_SYNCH_RECURSIVE_MUTEX> CachedObjectsForGetByUidSngl;
	typedef ACE_Singleton <CachedObjectsIndexForGetByUid, ACE_SYNCH_RECURSIVE_MUTEX> CachedObjectsIndexForGetByUidSngl;

	static Core::Mutex s_mutex_for_get_by_uid;
};

/// factory interface for MessageListener
class MessageListenerFactory {
public:
	// фабрика слушателя
	static MessageListener& make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

// additional interface for private factories implementation
class MessageListenerFactoryManagerLocal {
	friend class MessageListenerFactory;
private:
	virtual MessageListener& make () /*throw (Core::Root::NoActiveFactory)*/ = 0;
};

/// factory interface for ChatManager
class ChatManagerFactory {
public:
	// создаётся объект, работающий от имени создавшего его пользователя
	static ChatManager& make ()
		/*throw (CoreSrv::NoActiveFactory)*/;
private:
	typedef ACE_Singleton<ChatManagerFactoryManagerSrv_var, ACE_SYNCH_RECURSIVE_MUTEX> FactoryManagerSrvSingleton;
	static Core::Mutex s_init_mutex;
	static bool s_renew_mode;

	// for cached factory make
	typedef ACE_Singleton <ChatManager_var, ACE_SYNCH_RECURSIVE_MUTEX> CachedObjectForMake;
	static CORBA::ULong s_cached_object_hash_for_make;

	static Core::Mutex s_mutex_for_make;
};

/// factory interface for MessageManager
class MessageManagerFactory {
public:
	// фабрика с кешированным параметром
	static MessageManager& get ()
		/*throw (CoreSrv::NoActiveFactory)*/;

	//Реализация фабрики get для использования на стороне сервера
	static MessageManager* get_srv ()
		/*throw (CoreSrv::NoActiveFactory)*/;
private:
	typedef ACE_Singleton<MessageManagerFactoryManagerSrv_var, ACE_SYNCH_RECURSIVE_MUTEX> FactoryManagerSrvSingleton;
	static Core::Mutex s_init_mutex;
	static bool s_renew_mode;

	// for cached factory get
	typedef ACE_Singleton <MessageManager_var, ACE_SYNCH_RECURSIVE_MUTEX> CachedObjectForGet;
	static CORBA::ULong s_cached_object_hash_for_get;

	static Core::Mutex s_mutex_for_get;
};

} // namespace ChatService
} // namespace ChatLibrary


#endif //__SHARED_CHATLIBRARY_CHATSERVICE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

