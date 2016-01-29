
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ServerGate/Comm/Comm.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<ServerInterfaces::Category>> MDProcess::ServerGate::Comm
//
// Коммуникационные иинтерфейсы для взаимодействия с внешними агентами
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ServerGate/Comm/Comm.h"
#include "MDProcess/ServerGate/LibHome.h"

namespace ServerGate {
namespace Comm {

Core::Mutex BuildListnerFactory::s_init_mutex;
bool BuildListnerFactory::s_renew_mode = false;
Core::Mutex BuildListnerFactory::s_mutex_for_get;
CORBA::ULong BuildListnerFactory::s_cached_object_hash_for_get = 0;


// возвращает зарегистрированный в системе "тестировщик сборок"
BuildListner& BuildListnerFactory::get () /*throw (CoreSrv::NoActiveFactory)*/ {
	if (FactoryManagerSrvSingleton::instance()->ptr() == 0) {
		GUARD (s_init_mutex);
		if (FactoryManagerSrvSingleton::instance()->ptr() == 0) {
			try {
				CORBA::Object_var obj = CoreSrv::resolve_path (&LibHomeFactory::get().get_orb_facet().get_ns_root(), "ServerGate::Comm::BuildListner");
				*FactoryManagerSrvSingleton::instance() = BuildListnerFactoryManagerSrv::_narrow (obj);
			} CATCH_AND_LOG ("COS Naming can't find FactoryManagerSrv for BuildListner");
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
			LOG_W (("BuildListnerFactoryManagerSrv is in invalid (inactive) state"));
			throw CoreSrv::NoActiveFactory ();
		}
		GUARD (s_init_mutex);
		LOG_D (("Try to renew BuildListnerFactoryManagerSrv"));
		
		s_renew_mode = true;
		(*FactoryManagerSrvSingleton::instance()) = 0;
		BuildListner& ret = get ();
		s_renew_mode = false;
		
		return ret;				
	} catch (CORBA::OBJECT_NOT_EXIST& ) {
		if (s_renew_mode) {
			s_renew_mode = false;
			LOG_W (("BuildListnerFactoryManagerSrv is in invalid (inactive) state"));
			throw CoreSrv::NoActiveFactory ();
		}
		GUARD (s_init_mutex);
		LOG_D (("Try to renew BuildListnerFactoryManagerSrv"));
		
		s_renew_mode = true;
		(*FactoryManagerSrvSingleton::instance()) = 0;
		BuildListner& ret = get ();
		s_renew_mode = false;
		
		return ret;				
	}
}


} // namespace Comm
} // namespace ServerGate

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

