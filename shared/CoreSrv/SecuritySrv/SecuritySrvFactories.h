////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/CoreSrv/SecuritySrv/SecuritySrvFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<ServerInterfaces::Category>> shared::CoreSrv::SecuritySrv
//
// сервисные распределенные интерфейсы подсистемы Безопасности
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORESRV_SECURITYSRV_FCTR_H__
#define __SHARED_CORESRV_SECURITYSRV_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "shared/CoreSrv/SecuritySrv/SecuritySrv.h"
#include "shared/CoreSrv/SecuritySrv/SecuritySrvS.h"

namespace CoreSrv {
namespace SecuritySrv {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for SessionManager

class SessionManagerAbstractFactory;

/// factory manager for SessionManager
class SessionManagerFactoryManager: virtual public POA_CoreSrv::SecuritySrv::SessionManagerFactoryManagerSrv {
public:
	static void register_factory (SessionManagerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

	static void publish_self ();

protected:
	SessionManagerFactoryManager ();
	
	~SessionManagerFactoryManager ();
	
	void register_factory_i (SessionManagerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	SessionManager* get () throw (CORBA::SystemException, CoreSrv::NoActiveFactory);

	friend class SessionManagerFactory;
	typedef ACE_Singleton <SessionManagerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <SessionManagerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<SessionManagerAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<SessionManagerAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;

	// for cached factory get
	SessionManager_var m_cached_object_for_get;

	Core::Mutex m_mutex_for_get;
};

/// abstract factory for SessionManager
class SessionManagerAbstractFactory : virtual public Core::IObject {
	friend class SessionManagerFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual SessionManager* get () = 0;
};

} // namespace SecuritySrv
} // namespace CoreSrv


#endif //__SHARED_CORESRV_SECURITYSRV_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

