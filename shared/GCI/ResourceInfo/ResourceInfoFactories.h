////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/ResourceInfo/ResourceInfoFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Interfaces::Category>> shared::GCI::ResourceInfo
//
// набор интерфейсов для предоставления информации о системе
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCI_RESOURCEINFO_FCTR_H__
#define __SHARED_GCI_RESOURCEINFO_FCTR_H__

#include "shared/Core/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "shared/GCI/ResourceInfo/ResourceInfo.h"

namespace GCI {
namespace ResourceInfo {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for CPUInfo

class CPUInfoAbstractFactory;

/// factory manager for CPUInfo
class CPUInfoFactoryManager {
public:
	static void register_factory (CPUInfoAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	CPUInfoFactoryManager ();
	
	~CPUInfoFactoryManager ();
	
	void register_factory_i (CPUInfoAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	CPUInfo& get () /*throw (Core::Root::NoActiveFactory, NotSupported)*/;

	friend class CPUInfoFactory;
	typedef ACE_Singleton <CPUInfoFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <CPUInfoFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<CPUInfoAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<CPUInfoAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;

	// for cached factory get
	CPUInfo_var m_cached_object_for_get;

	Core::Mutex m_mutex_for_get;
};

/// abstract factory for CPUInfo
class CPUInfoAbstractFactory : virtual public Core::IObject {
	friend class CPUInfoFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual CPUInfo* get () /*throw (NotSupported)*/ = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for ProcessMemoryInfo

class ProcessMemoryInfoAbstractFactory;

/// factory manager for ProcessMemoryInfo
class ProcessMemoryInfoFactoryManager {
public:
	static void register_factory (ProcessMemoryInfoAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	ProcessMemoryInfoFactoryManager ();
	
	~ProcessMemoryInfoFactoryManager ();
	
	void register_factory_i (ProcessMemoryInfoAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	ProcessMemoryInfo& get () /*throw (Core::Root::NoActiveFactory, NotSupported)*/;

	friend class ProcessMemoryInfoFactory;
	typedef ACE_Singleton <ProcessMemoryInfoFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <ProcessMemoryInfoFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<ProcessMemoryInfoAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<ProcessMemoryInfoAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;

	// for cached factory get
	ProcessMemoryInfo_var m_cached_object_for_get;

	Core::Mutex m_mutex_for_get;
};

/// abstract factory for ProcessMemoryInfo
class ProcessMemoryInfoAbstractFactory : virtual public Core::IObject {
	friend class ProcessMemoryInfoFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual ProcessMemoryInfo* get () /*throw (NotSupported)*/ = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for PhysicalMemoryInfo

class PhysicalMemoryInfoAbstractFactory;

/// factory manager for PhysicalMemoryInfo
class PhysicalMemoryInfoFactoryManager {
public:
	static void register_factory (PhysicalMemoryInfoAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	PhysicalMemoryInfoFactoryManager ();
	
	~PhysicalMemoryInfoFactoryManager ();
	
	void register_factory_i (PhysicalMemoryInfoAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	PhysicalMemoryInfo& get () /*throw (Core::Root::NoActiveFactory, NotSupported)*/;

	friend class PhysicalMemoryInfoFactory;
	typedef ACE_Singleton <PhysicalMemoryInfoFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <PhysicalMemoryInfoFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<PhysicalMemoryInfoAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<PhysicalMemoryInfoAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;

	// for cached factory get
	PhysicalMemoryInfo_var m_cached_object_for_get;

	Core::Mutex m_mutex_for_get;
};

/// abstract factory for PhysicalMemoryInfo
class PhysicalMemoryInfoAbstractFactory : virtual public Core::IObject {
	friend class PhysicalMemoryInfoFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual PhysicalMemoryInfo* get () /*throw (NotSupported)*/ = 0;
};

} // namespace ResourceInfo
} // namespace GCI


#endif //__SHARED_GCI_RESOURCEINFO_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

