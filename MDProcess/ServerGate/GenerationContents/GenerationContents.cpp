
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ServerGate/GenerationContents/GenerationContents.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<ServerInterfaces::Category>> MDProcess::ServerGate::GenerationContents
//
// все ответственности связанные с генерацией в К
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ServerGate/GenerationContents/GenerationContents.h"
#include "MDProcess/ServerGate/LibHome.h"

namespace ServerGate {
namespace GenerationContents {

Core::Mutex PageFactory::s_init_mutex;
bool PageFactory::s_renew_mode = false;
Core::Mutex PageFactory::s_mutex_for_get;


PageFactoryKeySet* PageFactory::keys () /*throw (CoreSrv::ForeignObject)*/ {
	if (FactoryManagerSrvSingleton::instance()->ptr() == 0) {
		GUARD (s_init_mutex);
		if (FactoryManagerSrvSingleton::instance()->ptr() == 0) {
			try {
				CORBA::Object_var obj = CoreSrv::resolve_path (&LibHomeFactory::get().get_orb_facet().get_ns_root(), "ServerGate::GenerationContents::Page");
				*FactoryManagerSrvSingleton::instance() = PageFactoryManagerSrv::_narrow (obj);
			} CATCH_AND_LOG ("COS Naming can't find FactoryManagerSrv for Page");
		}
		if (FactoryManagerSrvSingleton::instance()->ptr() == 0) {
			throw CoreSrv::ForeignObject ();
		}
	}
	try {
		return (*FactoryManagerSrvSingleton::instance())->keys ();
	} catch (CORBA::TRANSIENT& ) {
		if (s_renew_mode) {
			s_renew_mode = false;
			LOG_W (("PageFactoryManagerSrv is in invalid (inactive) state"));
			throw CoreSrv::ForeignObject ();
		}
		GUARD (s_init_mutex);
		LOG_D (("Try to renew PageFactoryManagerSrv"));
		
		s_renew_mode = true;
		(*FactoryManagerSrvSingleton::instance()) = 0;
		PageFactoryKeySet* ret = keys ();
		s_renew_mode = false;
		
		return ret;
	} catch (CORBA::OBJECT_NOT_EXIST& ) {
		if (s_renew_mode) {
			s_renew_mode = false;
			LOG_W (("PageFactoryManagerSrv is in invalid (inactive) state"));
			throw CoreSrv::ForeignObject ();
		}
		GUARD (s_init_mutex);
		LOG_D (("Try to renew PageFactoryManagerSrv"));
		
		s_renew_mode = true;
		(*FactoryManagerSrvSingleton::instance()) = 0;
		PageFactoryKeySet* ret = keys ();
		s_renew_mode = false;
		
		return ret;
	}
}

// возвращает существующую страницу по ее ид
Page& PageFactory::get (ModelElementId_const guid) /*throw (CoreSrv::NoActiveFactory)*/ {
	if (FactoryManagerSrvSingleton::instance()->ptr() == 0) {
		GUARD (s_init_mutex);
		if (FactoryManagerSrvSingleton::instance()->ptr() == 0) {
			try {
				CORBA::Object_var obj = CoreSrv::resolve_path (&LibHomeFactory::get().get_orb_facet().get_ns_root(), "ServerGate::GenerationContents::Page");
				*FactoryManagerSrvSingleton::instance() = PageFactoryManagerSrv::_narrow (obj);
			} CATCH_AND_LOG ("COS Naming can't find FactoryManagerSrv for Page");
		}
		if (FactoryManagerSrvSingleton::instance()->ptr() == 0) {
			throw CoreSrv::NoActiveFactory ();
		}
	}
	try {

		bool created_new = false; //флаг о том, что объект был создан, а не получен из кэша
		GUARD(s_mutex_for_get);
		CachedObjectsForGet::iterator f = CachedObjectsForGetSngl::instance()->find (ObjectCreationIdForGet(guid));
		if (f == CachedObjectsForGetSngl::instance()->end()) {
			f = CachedObjectsForGetSngl::instance()->insert (
				CachedObjectsForGet::value_type(
					ObjectCreationIdForGet(guid)
					, (*FactoryManagerSrvSingleton::instance())->get (guid)
				)
			).first;
			(*CachedObjectsIndexForGetSngl::instance())[f->second->_hash (std::numeric_limits<CORBA::ULong>::max ())] = f;
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
				CachedObjectsForGetSngl::instance()->erase (f);
				f = CachedObjectsForGetSngl::instance()->insert (
					CachedObjectsForGet::value_type(
						ObjectCreationIdForGet(guid)
						, (*FactoryManagerSrvSingleton::instance())->get (guid)
					)
				).first;
				(*CachedObjectsIndexForGetSngl::instance())[f->second->_hash (std::numeric_limits<CORBA::ULong>::max ())] = f;
			}
		}
		return *f->second;
	} catch (CORBA::TRANSIENT& ) {
		if (s_renew_mode) {
			s_renew_mode = false;
			LOG_W (("PageFactoryManagerSrv is in invalid (inactive) state"));
			throw CoreSrv::NoActiveFactory ();
		}
		GUARD (s_init_mutex);
		LOG_D (("Try to renew PageFactoryManagerSrv"));
		
		s_renew_mode = true;
		(*FactoryManagerSrvSingleton::instance()) = 0;
		Page& ret = get (guid);
		s_renew_mode = false;
		
		return ret;				
	} catch (CORBA::OBJECT_NOT_EXIST& ) {
		if (s_renew_mode) {
			s_renew_mode = false;
			LOG_W (("PageFactoryManagerSrv is in invalid (inactive) state"));
			throw CoreSrv::NoActiveFactory ();
		}
		GUARD (s_init_mutex);
		LOG_D (("Try to renew PageFactoryManagerSrv"));
		
		s_renew_mode = true;
		(*FactoryManagerSrvSingleton::instance()) = 0;
		Page& ret = get (guid);
		s_renew_mode = false;
		
		return ret;				
	}
}


Core::Mutex GenerationManagerFactory::s_init_mutex;
bool GenerationManagerFactory::s_renew_mode = false;
Core::Mutex GenerationManagerFactory::s_mutex_for_get;
CORBA::ULong GenerationManagerFactory::s_cached_object_hash_for_get = 0;


// кэшированная фабрика
GenerationManager& GenerationManagerFactory::get () /*throw (CoreSrv::NoActiveFactory)*/ {
	if (FactoryManagerSrvSingleton::instance()->ptr() == 0) {
		GUARD (s_init_mutex);
		if (FactoryManagerSrvSingleton::instance()->ptr() == 0) {
			try {
				CORBA::Object_var obj = CoreSrv::resolve_path (&LibHomeFactory::get().get_orb_facet().get_ns_root(), "ServerGate::GenerationContents::GenerationManager");
				*FactoryManagerSrvSingleton::instance() = GenerationManagerFactoryManagerSrv::_narrow (obj);
			} CATCH_AND_LOG ("COS Naming can't find FactoryManagerSrv for GenerationManager");
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
			LOG_W (("GenerationManagerFactoryManagerSrv is in invalid (inactive) state"));
			throw CoreSrv::NoActiveFactory ();
		}
		GUARD (s_init_mutex);
		LOG_D (("Try to renew GenerationManagerFactoryManagerSrv"));
		
		s_renew_mode = true;
		(*FactoryManagerSrvSingleton::instance()) = 0;
		GenerationManager& ret = get ();
		s_renew_mode = false;
		
		return ret;				
	} catch (CORBA::OBJECT_NOT_EXIST& ) {
		if (s_renew_mode) {
			s_renew_mode = false;
			LOG_W (("GenerationManagerFactoryManagerSrv is in invalid (inactive) state"));
			throw CoreSrv::NoActiveFactory ();
		}
		GUARD (s_init_mutex);
		LOG_D (("Try to renew GenerationManagerFactoryManagerSrv"));
		
		s_renew_mode = true;
		(*FactoryManagerSrvSingleton::instance()) = 0;
		GenerationManager& ret = get ();
		s_renew_mode = false;
		
		return ret;				
	}
}


} // namespace GenerationContents
} // namespace ServerGate

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

