
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ServerGate/Users/Users.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<ServerInterfaces::Category>> MDProcess::ServerGate::Users
//
// все ответсвенности связанные с авторизованным доступом
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ServerGate/Users/Users.h"
#include "MDProcess/ServerGate/LibHome.h"

namespace ServerGate {
namespace Users {

Core::Mutex AccessorFactory::s_init_mutex;
bool AccessorFactory::s_renew_mode = false;

// получить экземпляр
Accessor* AccessorFactory::make () /*throw (CoreSrv::NoActiveFactory)*/ {
	if (FactoryManagerSrvSingleton::instance()->ptr() == 0) {
		GUARD (s_init_mutex);
		if (FactoryManagerSrvSingleton::instance()->ptr() == 0) {
			try {
				CORBA::Object_var obj = CoreSrv::resolve_path (&LibHomeFactory::get().get_orb_facet().get_ns_root(), "ServerGate::Users::Accessor");
				*FactoryManagerSrvSingleton::instance() = AccessorFactoryManagerSrv::_narrow (obj);
			} CATCH_AND_LOG ("COS Naming can't find FactoryManagerSrv for Accessor");
		}
		if (FactoryManagerSrvSingleton::instance()->ptr() == 0) {
			throw CoreSrv::NoActiveFactory ();
		}
	}
	try {
		return (*FactoryManagerSrvSingleton::instance())->make ();
	} catch (CORBA::TRANSIENT& ) {
		if (s_renew_mode) {
			s_renew_mode = false;
			LOG_W (("AccessorFactoryManagerSrv is in invalid (inactive) state"));
			throw CoreSrv::NoActiveFactory ();
		}
		GUARD (s_init_mutex);
		LOG_D (("Try to renew AccessorFactoryManagerSrv"));
		
		s_renew_mode = true;
		(*FactoryManagerSrvSingleton::instance()) = 0;
		Accessor_var ret = make ();
		s_renew_mode = false;
		
		return ret._retn();				
	} catch (CORBA::OBJECT_NOT_EXIST& ) {
		if (s_renew_mode) {
			s_renew_mode = false;
			LOG_W (("AccessorFactoryManagerSrv is in invalid (inactive) state"));
			throw CoreSrv::NoActiveFactory ();
		}
		GUARD (s_init_mutex);
		LOG_D (("Try to renew AccessorFactoryManagerSrv"));
		
		s_renew_mode = true;
		(*FactoryManagerSrvSingleton::instance()) = 0;
		Accessor_var ret = make ();
		s_renew_mode = false;
		
		return ret._retn();				
	}
}


Core::Mutex UserFactory::s_init_mutex;
bool UserFactory::s_renew_mode = false;
Core::Mutex UserFactory::s_mutex_for_make;


// получить экземпляр по юзер-айди
User& UserFactory::make (CoreSrv::UserID uid) /*throw (CoreSrv::NoActiveFactory)*/ {
	if (FactoryManagerSrvSingleton::instance()->ptr() == 0) {
		GUARD (s_init_mutex);
		if (FactoryManagerSrvSingleton::instance()->ptr() == 0) {
			try {
				CORBA::Object_var obj = CoreSrv::resolve_path (&LibHomeFactory::get().get_orb_facet().get_ns_root(), "ServerGate::Users::User");
				*FactoryManagerSrvSingleton::instance() = UserFactoryManagerSrv::_narrow (obj);
			} CATCH_AND_LOG ("COS Naming can't find FactoryManagerSrv for User");
		}
		if (FactoryManagerSrvSingleton::instance()->ptr() == 0) {
			throw CoreSrv::NoActiveFactory ();
		}
	}
	try {

		bool created_new = false; //флаг о том, что объект был создан, а не получен из кэша
		GUARD(s_mutex_for_make);
		CachedObjectsForMake::iterator f = CachedObjectsForMakeSngl::instance()->find (ObjectCreationIdForMake(uid));
		if (f == CachedObjectsForMakeSngl::instance()->end()) {
			f = CachedObjectsForMakeSngl::instance()->insert (
				CachedObjectsForMake::value_type(
					ObjectCreationIdForMake(uid)
					, (*FactoryManagerSrvSingleton::instance())->make (uid)
				)
			).first;
			(*CachedObjectsIndexForMakeSngl::instance())[f->second->_hash (std::numeric_limits<CORBA::ULong>::max ())] = f;
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
				CachedObjectsForMakeSngl::instance()->erase (f);
				f = CachedObjectsForMakeSngl::instance()->insert (
					CachedObjectsForMake::value_type(
						ObjectCreationIdForMake(uid)
						, (*FactoryManagerSrvSingleton::instance())->make (uid)
					)
				).first;
				(*CachedObjectsIndexForMakeSngl::instance())[f->second->_hash (std::numeric_limits<CORBA::ULong>::max ())] = f;
			}
		}
		return *f->second;
	} catch (CORBA::TRANSIENT& ) {
		if (s_renew_mode) {
			s_renew_mode = false;
			LOG_W (("UserFactoryManagerSrv is in invalid (inactive) state"));
			throw CoreSrv::NoActiveFactory ();
		}
		GUARD (s_init_mutex);
		LOG_D (("Try to renew UserFactoryManagerSrv"));
		
		s_renew_mode = true;
		(*FactoryManagerSrvSingleton::instance()) = 0;
		User& ret = make (uid);
		s_renew_mode = false;
		
		return ret;				
	} catch (CORBA::OBJECT_NOT_EXIST& ) {
		if (s_renew_mode) {
			s_renew_mode = false;
			LOG_W (("UserFactoryManagerSrv is in invalid (inactive) state"));
			throw CoreSrv::NoActiveFactory ();
		}
		GUARD (s_init_mutex);
		LOG_D (("Try to renew UserFactoryManagerSrv"));
		
		s_renew_mode = true;
		(*FactoryManagerSrvSingleton::instance()) = 0;
		User& ret = make (uid);
		s_renew_mode = false;
		
		return ret;				
	}
}


} // namespace Users
} // namespace ServerGate

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

