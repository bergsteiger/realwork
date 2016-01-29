////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/PrefixTree/PrefixTreeFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::PrefixTree
//
// Дерево для Вид правовой информации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_PREFIXTREE_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_PREFIXTREE_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "garant6x/implementation/Garant/GblAdapterLib/PrefixTree/PrefixTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTreeFactories.h"

namespace GblAdapterLib {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for PrefixNode

class PrefixNodeAbstractFactory;

/// factory manager for PrefixNode
class PrefixNodeFactoryManager {
public:
	static void register_factory (PrefixNodeAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	PrefixNodeFactoryManager ();
	
	~PrefixNodeFactoryManager ();
	
	void register_factory_i (PrefixNodeAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	PrefixNode* make () /*throw (Core::Root::NoActiveFactory, CanNotFindData)*/;

	PrefixNode* make (FakeFacetForFactory* owner_tree, const GTree::Node& snode) /*throw (Core::Root::NoActiveFactory)*/;

	friend class PrefixNodeFactory;
	typedef ACE_Singleton <PrefixNodeFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <PrefixNodeFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<PrefixNodeAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<PrefixNodeAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for PrefixNode
class PrefixNodeAbstractFactory : virtual public Core::IObject {
	friend class PrefixNodeFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual PrefixNode* make () /*throw (CanNotFindData)*/ = 0;

	virtual PrefixNode* make (FakeFacetForFactory* owner_tree, const GTree::Node& snode) = 0;
};

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_PREFIXTREE_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

