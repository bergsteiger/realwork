////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ServerGate/BuildSupport/BuildSupportFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<ServerInterfaces::Category>> MDProcess::ServerGate::BuildSupport
//
// Пакет серверных интерфейсов для создания сборок в К
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_SERVERGATE_BUILDSUPPORT_FCTR_H__
#define __MDPROCESS_SERVERGATE_BUILDSUPPORT_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "MDProcess/ServerGate/BuildSupport/BuildSupport.h"
#include "MDProcess/ServerGate/BuildSupport/BuildSupportS.h"

namespace ServerGate {
namespace BuildSupport {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for BuildManager

class BuildManagerAbstractFactory;

/// factory manager for BuildManager
class BuildManagerFactoryManager: virtual public POA_ServerGate::BuildSupport::BuildManagerFactoryManagerSrv {
public:
	static void register_factory (BuildManagerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

	static void publish_self ();

protected:
	BuildManagerFactoryManager ();
	
	~BuildManagerFactoryManager ();
	
	void register_factory_i (BuildManagerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	BuildManager* get () throw (CORBA::SystemException, CoreSrv::NoActiveFactory);

	friend class BuildManagerFactory;
	typedef ACE_Singleton <BuildManagerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <BuildManagerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<BuildManagerAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<BuildManagerAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;

	// for cached factory get
	BuildManager_var m_cached_object_for_get;

	Core::Mutex m_mutex_for_get;
};

/// abstract factory for BuildManager
class BuildManagerAbstractFactory : virtual public Core::IObject {
	friend class BuildManagerFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual BuildManager* get () = 0;
};

} // namespace BuildSupport
} // namespace ServerGate


#endif //__MDPROCESS_SERVERGATE_BUILDSUPPORT_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

