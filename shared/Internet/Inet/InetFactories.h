////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Internet/Inet/InetFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Interfaces::Category>> shared::Internet::Inet
//
// Интерфейсы и типы для работы с интернет.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_INTERNET_INET_FCTR_H__
#define __SHARED_INTERNET_INET_FCTR_H__

#include "shared/Core/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "shared/Internet/Inet/Inet.h"

namespace Internet {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for IConnection

class IConnectionAbstractFactory;

/// factory manager for IConnection
class IConnectionFactoryManager {
public:
	static void register_factory (IConnectionAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	IConnectionFactoryManager ();
	
	~IConnectionFactoryManager ();
	
	void register_factory_i (IConnectionAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	IConnection* make (void* data, unsigned long flags) /*throw (Core::Root::NoActiveFactory)*/;

	friend class IConnectionFactory;
	typedef ACE_Singleton <IConnectionFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <IConnectionFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<IConnectionAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<IConnectionAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for IConnection
class IConnectionAbstractFactory : virtual public Core::IObject {
	friend class IConnectionFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual IConnection* make (void* data, unsigned long flags) = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for IConnect

class IConnectAbstractFactory;

/// factory manager for IConnect
class IConnectFactoryManager {
public:
	static void register_factory (IConnectAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	IConnectFactoryManager ();
	
	~IConnectFactoryManager ();
	
	void register_factory_i (IConnectAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	IConnect* make (const InternetAccessInfo& info) /*throw (Core::Root::NoActiveFactory)*/;

	friend class IConnectFactory;
	typedef ACE_Singleton <IConnectFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <IConnectFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<IConnectAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<IConnectAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for IConnect
class IConnectAbstractFactory : virtual public Core::IObject {
	friend class IConnectFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual IConnect* make (const InternetAccessInfo& info) = 0;
};

} // namespace Internet


#endif //__SHARED_INTERNET_INET_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

