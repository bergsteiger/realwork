////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/CoreSrv/SecurityComm/SecurityCommFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Interfaces::Category>> shared::CoreSrv::SecurityComm
//
// коммуникационные локальные интерфейсы и типы ддля подсистемы Безопасности
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORESRV_SECURITYCOMM_FCTR_H__
#define __SHARED_CORESRV_SECURITYCOMM_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "shared/CoreSrv/SecurityComm/SecurityComm.h"

namespace CoreSrv {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for Authenticator

class AuthenticatorAbstractFactory;

/// factory manager for Authenticator
class AuthenticatorFactoryManager {
public:
	static void register_factory (AuthenticatorAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	AuthenticatorFactoryManager ();
	
	~AuthenticatorFactoryManager ();
	
	void register_factory_i (AuthenticatorAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	Authenticator& get () /*throw (Core::Root::NoActiveFactory)*/;

	friend class AuthenticatorFactory;
	typedef ACE_Singleton <AuthenticatorFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <AuthenticatorFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<AuthenticatorAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<AuthenticatorAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;

	// for cached factory get
	Authenticator_var m_cached_object_for_get;

	Core::Mutex m_mutex_for_get;
};

/// abstract factory for Authenticator
class AuthenticatorAbstractFactory : virtual public Core::IObject {
	friend class AuthenticatorFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual Authenticator* get () = 0;
};

} // namespace CoreSrv


#endif //__SHARED_CORESRV_SECURITYCOMM_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

