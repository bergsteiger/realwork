////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/SearchAdapterLib/Adapter/AdapterFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garantCore::SearchAdapterLib::Adapter
//
// Интерфейсы и типы поискового адаптера
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_SEARCHADAPTERLIB_ADAPTER_FCTR_H__
#define __GARANTCORE_SEARCHADAPTERLIB_ADAPTER_FCTR_H__

#include "shared/Core/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "garantCore/SearchAdapterLib/Adapter/Adapter.h"

namespace SearchAdapterLib {
namespace Adapter {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for ISearcher

class ISearcherAbstractFactory;

/// factory manager for ISearcher
class ISearcherFactoryManager {
public:
	static void register_factory (ISearcherAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	ISearcherFactoryManager ();
	
	~ISearcherFactoryManager ();
	
	void register_factory_i (ISearcherAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	ISearcher* make (
		DBCore::IBase* base
		, Morpho::Def::ICache* cache
		, const std::string& src
	) /*throw (Core::Root::NoActiveFactory)*/;

	friend class ISearcherFactory;
	typedef ACE_Singleton <ISearcherFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <ISearcherFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<ISearcherAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<ISearcherAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for ISearcher
class ISearcherAbstractFactory : virtual public Core::IObject {
	friend class ISearcherFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual ISearcher* make (DBCore::IBase* base, Morpho::Def::ICache* cache, const std::string& src) = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for IHelper

class IHelperAbstractFactory;

/// factory manager for IHelper
class IHelperFactoryManager {
public:
	static void register_factory (IHelperAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	IHelperFactoryManager ();
	
	~IHelperFactoryManager ();
	
	void register_factory_i (IHelperAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	IHelper* make (Morpho::Def::ICache* cache) /*throw (Core::Root::NoActiveFactory)*/;

	friend class IHelperFactory;
	typedef ACE_Singleton <IHelperFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <IHelperFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<IHelperAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<IHelperAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for IHelper
class IHelperAbstractFactory : virtual public Core::IObject {
	friend class IHelperFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual IHelper* make (Morpho::Def::ICache* cache) = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for IAdapter

class IAdapterAbstractFactory;

/// factory manager for IAdapter
class IAdapterFactoryManager {
public:
	static void register_factory (IAdapterAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	IAdapterFactoryManager ();
	
	~IAdapterFactoryManager ();
	
	void register_factory_i (IAdapterAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	IAdapter& instance () /*throw (Core::Root::NoActiveFactory)*/;

	friend class IAdapterFactory;
	typedef ACE_Singleton <IAdapterFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <IAdapterFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<IAdapterAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<IAdapterAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;

	// for cached factory instance
	IAdapter_var m_cached_object_for_instance;

	Core::Mutex m_mutex_for_instance;
};

/// abstract factory for IAdapter
class IAdapterAbstractFactory : virtual public Core::IObject {
	friend class IAdapterFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual IAdapter* instance () = 0;
};

} // namespace Adapter
} // namespace SearchAdapterLib


#endif //__GARANTCORE_SEARCHADAPTERLIB_ADAPTER_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

