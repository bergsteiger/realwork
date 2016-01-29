////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/InternetSupport/InternetSupportFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::InternetSupport
//
// Возможности, доступные через интернет
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_INTERNETSUPPORT_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_INTERNETSUPPORT_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "garant6x/implementation/Garant/GblAdapterLib/InternetSupport/InternetSupport.h"

namespace GblAdapterLib {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for InternetSupport

class InternetSupportAbstractFactory;

/// factory manager for InternetSupport
class InternetSupportFactoryManager {
public:
	static void register_factory (InternetSupportAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	InternetSupportFactoryManager ();
	
	~InternetSupportFactoryManager ();
	
	void register_factory_i (InternetSupportAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	InternetSupport* make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class InternetSupportFactory;
	typedef ACE_Singleton <InternetSupportFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <InternetSupportFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<InternetSupportAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<InternetSupportAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for InternetSupport
class InternetSupportAbstractFactory : virtual public Core::IObject {
	friend class InternetSupportFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual InternetSupport* make () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for DecisionsArchiveSupport

class DecisionsArchiveSupportAbstractFactory;

/// factory manager for DecisionsArchiveSupport
class DecisionsArchiveSupportFactoryManager {
public:
	static void register_factory (DecisionsArchiveSupportAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	DecisionsArchiveSupportFactoryManager ();
	
	~DecisionsArchiveSupportFactoryManager ();
	
	void register_factory_i (DecisionsArchiveSupportAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	DecisionsArchiveSupport* make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class DecisionsArchiveSupportFactory;
	typedef ACE_Singleton <DecisionsArchiveSupportFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <DecisionsArchiveSupportFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<DecisionsArchiveSupportAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<DecisionsArchiveSupportAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for DecisionsArchiveSupport
class DecisionsArchiveSupportAbstractFactory : virtual public Core::IObject {
	friend class DecisionsArchiveSupportFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual DecisionsArchiveSupport* make () = 0;
};

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_INTERNETSUPPORT_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

