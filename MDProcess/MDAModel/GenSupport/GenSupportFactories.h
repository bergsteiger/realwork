////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/GenSupport/GenSupportFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Interfaces::Category>> MDProcess::MDAModel::GenSupport
//
// вспомогательные интерфейсы для генерации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_GENSUPPORT_FCTR_H__
#define __MDPROCESS_MDAMODEL_GENSUPPORT_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "MDProcess/MDAModel/GenSupport/GenSupport.h"

namespace GenSupport {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for ProgessIndicatorService

class ProgessIndicatorServiceAbstractFactory;

/// factory manager for ProgessIndicatorService
class ProgessIndicatorServiceFactoryManager {
public:
	static void register_factory (ProgessIndicatorServiceAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	ProgessIndicatorServiceFactoryManager ();
	
	~ProgessIndicatorServiceFactoryManager ();
	
	void register_factory_i (ProgessIndicatorServiceAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	ProgessIndicatorService& get () /*throw (Core::Root::NoActiveFactory)*/;

	friend class ProgessIndicatorServiceFactory;
	typedef ACE_Singleton <ProgessIndicatorServiceFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <ProgessIndicatorServiceFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<ProgessIndicatorServiceAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<ProgessIndicatorServiceAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;

	// for cached factory get
	ProgessIndicatorService_var m_cached_object_for_get;

	Core::Mutex m_mutex_for_get;
};

/// abstract factory for ProgessIndicatorService
class ProgessIndicatorServiceAbstractFactory : virtual public Core::IObject {
	friend class ProgessIndicatorServiceFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual ProgessIndicatorService* get () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for PageProxy

class PageProxyAbstractFactory;

/// factory manager for PageProxy
class PageProxyFactoryManager {
public:
	static void register_factory (PageProxyAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	PageProxyFactoryManager ();
	
	~PageProxyFactoryManager ();
	
	void register_factory_i (PageProxyAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	PageProxy& get (
		ServerGate::GenerationContents::ModelElementId_const page_guid
	) /*throw (Core::Root::NoActiveFactory)*/;

	friend class PageProxyFactory;
	typedef ACE_Singleton <PageProxyFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <PageProxyFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<PageProxyAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<PageProxyAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;

	// for cached factory get
	struct ObjectCreationIdForGet {
		std::string page_guid_arg;

		ObjectCreationIdForGet (ServerGate::GenerationContents::ModelElementId_const page_guid) : page_guid_arg (page_guid) {
		}

		bool operator < (const ObjectCreationIdForGet& c) const {
			return page_guid_arg < c.page_guid_arg;
		}
	};

	typedef std::map<ObjectCreationIdForGet, PageProxy_var> CachedObjectsForGet;
	typedef std::map<const PageProxy*, CachedObjectsForGet::iterator> CachedObjectsIndexForGet;
	CachedObjectsForGet m_cached_objects_for_get;
	CachedObjectsIndexForGet m_cached_objects_index_for_get;

	Core::Mutex m_mutex_for_get;
};

/// abstract factory for PageProxy
class PageProxyAbstractFactory : virtual public Core::IObject {
	friend class PageProxyFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual PageProxy* get (ServerGate::GenerationContents::ModelElementId_const page_guid) = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for LogManager

class LogManagerAbstractFactory;

/// factory manager for LogManager
class LogManagerFactoryManager {
public:
	static void register_factory (LogManagerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	LogManagerFactoryManager ();
	
	~LogManagerFactoryManager ();
	
	void register_factory_i (LogManagerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	LogManager& get () /*throw (Core::Root::NoActiveFactory)*/;

	friend class LogManagerFactory;
	typedef ACE_Singleton <LogManagerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <LogManagerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<LogManagerAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<LogManagerAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;

	// for cached factory get
	LogManager_var m_cached_object_for_get;

	Core::Mutex m_mutex_for_get;
};

/// abstract factory for LogManager
class LogManagerAbstractFactory : virtual public Core::IObject {
	friend class LogManagerFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual LogManager* get () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for ErrorManager

class ErrorManagerAbstractFactory;

/// factory manager for ErrorManager
class ErrorManagerFactoryManager {
public:
	static void register_factory (ErrorManagerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	ErrorManagerFactoryManager ();
	
	~ErrorManagerFactoryManager ();
	
	void register_factory_i (ErrorManagerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	ErrorManager& get () /*throw (Core::Root::NoActiveFactory)*/;

	friend class ErrorManagerFactory;
	typedef ACE_Singleton <ErrorManagerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <ErrorManagerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<ErrorManagerAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<ErrorManagerAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;

	// for cached factory get
	ErrorManager_var m_cached_object_for_get;

	Core::Mutex m_mutex_for_get;
};

/// abstract factory for ErrorManager
class ErrorManagerAbstractFactory : virtual public Core::IObject {
	friend class ErrorManagerFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual ErrorManager* get () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for Environment

class EnvironmentAbstractFactory;

/// factory manager for Environment
class EnvironmentFactoryManager {
public:
	static void register_factory (EnvironmentAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	EnvironmentFactoryManager ();
	
	~EnvironmentFactoryManager ();
	
	void register_factory_i (EnvironmentAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	Environment& get () /*throw (Core::Root::NoActiveFactory)*/;

	friend class EnvironmentFactory;
	typedef ACE_Singleton <EnvironmentFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <EnvironmentFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<EnvironmentAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<EnvironmentAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;

	// for cached factory get
	Environment_var m_cached_object_for_get;

	Core::Mutex m_mutex_for_get;
};

/// abstract factory for Environment
class EnvironmentAbstractFactory : virtual public Core::IObject {
	friend class EnvironmentFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual Environment* get () = 0;
};

} // namespace GenSupport


#endif //__MDPROCESS_MDAMODEL_GENSUPPORT_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

