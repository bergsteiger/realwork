
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/CoreSrv/EventComm/EventComm.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<ServerInterfaces::Category>> shared::CoreSrv::EventComm
//
// коммуникационные распределенные типы и интерфейсы для подсистемы Событий
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORESRV_EVENTCOMM_H__
#define __SHARED_CORESRV_EVENTCOMM_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/CoreSrv/EventComm/EventCommC.h"
#include "orbsvcs/orbsvcs/RtecEventChannelAdminC.h"

namespace CoreSrv {
namespace EventComm {

/// factory interface for EventChannelManager
class EventChannelManagerFactory {
public:
	// фабрика для получения менеджера
	static EventChannelManager& get ()
		/*throw (CoreSrv::NoActiveFactory)*/;
private:
	typedef ACE_Singleton<EventChannelManagerFactoryManagerSrv_var, ACE_SYNCH_RECURSIVE_MUTEX> FactoryManagerSrvSingleton;
	static Core::Mutex s_init_mutex;
	static bool s_renew_mode;

	// for cached factory get
	typedef ACE_Singleton <EventChannelManager_var, ACE_SYNCH_RECURSIVE_MUTEX> CachedObjectForGet;
	static CORBA::ULong s_cached_object_hash_for_get;

	static Core::Mutex s_mutex_for_get;
};

} // namespace EventComm
} // namespace CoreSrv


#endif //__SHARED_CORESRV_EVENTCOMM_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

