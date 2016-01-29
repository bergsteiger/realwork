////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Complect/ComplectFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Complect
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_COMPLECT_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_COMPLECT_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Complect/Complect.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTreeFactories.h"

namespace GblAdapterLib {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for ComplectInfoNode

class ComplectInfoNodeAbstractFactory;

/// factory manager for ComplectInfoNode
class ComplectInfoNodeFactoryManager {
public:
	static void register_factory (ComplectInfoNodeAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	ComplectInfoNodeFactoryManager ();
	
	~ComplectInfoNodeFactoryManager ();
	
	void register_factory_i (ComplectInfoNodeAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	ComplectInfoNode* make (
		FakeFacetForFactory* owner_tree
		, const GTree::Node& snode
	) /*throw (Core::Root::NoActiveFactory)*/;

	friend class ComplectInfoNodeFactory;
	typedef ACE_Singleton <ComplectInfoNodeFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <ComplectInfoNodeFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<ComplectInfoNodeAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<ComplectInfoNodeAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for ComplectInfoNode
class ComplectInfoNodeAbstractFactory : virtual public Core::IObject {
	friend class ComplectInfoNodeFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual ComplectInfoNode* make (FakeFacetForFactory* owner_tree, const GTree::Node& snode) = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for ComplectInfo

class ComplectInfoAbstractFactory;

/// factory manager for ComplectInfo
class ComplectInfoFactoryManager {
public:
	static void register_factory (ComplectInfoAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	ComplectInfoFactoryManager ();
	
	~ComplectInfoFactoryManager ();
	
	void register_factory_i (ComplectInfoAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	ComplectInfo* make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class ComplectInfoFactory;
	typedef ACE_Singleton <ComplectInfoFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <ComplectInfoFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<ComplectInfoAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<ComplectInfoAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for ComplectInfo
class ComplectInfoAbstractFactory : virtual public Core::IObject {
	friend class ComplectInfoFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual ComplectInfo* make () = 0;
};

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_COMPLECT_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

