////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ServerGate/Comm/CommFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<ServerInterfaces::Category>> MDProcess::ServerGate::Comm
//
// Коммуникационные иинтерфейсы для взаимодействия с внешними агентами
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_SERVERGATE_COMM_FCTR_H__
#define __MDPROCESS_SERVERGATE_COMM_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "MDProcess/ServerGate/Comm/Comm.h"
#include "MDProcess/ServerGate/Comm/CommS.h"

namespace ServerGate {
namespace Comm {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for BuildListner

class BuildListnerAbstractFactory;

/// factory manager for BuildListner
class BuildListnerFactoryManager: virtual public POA_ServerGate::Comm::BuildListnerFactoryManagerSrv {
public:
	static void register_factory (BuildListnerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

	static void publish_self ();

protected:
	BuildListnerFactoryManager ();
	
	~BuildListnerFactoryManager ();
	
	void register_factory_i (BuildListnerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	BuildListner* get () throw (CORBA::SystemException, CoreSrv::NoActiveFactory);

	friend class BuildListnerFactory;
	typedef ACE_Singleton <BuildListnerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <BuildListnerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<BuildListnerAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<BuildListnerAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;

	// for cached factory get
	BuildListner_var m_cached_object_for_get;

	Core::Mutex m_mutex_for_get;
};

/// abstract factory for BuildListner
class BuildListnerAbstractFactory : virtual public Core::IObject {
	friend class BuildListnerFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual BuildListner* get () = 0;
};

} // namespace Comm
} // namespace ServerGate


#endif //__MDPROCESS_SERVERGATE_COMM_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

