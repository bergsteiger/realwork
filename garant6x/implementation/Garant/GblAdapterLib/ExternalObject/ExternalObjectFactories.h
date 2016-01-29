////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/ExternalObject/ExternalObjectFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::ExternalObject
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_EXTERNALOBJECT_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_EXTERNALOBJECT_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ExternalObject/ExternalObject.h"

namespace GblAdapterLib {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for ExternalLink

class ExternalLinkAbstractFactory;

/// factory manager for ExternalLink
class ExternalLinkFactoryManager {
public:
	static void register_factory (ExternalLinkAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	ExternalLinkFactoryManager ();
	
	~ExternalLinkFactoryManager ();
	
	void register_factory_i (ExternalLinkAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	ExternalLink* make (const char* url) /*throw (Core::Root::NoActiveFactory)*/;

	friend class ExternalLinkFactory;
	typedef ACE_Singleton <ExternalLinkFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <ExternalLinkFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<ExternalLinkAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<ExternalLinkAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for ExternalLink
class ExternalLinkAbstractFactory : virtual public Core::IObject {
	friend class ExternalLinkFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual ExternalLink* make (const char* url) = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for ExternalObject

class ExternalObjectAbstractFactory;

/// factory manager for ExternalObject
class ExternalObjectFactoryManager {
public:
	static void register_factory (ExternalObjectAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	ExternalObjectFactoryManager ();
	
	~ExternalObjectFactoryManager ();
	
	void register_factory_i (ExternalObjectAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	ExternalObject* make () /*throw (Core::Root::NoActiveFactory)*/;

	ExternalObject* make (GblPilot::InternalObj* obj) /*throw (Core::Root::NoActiveFactory)*/;

	friend class ExternalObjectFactory;
	typedef ACE_Singleton <ExternalObjectFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <ExternalObjectFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<ExternalObjectAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<ExternalObjectAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for ExternalObject
class ExternalObjectAbstractFactory : virtual public Core::IObject {
	friend class ExternalObjectFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual ExternalObject* make () = 0;

	virtual ExternalObject* make (GblPilot::InternalObj* obj) = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for SplashScreen

class SplashScreenAbstractFactory;

/// factory manager for SplashScreen
class SplashScreenFactoryManager {
public:
	static void register_factory (SplashScreenAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	SplashScreenFactoryManager ();
	
	~SplashScreenFactoryManager ();
	
	void register_factory_i (SplashScreenAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	SplashScreen* make (
		bool is_start
		, short x
		, short y
		, bool flash_available
	) /*throw (Core::Root::NoActiveFactory, CanNotFindData)*/;

	friend class SplashScreenFactory;
	typedef ACE_Singleton <SplashScreenFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <SplashScreenFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<SplashScreenAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<SplashScreenAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for SplashScreen
class SplashScreenAbstractFactory : virtual public Core::IObject {
	friend class SplashScreenFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual SplashScreen* make (bool is_start, short x, short y, bool flash_available) /*throw (CanNotFindData)*/ = 0;
};

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_EXTERNALOBJECT_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

