
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ChatLibrary/ChatService/ChatService.cpp"
// генератор файлов реализации C++ (.cpp)
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
#include "shared/ChatLibrary/ChatService/ChatService.h"
#include "shared/ChatLibrary/LibHome.h"
#include "shared/ChatLibrary/ChatService/ChatServiceFactories.h"

namespace ChatLibrary {
namespace ChatService {

Core::Mutex UsersListManagerFactory::s_init_mutex;
bool UsersListManagerFactory::s_renew_mode = false;
Core::Mutex UsersListManagerFactory::s_mutex_for_get;
CORBA::ULong UsersListManagerFactory::s_cached_object_hash_for_get = 0;
Core::Mutex UsersListManagerFactory::s_mutex_for_get_by_uid;


// фабрика с кешированным параметром
UsersListManager& UsersListManagerFactory::get () /*throw (CoreSrv::NoActiveFactory)*/ {
	if (FactoryManagerSrvSingleton::instance()->ptr() == 0) {
		GUARD (s_init_mutex);
		if (FactoryManagerSrvSingleton::instance()->ptr() == 0) {
			try {
				CORBA::Object_var obj = CoreSrv::resolve_path (&LibHomeFactory::get().get_orb_facet().get_ns_root(), "ChatLibrary::ChatService::UsersListManager");
				*FactoryManagerSrvSingleton::instance() = UsersListManagerFactoryManagerSrv::_narrow (obj);
			} CATCH_AND_LOG ("COS Naming can't find FactoryManagerSrv for UsersListManager");
		}
		if (FactoryManagerSrvSingleton::instance()->ptr() == 0) {
			throw CoreSrv::NoActiveFactory ();
		}
	}
	try {

		bool created_new = false; //флаг о том, что объект был создан, а не получен из кэша
		if (CachedObjectForGet::instance()->ptr() == 0) {
			GUARD(s_mutex_for_get);
			if (CachedObjectForGet::instance()->ptr() == 0) {
				*CachedObjectForGet::instance() = (*FactoryManagerSrvSingleton::instance())->get ();
				s_cached_object_hash_for_get = (*CachedObjectForGet::instance())->_hash (std::numeric_limits<CORBA::ULong>::max ());
				created_new = true;
			}
		}
		if (created_new == false) {
			//если объект получили из кэша - нужно проверить, что он валиден
			bool need_recreate = false;
			try {
				need_recreate = CachedObjectForGet::instance()->ptr()->_non_existent ();
			} catch (...) {
				need_recreate = true;
			}
			if (need_recreate) {
				GUARD(s_mutex_for_get);
				*CachedObjectForGet::instance() = 0;
				*CachedObjectForGet::instance() = (*FactoryManagerSrvSingleton::instance())->get ();
				s_cached_object_hash_for_get = (*CachedObjectForGet::instance())->_hash (std::numeric_limits<CORBA::ULong>::max ());
			}
		}
		return *CachedObjectForGet::instance()->ptr();
	} catch (CORBA::TRANSIENT& ) {
		if (s_renew_mode) {
			s_renew_mode = false;
			LOG_W (("UsersListManagerFactoryManagerSrv is in invalid (inactive) state"));
			throw CoreSrv::NoActiveFactory ();
		}
		GUARD (s_init_mutex);
		LOG_D (("Try to renew UsersListManagerFactoryManagerSrv"));
		
		s_renew_mode = true;
		(*FactoryManagerSrvSingleton::instance()) = 0;
		UsersListManager& ret = get ();
		s_renew_mode = false;
		
		return ret;
	}
}

//Реализация фабрики get для использования на стороне сервера
UsersListManager* UsersListManagerFactory::get_srv ()
	/*throw (CoreSrv::NoActiveFactory)*/
{
	UsersListManagerFactoryManagerSrv_var factory_mng;
	try {
		CORBA::Object_var obj = CoreSrv::resolve_path (&LibHomeFactory::get().get_orb_facet().get_ns_root(), "ChatLibrary::ChatService::UsersListManager");
		factory_mng = UsersListManagerFactoryManagerSrv::_narrow (obj);
	} CATCH_AND_LOG ("COS Naming can't find FactoryManagerSrv for UsersListManager");
	
	if (CORBA::is_nil (factory_mng)) {
		throw CoreSrv::NoActiveFactory ();
	}
	
	return factory_mng->get ();
}

// получить менеджер по идентификатору
UsersListManager& UsersListManagerFactory::get_by_uid (CoreSrv::UserID uid) /*throw (CoreSrv::NoActiveFactory)*/ {
	if (FactoryManagerSrvSingleton::instance()->ptr() == 0) {
		GUARD (s_init_mutex);
		if (FactoryManagerSrvSingleton::instance()->ptr() == 0) {
			try {
				CORBA::Object_var obj = CoreSrv::resolve_path (&LibHomeFactory::get().get_orb_facet().get_ns_root(), "ChatLibrary::ChatService::UsersListManager");
				*FactoryManagerSrvSingleton::instance() = UsersListManagerFactoryManagerSrv::_narrow (obj);
			} CATCH_AND_LOG ("COS Naming can't find FactoryManagerSrv for UsersListManager");
		}
		if (FactoryManagerSrvSingleton::instance()->ptr() == 0) {
			throw CoreSrv::NoActiveFactory ();
		}
	}
	try {

		bool created_new = false; //флаг о том, что объект был создан, а не получен из кэша
		GUARD(s_mutex_for_get_by_uid);
		CachedObjectsForGetByUid::iterator f = CachedObjectsForGetByUidSngl::instance()->find (ObjectCreationIdForGetByUid(uid));
		if (f == CachedObjectsForGetByUidSngl::instance()->end()) {
			f = CachedObjectsForGetByUidSngl::instance()->insert (
				CachedObjectsForGetByUid::value_type(
					ObjectCreationIdForGetByUid(uid)
					, (*FactoryManagerSrvSingleton::instance())->get_by_uid (uid)
				)
			).first;
			(*CachedObjectsIndexForGetByUidSngl::instance())[f->second->_hash (std::numeric_limits<CORBA::ULong>::max ())] = f;
			created_new = true;
		}
		if (created_new == false) {
			//если объект получили из кэша - нужно проверить, что он валиден
			bool need_recreate = false;
			try {
				need_recreate = f->second->_non_existent ();
			} catch (...) {
				need_recreate = true;
			}
			if (need_recreate) {
				CachedObjectsForGetByUidSngl::instance()->erase (f);
				f = CachedObjectsForGetByUidSngl::instance()->insert (
					CachedObjectsForGetByUid::value_type(
						ObjectCreationIdForGetByUid(uid)
						, (*FactoryManagerSrvSingleton::instance())->get_by_uid (uid)
					)
				).first;
				(*CachedObjectsIndexForGetByUidSngl::instance())[f->second->_hash (std::numeric_limits<CORBA::ULong>::max ())] = f;
			}
		}
		return *f->second;
	} catch (CORBA::TRANSIENT& ) {
		if (s_renew_mode) {
			s_renew_mode = false;
			LOG_W (("UsersListManagerFactoryManagerSrv is in invalid (inactive) state"));
			throw CoreSrv::NoActiveFactory ();
		}
		GUARD (s_init_mutex);
		LOG_D (("Try to renew UsersListManagerFactoryManagerSrv"));
		
		s_renew_mode = true;
		(*FactoryManagerSrvSingleton::instance()) = 0;
		UsersListManager& ret = get_by_uid (uid);
		s_renew_mode = false;
		
		return ret;
	}
}



MessageListener& MessageListenerFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return MessageListenerFactoryManager::Singleton::instance ()->make ();
}


Core::Mutex ChatManagerFactory::s_init_mutex;
bool ChatManagerFactory::s_renew_mode = false;
Core::Mutex ChatManagerFactory::s_mutex_for_make;
CORBA::ULong ChatManagerFactory::s_cached_object_hash_for_make = 0;


// создаётся объект, работающий от имени создавшего его пользователя
ChatManager& ChatManagerFactory::make () /*throw (CoreSrv::NoActiveFactory)*/ {
	if (FactoryManagerSrvSingleton::instance()->ptr() == 0) {
		GUARD (s_init_mutex);
		if (FactoryManagerSrvSingleton::instance()->ptr() == 0) {
			try {
				CORBA::Object_var obj = CoreSrv::resolve_path (&LibHomeFactory::get().get_orb_facet().get_ns_root(), "ChatLibrary::ChatService::ChatManager");
				*FactoryManagerSrvSingleton::instance() = ChatManagerFactoryManagerSrv::_narrow (obj);
			} CATCH_AND_LOG ("COS Naming can't find FactoryManagerSrv for ChatManager");
		}
		if (FactoryManagerSrvSingleton::instance()->ptr() == 0) {
			throw CoreSrv::NoActiveFactory ();
		}
	}
	try {

		bool created_new = false; //флаг о том, что объект был создан, а не получен из кэша
		if (CachedObjectForMake::instance()->ptr() == 0) {
			GUARD(s_mutex_for_make);
			if (CachedObjectForMake::instance()->ptr() == 0) {
				*CachedObjectForMake::instance() = (*FactoryManagerSrvSingleton::instance())->make ();
				s_cached_object_hash_for_make = (*CachedObjectForMake::instance())->_hash (std::numeric_limits<CORBA::ULong>::max ());
				created_new = true;
			}
		}
		if (created_new == false) {
			//если объект получили из кэша - нужно проверить, что он валиден
			bool need_recreate = false;
			try {
				need_recreate = CachedObjectForMake::instance()->ptr()->_non_existent ();
			} catch (...) {
				need_recreate = true;
			}
			if (need_recreate) {
				GUARD(s_mutex_for_make);
				*CachedObjectForMake::instance() = 0;
				*CachedObjectForMake::instance() = (*FactoryManagerSrvSingleton::instance())->make ();
				s_cached_object_hash_for_make = (*CachedObjectForMake::instance())->_hash (std::numeric_limits<CORBA::ULong>::max ());
			}
		}
		return *CachedObjectForMake::instance()->ptr();
	} catch (CORBA::TRANSIENT& ) {
		if (s_renew_mode) {
			s_renew_mode = false;
			LOG_W (("ChatManagerFactoryManagerSrv is in invalid (inactive) state"));
			throw CoreSrv::NoActiveFactory ();
		}
		GUARD (s_init_mutex);
		LOG_D (("Try to renew ChatManagerFactoryManagerSrv"));
		
		s_renew_mode = true;
		(*FactoryManagerSrvSingleton::instance()) = 0;
		ChatManager& ret = make ();
		s_renew_mode = false;
		
		return ret;
	}
}


Core::Mutex MessageManagerFactory::s_init_mutex;
bool MessageManagerFactory::s_renew_mode = false;
Core::Mutex MessageManagerFactory::s_mutex_for_get;
CORBA::ULong MessageManagerFactory::s_cached_object_hash_for_get = 0;


// фабрика с кешированным параметром
MessageManager& MessageManagerFactory::get () /*throw (CoreSrv::NoActiveFactory)*/ {
	if (FactoryManagerSrvSingleton::instance()->ptr() == 0) {
		GUARD (s_init_mutex);
		if (FactoryManagerSrvSingleton::instance()->ptr() == 0) {
			try {
				CORBA::Object_var obj = CoreSrv::resolve_path (&LibHomeFactory::get().get_orb_facet().get_ns_root(), "ChatLibrary::ChatService::MessageManager");
				*FactoryManagerSrvSingleton::instance() = MessageManagerFactoryManagerSrv::_narrow (obj);
			} CATCH_AND_LOG ("COS Naming can't find FactoryManagerSrv for MessageManager");
		}
		if (FactoryManagerSrvSingleton::instance()->ptr() == 0) {
			throw CoreSrv::NoActiveFactory ();
		}
	}
	try {

		bool created_new = false; //флаг о том, что объект был создан, а не получен из кэша
		if (CachedObjectForGet::instance()->ptr() == 0) {
			GUARD(s_mutex_for_get);
			if (CachedObjectForGet::instance()->ptr() == 0) {
				*CachedObjectForGet::instance() = (*FactoryManagerSrvSingleton::instance())->get ();
				s_cached_object_hash_for_get = (*CachedObjectForGet::instance())->_hash (std::numeric_limits<CORBA::ULong>::max ());
				created_new = true;
			}
		}
		if (created_new == false) {
			//если объект получили из кэша - нужно проверить, что он валиден
			bool need_recreate = false;
			try {
				need_recreate = CachedObjectForGet::instance()->ptr()->_non_existent ();
			} catch (...) {
				need_recreate = true;
			}
			if (need_recreate) {
				GUARD(s_mutex_for_get);
				*CachedObjectForGet::instance() = 0;
				*CachedObjectForGet::instance() = (*FactoryManagerSrvSingleton::instance())->get ();
				s_cached_object_hash_for_get = (*CachedObjectForGet::instance())->_hash (std::numeric_limits<CORBA::ULong>::max ());
			}
		}
		return *CachedObjectForGet::instance()->ptr();
	} catch (CORBA::TRANSIENT& ) {
		if (s_renew_mode) {
			s_renew_mode = false;
			LOG_W (("MessageManagerFactoryManagerSrv is in invalid (inactive) state"));
			throw CoreSrv::NoActiveFactory ();
		}
		GUARD (s_init_mutex);
		LOG_D (("Try to renew MessageManagerFactoryManagerSrv"));
		
		s_renew_mode = true;
		(*FactoryManagerSrvSingleton::instance()) = 0;
		MessageManager& ret = get ();
		s_renew_mode = false;
		
		return ret;
	}
}

//Реализация фабрики get для использования на стороне сервера
MessageManager* MessageManagerFactory::get_srv ()
	/*throw (CoreSrv::NoActiveFactory)*/
{
	MessageManagerFactoryManagerSrv_var factory_mng;
	try {
		CORBA::Object_var obj = CoreSrv::resolve_path (&LibHomeFactory::get().get_orb_facet().get_ns_root(), "ChatLibrary::ChatService::MessageManager");
		factory_mng = MessageManagerFactoryManagerSrv::_narrow (obj);
	} CATCH_AND_LOG ("COS Naming can't find FactoryManagerSrv for MessageManager");
	
	if (CORBA::is_nil (factory_mng)) {
		throw CoreSrv::NoActiveFactory ();
	}
	
	return factory_mng->get ();
}


} // namespace ChatService
} // namespace ChatLibrary

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

