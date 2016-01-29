////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Notify/NotifyFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Notify
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_NOTIFY_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_NOTIFY_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Notify/Notify.h"

namespace GblAdapterLib {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for Notification

class NotificationAbstractFactory;

/// factory manager for Notification
class NotificationFactoryManager {
public:
	static void register_factory (NotificationAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	NotificationFactoryManager ();
	
	~NotificationFactoryManager ();
	
	void register_factory_i (NotificationAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	Notification* make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class NotificationFactory;
	typedef ACE_Singleton <NotificationFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <NotificationFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<NotificationAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<NotificationAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for Notification
class NotificationAbstractFactory : virtual public Core::IObject {
	friend class NotificationFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual Notification* make () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for NotifyManager

class NotifyManagerAbstractFactory;

/// factory manager for NotifyManager
class NotifyManagerFactoryManager {
public:
	static void register_factory (NotifyManagerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	NotifyManagerFactoryManager ();
	
	~NotifyManagerFactoryManager ();
	
	void register_factory_i (NotifyManagerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	NotifyManager& make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class NotifyManagerFactory;
	typedef ACE_Singleton <NotifyManagerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <NotifyManagerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<NotifyManagerAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<NotifyManagerAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;

	// for cached factory make
	NotifyManager_var m_cached_object_for_make;

	Core::Mutex m_mutex_for_make;
};

/// abstract factory for NotifyManager
class NotifyManagerAbstractFactory : virtual public Core::IObject {
	friend class NotifyManagerFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual NotifyManager* make () = 0;
};

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_NOTIFY_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

