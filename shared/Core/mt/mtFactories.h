////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/mt/mtFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Interfaces::Category>> shared::Core::mt
//
// работа с многопоточностью
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_MT_FCTR_H__
#define __SHARED_CORE_MT_FCTR_H__

#include "shared/Core/sys/core_std_inc.h"
#include "shared/Core/Root/Root.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "shared/Core/mt/mt.h"

namespace Core {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for ThreadPool

class ThreadPoolAbstractFactory;

/// factory manager for ThreadPool
class ThreadPoolFactoryManager {
public:
	static void register_factory (ThreadPoolAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	ThreadPoolFactoryManager ();
	
	~ThreadPoolFactoryManager ();
	
	void register_factory_i (ThreadPoolAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	ThreadPool& def () /*throw (Core::Root::NoActiveFactory)*/;

	ThreadPool* make (unsigned long pool_size) /*throw (Core::Root::NoActiveFactory)*/;

	friend class ThreadPoolFactory;
	typedef ACE_Singleton <ThreadPoolFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <ThreadPoolFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<ThreadPoolAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<ThreadPoolAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;

	// for cached factory def
	ThreadPool_var m_cached_object_for_def;

	Core::Mutex m_mutex_for_def;
};

/// abstract factory for ThreadPool
class ThreadPoolAbstractFactory : virtual public Core::IObject {
	friend class ThreadPoolFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual ThreadPool* def () = 0;

	virtual ThreadPool* make (unsigned long pool_size) = 0;
};

} // namespace Core


#endif //__SHARED_CORE_MT_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

