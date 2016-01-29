////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/DocTree/DocTreeFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::DocTree
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCTREE_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_DOCTREE_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DocTree/DocTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTreeFactories.h"

namespace GblAdapterLib {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for DocNodeFilter

class DocNodeFilterAbstractFactory;

/// factory manager for DocNodeFilter
class DocNodeFilterFactoryManager {
public:
	static void register_factory (DocNodeFilterAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	DocNodeFilterFactoryManager ();
	
	~DocNodeFilterFactoryManager ();
	
	void register_factory_i (DocNodeFilterAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	DocNodeFilter* make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class DocNodeFilterFactory;
	typedef ACE_Singleton <DocNodeFilterFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <DocNodeFilterFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<DocNodeFilterAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<DocNodeFilterAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for DocNodeFilter
class DocNodeFilterAbstractFactory : virtual public Core::IObject {
	friend class DocNodeFilterFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual DocNodeFilter* make () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for ContentsNode

class ContentsNodeAbstractFactory;

/// factory manager for ContentsNode
class ContentsNodeFactoryManager {
public:
	static void register_factory (ContentsNodeAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	ContentsNodeFactoryManager ();
	
	~ContentsNodeFactoryManager ();
	
	void register_factory_i (ContentsNodeAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	ContentsNode* make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class ContentsNodeFactory;
	typedef ACE_Singleton <ContentsNodeFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <ContentsNodeFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<ContentsNodeAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<ContentsNodeAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for ContentsNode
class ContentsNodeAbstractFactory : virtual public Core::IObject {
	friend class ContentsNodeFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual ContentsNode* make () = 0;
};

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCTREE_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

