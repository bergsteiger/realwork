////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Monitoring/MonitoringFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Monitoring
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_MONITORING_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_MONITORING_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Monitoring/Monitoring.h"

namespace GblAdapterLib {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for MonitoringList

class MonitoringListAbstractFactory;

/// factory manager for MonitoringList
class MonitoringListFactoryManager {
public:
	static void register_factory (MonitoringListAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	MonitoringListFactoryManager ();
	
	~MonitoringListFactoryManager ();
	
	void register_factory_i (MonitoringListAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	MonitoringList* make (
		GblDocList::DocListTree* server_list
		, unsigned long document_count
	) /*throw (Core::Root::NoActiveFactory)*/;

	friend class MonitoringListFactory;
	typedef ACE_Singleton <MonitoringListFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <MonitoringListFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<MonitoringListAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<MonitoringListAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for MonitoringList
class MonitoringListAbstractFactory : virtual public Core::IObject {
	friend class MonitoringListFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual MonitoringList* make (GblDocList::DocListTree* server_list, unsigned long document_count) = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for Monitoring

class MonitoringAbstractFactory;

/// factory manager for Monitoring
class MonitoringFactoryManager {
public:
	static void register_factory (MonitoringAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	MonitoringFactoryManager ();
	
	~MonitoringFactoryManager ();
	
	void register_factory_i (MonitoringAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	Monitoring* make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class MonitoringFactory;
	typedef ACE_Singleton <MonitoringFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <MonitoringFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<MonitoringAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<MonitoringAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for Monitoring
class MonitoringAbstractFactory : virtual public Core::IObject {
	friend class MonitoringFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual Monitoring* make () = 0;
};

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_MONITORING_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

