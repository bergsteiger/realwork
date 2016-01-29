////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/CoreSrv/Security/SecurityFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Interfaces::Category>> shared::CoreSrv::Security
//
// сервисные локальные интерфейсы подсистемы безопасности
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORESRV_SECURITY_FCTR_H__
#define __SHARED_CORESRV_SECURITY_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "shared/CoreSrv/Security/Security.h"

namespace CoreSrv {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for Session

class SessionAbstractFactory;

/// factory manager for Session
class SessionFactoryManager {
public:
	static void register_factory (SessionAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	SessionFactoryManager ();
	
	~SessionFactoryManager ();
	
	void register_factory_i (SessionAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	Session& get () /*throw (Core::Root::NoActiveFactory)*/;

	friend class SessionFactory;
	typedef ACE_Singleton <SessionFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <SessionFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<SessionAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<SessionAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;

	// for cached factory get
	Session_var m_cached_object_for_get;

	Core::Mutex m_mutex_for_get;
};

/// abstract factory for Session
class SessionAbstractFactory : virtual public Core::IObject {
	friend class SessionFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual Session* get () = 0;
};

} // namespace CoreSrv


#endif //__SHARED_CORESRV_SECURITY_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

