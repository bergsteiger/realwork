
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/RosePackageLocking/RosePackageLockingServer/RosePackageLockingServer.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<ServerInterfaces::Category>> MDProcess::RosePackageLocking::RosePackageLockingServer
//
// ответственности для работы с залочками пакетов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/RosePackageLocking/RosePackageLockingServer/RosePackageLockingServer.h"
#include "MDProcess/RosePackageLocking/LibHome.h"

namespace RosePackageLocking {
namespace RosePackageLockingServer {

Core::Mutex PackageFactory::s_init_mutex;
bool PackageFactory::s_renew_mode = false;
Core::Mutex PackageFactory::s_mutex_for_instance;


// получить кэшированный экземпляр объекта
Package& PackageFactory::instance (PackageGUID_const guid) /*throw (CoreSrv::NoActiveFactory)*/ {
	if (FactoryManagerSrvSingleton::instance()->ptr() == 0) {
		GUARD (s_init_mutex);
		if (FactoryManagerSrvSingleton::instance()->ptr() == 0) {
			try {
				CORBA::Object_var obj = CoreSrv::resolve_path (&LibHomeFactory::get().get_orb_facet().get_ns_root(), "RosePackageLocking::RosePackageLockingServer::Package");
				*FactoryManagerSrvSingleton::instance() = PackageFactoryManagerSrv::_narrow (obj);
			} CATCH_AND_LOG ("COS Naming can't find FactoryManagerSrv for Package");
		}
		if (FactoryManagerSrvSingleton::instance()->ptr() == 0) {
			throw CoreSrv::NoActiveFactory ();
		}
	}
	try {

		bool created_new = false; //флаг о том, что объект был создан, а не получен из кэша
		GUARD(s_mutex_for_instance);
		CachedObjectsForInstance::iterator f = CachedObjectsForInstanceSngl::instance()->find (ObjectCreationIdForInstance(guid));
		if (f == CachedObjectsForInstanceSngl::instance()->end()) {
			f = CachedObjectsForInstanceSngl::instance()->insert (
				CachedObjectsForInstance::value_type(
					ObjectCreationIdForInstance(guid)
					, (*FactoryManagerSrvSingleton::instance())->instance (guid)
				)
			).first;
			(*CachedObjectsIndexForInstanceSngl::instance())[f->second->_hash (std::numeric_limits<CORBA::ULong>::max ())] = f;
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
				CachedObjectsForInstanceSngl::instance()->erase (f);
				f = CachedObjectsForInstanceSngl::instance()->insert (
					CachedObjectsForInstance::value_type(
						ObjectCreationIdForInstance(guid)
						, (*FactoryManagerSrvSingleton::instance())->instance (guid)
					)
				).first;
				(*CachedObjectsIndexForInstanceSngl::instance())[f->second->_hash (std::numeric_limits<CORBA::ULong>::max ())] = f;
			}
		}
		return *f->second;
	} catch (CORBA::TRANSIENT& ) {
		if (s_renew_mode) {
			s_renew_mode = false;
			LOG_W (("PackageFactoryManagerSrv is in invalid (inactive) state"));
			throw CoreSrv::NoActiveFactory ();
		}
		GUARD (s_init_mutex);
		LOG_D (("Try to renew PackageFactoryManagerSrv"));
		
		s_renew_mode = true;
		(*FactoryManagerSrvSingleton::instance()) = 0;
		Package& ret = instance (guid);
		s_renew_mode = false;
		
		return ret;				
	} catch (CORBA::OBJECT_NOT_EXIST& ) {
		if (s_renew_mode) {
			s_renew_mode = false;
			LOG_W (("PackageFactoryManagerSrv is in invalid (inactive) state"));
			throw CoreSrv::NoActiveFactory ();
		}
		GUARD (s_init_mutex);
		LOG_D (("Try to renew PackageFactoryManagerSrv"));
		
		s_renew_mode = true;
		(*FactoryManagerSrvSingleton::instance()) = 0;
		Package& ret = instance (guid);
		s_renew_mode = false;
		
		return ret;				
	}
}


Core::Mutex PackageManagerFactory::s_init_mutex;
bool PackageManagerFactory::s_renew_mode = false;
Core::Mutex PackageManagerFactory::s_mutex_for_instance;
CORBA::ULong PackageManagerFactory::s_cached_object_hash_for_instance = 0;


// получить кэшированый экземпляр
PackageManager& PackageManagerFactory::instance () /*throw (CoreSrv::NoActiveFactory)*/ {
	if (FactoryManagerSrvSingleton::instance()->ptr() == 0) {
		GUARD (s_init_mutex);
		if (FactoryManagerSrvSingleton::instance()->ptr() == 0) {
			try {
				CORBA::Object_var obj = CoreSrv::resolve_path (&LibHomeFactory::get().get_orb_facet().get_ns_root(), "RosePackageLocking::RosePackageLockingServer::PackageManager");
				*FactoryManagerSrvSingleton::instance() = PackageManagerFactoryManagerSrv::_narrow (obj);
			} CATCH_AND_LOG ("COS Naming can't find FactoryManagerSrv for PackageManager");
		}
		if (FactoryManagerSrvSingleton::instance()->ptr() == 0) {
			throw CoreSrv::NoActiveFactory ();
		}
	}
	try {

		bool created_new = false; //флаг о том, что объект был создан, а не получен из кэша
		if (CachedObjectForInstance::instance()->ptr() == 0) {
			GUARD(s_mutex_for_instance);
			if (CachedObjectForInstance::instance()->ptr() == 0) {
				*CachedObjectForInstance::instance() = (*FactoryManagerSrvSingleton::instance())->instance ();
				s_cached_object_hash_for_instance = (*CachedObjectForInstance::instance())->_hash (std::numeric_limits<CORBA::ULong>::max ());
				created_new = true;
			}
		}
		if (created_new == false) {
			//если объект получили из кэша - нужно проверить, что он валиден
			bool need_recreate = false;
			try {
				need_recreate = CachedObjectForInstance::instance()->ptr()->_non_existent ();
			} catch (...) {
				need_recreate = true;
			}
			if (need_recreate) {
				GUARD(s_mutex_for_instance);
				*CachedObjectForInstance::instance() = 0;
				*CachedObjectForInstance::instance() = (*FactoryManagerSrvSingleton::instance())->instance ();
				s_cached_object_hash_for_instance = (*CachedObjectForInstance::instance())->_hash (std::numeric_limits<CORBA::ULong>::max ());
			}
		}
		return *CachedObjectForInstance::instance()->ptr();
	} catch (CORBA::TRANSIENT& ) {
		if (s_renew_mode) {
			s_renew_mode = false;
			LOG_W (("PackageManagerFactoryManagerSrv is in invalid (inactive) state"));
			throw CoreSrv::NoActiveFactory ();
		}
		GUARD (s_init_mutex);
		LOG_D (("Try to renew PackageManagerFactoryManagerSrv"));
		
		s_renew_mode = true;
		(*FactoryManagerSrvSingleton::instance()) = 0;
		PackageManager& ret = instance ();
		s_renew_mode = false;
		
		return ret;				
	} catch (CORBA::OBJECT_NOT_EXIST& ) {
		if (s_renew_mode) {
			s_renew_mode = false;
			LOG_W (("PackageManagerFactoryManagerSrv is in invalid (inactive) state"));
			throw CoreSrv::NoActiveFactory ();
		}
		GUARD (s_init_mutex);
		LOG_D (("Try to renew PackageManagerFactoryManagerSrv"));
		
		s_renew_mode = true;
		(*FactoryManagerSrvSingleton::instance()) = 0;
		PackageManager& ret = instance ();
		s_renew_mode = false;
		
		return ret;				
	}
}


} // namespace RosePackageLockingServer
} // namespace RosePackageLocking

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

