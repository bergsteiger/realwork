////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Profile/ProfileFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Profile
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_PROFILE_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_PROFILE_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Profile/Profile.h"

namespace GblAdapterLib {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for StopWatch

class StopWatchAbstractFactory;

/// factory manager for StopWatch
class StopWatchFactoryManager {
public:
	static void register_factory (StopWatchAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	StopWatchFactoryManager ();
	
	~StopWatchFactoryManager ();
	
	void register_factory_i (StopWatchAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	StopWatch* make (const char* context) /*throw (Core::Root::NoActiveFactory)*/;

	friend class StopWatchFactory;
	typedef ACE_Singleton <StopWatchFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <StopWatchFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<StopWatchAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<StopWatchAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for StopWatch
class StopWatchAbstractFactory : virtual public Core::IObject {
	friend class StopWatchFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual StopWatch* make (const char* context) = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for StopWatchEx

class StopWatchExAbstractFactory;

/// factory manager for StopWatchEx
class StopWatchExFactoryManager {
public:
	static void register_factory (StopWatchExAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	StopWatchExFactoryManager ();
	
	~StopWatchExFactoryManager ();
	
	void register_factory_i (StopWatchExAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	StopWatchEx* make (const char* id, const char* context) /*throw (Core::Root::NoActiveFactory)*/;

	friend class StopWatchExFactory;
	typedef ACE_Singleton <StopWatchExFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <StopWatchExFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<StopWatchExAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<StopWatchExAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for StopWatchEx
class StopWatchExAbstractFactory : virtual public Core::IObject {
	friend class StopWatchExFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual StopWatchEx* make (const char* id, const char* context) = 0;
};

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_PROFILE_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

