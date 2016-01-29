////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ArchiAdapterLib/Gardocs/GardocsFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Interfaces::Category>> MDProcess::ArchiAdapterLib::Gardocs
//
// Gardoc
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_ARCHIADAPTERLIB_GARDOCS_FCTR_H__
#define __MDPROCESS_ARCHIADAPTERLIB_GARDOCS_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "MDProcess/ArchiAdapterLib/Gardocs/Gardocs.h"

namespace ArchiAdapterLib {
namespace Gardocs {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for Searcher

class SearcherAbstractFactory;

/// factory manager for Searcher
class SearcherFactoryManager {
public:
	static void register_factory (SearcherAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	SearcherFactoryManager ();
	
	~SearcherFactoryManager ();
	
	void register_factory_i (SearcherAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	Searcher& get () /*throw (Core::Root::NoActiveFactory)*/;

	friend class SearcherFactory;
	typedef ACE_Singleton <SearcherFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <SearcherFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<SearcherAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<SearcherAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;

	// for cached factory get
	Searcher_var m_cached_object_for_get;

	Core::Mutex m_mutex_for_get;
};

/// abstract factory for Searcher
class SearcherAbstractFactory : virtual public Core::IObject {
	friend class SearcherFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual Searcher* get () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for ArchiEventsListener

class ArchiEventsListenerAbstractFactory;

/// factory manager for ArchiEventsListener
class ArchiEventsListenerFactoryManager {
public:
	static void register_factory (ArchiEventsListenerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	ArchiEventsListenerFactoryManager ();
	
	~ArchiEventsListenerFactoryManager ();
	
	void register_factory_i (ArchiEventsListenerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	ArchiEventsListener& get () /*throw (Core::Root::NoActiveFactory)*/;

	friend class ArchiEventsListenerFactory;
	typedef ACE_Singleton <ArchiEventsListenerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <ArchiEventsListenerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<ArchiEventsListenerAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<ArchiEventsListenerAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;

	// for cached factory get
	ArchiEventsListener_var m_cached_object_for_get;

	Core::Mutex m_mutex_for_get;
};

/// abstract factory for ArchiEventsListener
class ArchiEventsListenerAbstractFactory : virtual public Core::IObject {
	friend class ArchiEventsListenerFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual ArchiEventsListener* get () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for Searcher2

class Searcher2AbstractFactory;

/// factory manager for Searcher2
class Searcher2FactoryManager {
public:
	static void register_factory (Searcher2AbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	Searcher2FactoryManager ();
	
	~Searcher2FactoryManager ();
	
	void register_factory_i (Searcher2AbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	Searcher2* get () /*throw (Core::Root::NoActiveFactory)*/;

	friend class Searcher2Factory;
	typedef ACE_Singleton <Searcher2FactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <Searcher2FactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<Searcher2AbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<Searcher2AbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for Searcher2
class Searcher2AbstractFactory : virtual public Core::IObject {
	friend class Searcher2FactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual Searcher2* get () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for Utils

class UtilsAbstractFactory;

/// factory manager for Utils
class UtilsFactoryManager {
public:
	static void register_factory (UtilsAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	UtilsFactoryManager ();
	
	~UtilsFactoryManager ();
	
	void register_factory_i (UtilsAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	Utils* get () /*throw (Core::Root::NoActiveFactory)*/;

	friend class UtilsFactory;
	typedef ACE_Singleton <UtilsFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <UtilsFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<UtilsAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<UtilsAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for Utils
class UtilsAbstractFactory : virtual public Core::IObject {
	friend class UtilsFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual Utils* get () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for GardocGetter

class GardocGetterAbstractFactory;

/// factory manager for GardocGetter
class GardocGetterFactoryManager {
public:
	static void register_factory (GardocGetterAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	GardocGetterFactoryManager ();
	
	~GardocGetterFactoryManager ();
	
	void register_factory_i (GardocGetterAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	GardocGetter* get () /*throw (Core::Root::NoActiveFactory)*/;

	friend class GardocGetterFactory;
	typedef ACE_Singleton <GardocGetterFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <GardocGetterFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<GardocGetterAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<GardocGetterAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for GardocGetter
class GardocGetterAbstractFactory : virtual public Core::IObject {
	friend class GardocGetterFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual GardocGetter* get () = 0;
};

} // namespace Gardocs
} // namespace ArchiAdapterLib


#endif //__MDPROCESS_ARCHIADAPTERLIB_GARDOCS_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

