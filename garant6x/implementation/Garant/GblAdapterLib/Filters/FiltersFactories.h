////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Filters/FiltersFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Filters
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_FILTERS_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_FILTERS_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Filters/Filters.h"

namespace GblAdapterLib {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for FilterFromQuery

class FilterFromQueryAbstractFactory;

/// factory manager for FilterFromQuery
class FilterFromQueryFactoryManager {
public:
	static void register_factory (FilterFromQueryAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	FilterFromQueryFactoryManager ();
	
	~FilterFromQueryFactoryManager ();
	
	void register_factory_i (FilterFromQueryAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	FilterFromQuery* make (const GblFilters::Filter& filter) /*throw (Core::Root::NoActiveFactory)*/;

	friend class FilterFromQueryFactory;
	typedef ACE_Singleton <FilterFromQueryFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <FilterFromQueryFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<FilterFromQueryAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<FilterFromQueryAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for FilterFromQuery
class FilterFromQueryAbstractFactory : virtual public Core::IObject {
	friend class FilterFromQueryFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual FilterFromQuery* make (const GblFilters::Filter& filter) = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for FiltersManager

class FiltersManagerAbstractFactory;

/// factory manager for FiltersManager
class FiltersManagerFactoryManager {
public:
	static void register_factory (FiltersManagerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	FiltersManagerFactoryManager ();
	
	~FiltersManagerFactoryManager ();
	
	void register_factory_i (FiltersManagerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	FiltersManager* make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class FiltersManagerFactory;
	typedef ACE_Singleton <FiltersManagerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <FiltersManagerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<FiltersManagerAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<FiltersManagerAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for FiltersManager
class FiltersManagerAbstractFactory : virtual public Core::IObject {
	friend class FiltersManagerFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual FiltersManager* make () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for FiltersUsageCounter

class FiltersUsageCounterAbstractFactory;

/// factory manager for FiltersUsageCounter
class FiltersUsageCounterFactoryManager {
public:
	static void register_factory (FiltersUsageCounterAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	FiltersUsageCounterFactoryManager ();
	
	~FiltersUsageCounterFactoryManager ();
	
	void register_factory_i (FiltersUsageCounterAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	FiltersUsageCounter* make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class FiltersUsageCounterFactory;
	typedef ACE_Singleton <FiltersUsageCounterFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <FiltersUsageCounterFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<FiltersUsageCounterAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<FiltersUsageCounterAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for FiltersUsageCounter
class FiltersUsageCounterAbstractFactory : virtual public Core::IObject {
	friend class FiltersUsageCounterFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual FiltersUsageCounter* make () = 0;
};

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_FILTERS_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

