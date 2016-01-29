////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/CoreSrv/EventComm/EventCommFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<ServerInterfaces::Category>> shared::CoreSrv::EventComm
//
// коммуникационные распределенные типы и интерфейсы для подсистемы Событий
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORESRV_EVENTCOMM_FCTR_H__
#define __SHARED_CORESRV_EVENTCOMM_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "shared/CoreSrv/EventComm/EventComm.h"
#include "shared/CoreSrv/EventComm/EventCommS.h"

namespace CoreSrv {
namespace EventComm {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for EventChannelManager

class EventChannelManagerAbstractFactory;

/// factory manager for EventChannelManager
class EventChannelManagerFactoryManager: virtual public POA_CoreSrv::EventComm::EventChannelManagerFactoryManagerSrv {
public:
	static void register_factory (EventChannelManagerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

	static void publish_self ();

protected:
	EventChannelManagerFactoryManager ();
	
	~EventChannelManagerFactoryManager ();
	
	void register_factory_i (EventChannelManagerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	EventChannelManager* get () throw (CORBA::SystemException, CoreSrv::NoActiveFactory);

	friend class EventChannelManagerFactory;
	typedef ACE_Singleton <EventChannelManagerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <EventChannelManagerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<EventChannelManagerAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<EventChannelManagerAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;

	// for cached factory get
	EventChannelManager_var m_cached_object_for_get;

	Core::Mutex m_mutex_for_get;
};

/// abstract factory for EventChannelManager
class EventChannelManagerAbstractFactory : virtual public Core::IObject {
	friend class EventChannelManagerFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual EventChannelManager* get () = 0;
};

} // namespace EventComm
} // namespace CoreSrv


#endif //__SHARED_CORESRV_EVENTCOMM_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

