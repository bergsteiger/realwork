
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/CoreSrv/EventComm/EventComm.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<ServerInterfaces::Category>> shared::CoreSrv::EventComm
//
// коммуникационные распределенные типы и интерфейсы для подсистемы Событий
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/CoreSrv/EventComm/EventComm.h"
#include "shared/CoreSrv/LibHome.h"

namespace CoreSrv {
namespace EventComm {

Core::Mutex EventChannelManagerFactory::s_init_mutex;
bool EventChannelManagerFactory::s_renew_mode = false;
Core::Mutex EventChannelManagerFactory::s_mutex_for_get;
CORBA::ULong EventChannelManagerFactory::s_cached_object_hash_for_get = 0;


// фабрика для получения менеджера
EventChannelManager& EventChannelManagerFactory::get () /*throw (CoreSrv::NoActiveFactory)*/ {
	if (FactoryManagerSrvSingleton::instance()->ptr() == 0) {
		GUARD (s_init_mutex);
		if (FactoryManagerSrvSingleton::instance()->ptr() == 0) {
			try {
				CORBA::Object_var obj = CoreSrv::resolve_path (&LibHomeFactory::get().get_orb_facet().get_ns_root(), "CoreSrv::EventComm::EventChannelManager");
				*FactoryManagerSrvSingleton::instance() = EventChannelManagerFactoryManagerSrv::_narrow (obj);
			} CATCH_AND_LOG ("COS Naming can't find FactoryManagerSrv for EventChannelManager");
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
			LOG_W (("EventChannelManagerFactoryManagerSrv is in invalid (inactive) state"));
			throw CoreSrv::NoActiveFactory ();
		}
		GUARD (s_init_mutex);
		LOG_D (("Try to renew EventChannelManagerFactoryManagerSrv"));
		
		s_renew_mode = true;
		(*FactoryManagerSrvSingleton::instance()) = 0;
		EventChannelManager& ret = get ();
		s_renew_mode = false;
		
		return ret;
	}
}


} // namespace EventComm
} // namespace CoreSrv

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

