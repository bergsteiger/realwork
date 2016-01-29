////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/DynamicTreeLocalInterface/DynamicTreeLocalInterfaceFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::DynamicTreeLocalInterface
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREELOCALINTERFACE_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREELOCALINTERFACE_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTreeLocalInterface/DynamicTreeLocalInterface.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTreeFactories.h"

namespace GblAdapterLib {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for QueryFilter

class QueryFilterAbstractFactory;

/// factory manager for QueryFilter
class QueryFilterFactoryManager {
public:
	static void register_factory (QueryFilterAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	QueryFilterFactoryManager ();
	
	~QueryFilterFactoryManager ();
	
	void register_factory_i (QueryFilterAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	QueryFilter* make (FilterFromQuery* data) /*throw (Core::Root::NoActiveFactory)*/;

	QueryFilter* make (FiltersFromQuery& data) /*throw (Core::Root::NoActiveFactory)*/;

	QueryFilter* make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class QueryFilterFactory;
	typedef ACE_Singleton <QueryFilterFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <QueryFilterFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<QueryFilterAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<QueryFilterAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for QueryFilter
class QueryFilterAbstractFactory : virtual public Core::IObject {
	friend class QueryFilterFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual QueryFilter* make (FilterFromQuery* data) = 0;

	virtual QueryFilter* make (FiltersFromQuery& data) = 0;

	virtual QueryFilter* make () = 0;
};

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREELOCALINTERFACE_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

