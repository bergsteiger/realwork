////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/MDPSupport/MDPSupportFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Interfaces::Category>> MDProcess::MDAModel::MDPSupport
//
// интерфейсы для  работы с сервером залочек
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_MDPSUPPORT_FCTR_H__
#define __MDPROCESS_MDAMODEL_MDPSUPPORT_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "MDProcess/MDAModel/MDPSupport/MDPSupport.h"

namespace MDPSupport {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for CatLocker

class CatLockerAbstractFactory;

/// factory manager for CatLocker
class CatLockerFactoryManager {
public:
	static void register_factory (CatLockerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	CatLockerFactoryManager ();
	
	~CatLockerFactoryManager ();
	
	void register_factory_i (CatLockerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	CatLocker* make (IRoseCategoryPtr cat) /*throw (Core::Root::NoActiveFactory)*/;

	friend class CatLockerFactory;
	typedef ACE_Singleton <CatLockerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <CatLockerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<CatLockerAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<CatLockerAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for CatLocker
class CatLockerAbstractFactory : virtual public Core::IObject {
	friend class CatLockerFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual CatLocker* make (IRoseCategoryPtr cat) = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for MDPFacade

class MDPFacadeAbstractFactory;

/// factory manager for MDPFacade
class MDPFacadeFactoryManager {
public:
	static void register_factory (MDPFacadeAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	MDPFacadeFactoryManager ();
	
	~MDPFacadeFactoryManager ();
	
	void register_factory_i (MDPFacadeAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	MDPFacade& get () /*throw (Core::Root::NoActiveFactory)*/;

	friend class MDPFacadeFactory;
	typedef ACE_Singleton <MDPFacadeFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <MDPFacadeFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<MDPFacadeAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<MDPFacadeAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;

	// for cached factory get
	MDPFacade_var m_cached_object_for_get;

	Core::Mutex m_mutex_for_get;
};

/// abstract factory for MDPFacade
class MDPFacadeAbstractFactory : virtual public Core::IObject {
	friend class MDPFacadeFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual MDPFacade* get () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for CatLockerFacade

class CatLockerFacadeAbstractFactory;

/// factory manager for CatLockerFacade
class CatLockerFacadeFactoryManager {
public:
	static void register_factory (CatLockerFacadeAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	CatLockerFacadeFactoryManager ();
	
	~CatLockerFacadeFactoryManager ();
	
	void register_factory_i (CatLockerFacadeAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	CatLockerFacade* make (IRoseCategoryPtr cat) /*throw (Core::Root::NoActiveFactory)*/;

	CatLockerFacade* make (IRoseElementPtr elem) /*throw (Core::Root::NoActiveFactory)*/;

	friend class CatLockerFacadeFactory;
	typedef ACE_Singleton <CatLockerFacadeFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <CatLockerFacadeFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<CatLockerFacadeAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<CatLockerFacadeAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for CatLockerFacade
class CatLockerFacadeAbstractFactory : virtual public Core::IObject {
	friend class CatLockerFacadeFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual CatLockerFacade* make (IRoseCategoryPtr cat) = 0;

	virtual CatLockerFacade* make (IRoseElementPtr elem) = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for CatsContainer

class CatsContainerAbstractFactory;

/// factory manager for CatsContainer
class CatsContainerFactoryManager {
public:
	static void register_factory (CatsContainerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	CatsContainerFactoryManager ();
	
	~CatsContainerFactoryManager ();
	
	void register_factory_i (CatsContainerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	CatsContainer& get () /*throw (Core::Root::NoActiveFactory)*/;

	friend class CatsContainerFactory;
	typedef ACE_Singleton <CatsContainerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <CatsContainerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<CatsContainerAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<CatsContainerAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;

	// for cached factory get
	CatsContainer_var m_cached_object_for_get;

	Core::Mutex m_mutex_for_get;
};

/// abstract factory for CatsContainer
class CatsContainerAbstractFactory : virtual public Core::IObject {
	friend class CatsContainerFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual CatsContainer* get () = 0;
};

} // namespace MDPSupport


#endif //__MDPROCESS_MDAMODEL_MDPSUPPORT_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

