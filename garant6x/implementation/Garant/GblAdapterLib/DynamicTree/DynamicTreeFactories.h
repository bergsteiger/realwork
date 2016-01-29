////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTreeFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::DynamicTree
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"

namespace GblAdapterLib {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for SortFilter

class SortFilterAbstractFactory;

/// factory manager for SortFilter
class SortFilterFactoryManager {
public:
	static void register_factory (SortFilterAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	SortFilterFactoryManager ();
	
	~SortFilterFactoryManager ();
	
	void register_factory_i (SortFilterAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	SortFilter* make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class SortFilterFactory;
	typedef ACE_Singleton <SortFilterFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <SortFilterFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<SortFilterAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<SortFilterAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for SortFilter
class SortFilterAbstractFactory : virtual public Core::IObject {
	friend class SortFilterFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual SortFilter* make () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for TrimFilter

class TrimFilterAbstractFactory;

/// factory manager for TrimFilter
class TrimFilterFactoryManager {
public:
	static void register_factory (TrimFilterAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	TrimFilterFactoryManager ();
	
	~TrimFilterFactoryManager ();
	
	void register_factory_i (TrimFilterAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	TrimFilter* make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class TrimFilterFactory;
	typedef ACE_Singleton <TrimFilterFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <TrimFilterFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<TrimFilterAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<TrimFilterAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for TrimFilter
class TrimFilterAbstractFactory : virtual public Core::IObject {
	friend class TrimFilterFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual TrimFilter* make () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for LayerFilter

class LayerFilterAbstractFactory;

/// factory manager for LayerFilter
class LayerFilterFactoryManager {
public:
	static void register_factory (LayerFilterAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	LayerFilterFactoryManager ();
	
	~LayerFilterFactoryManager ();
	
	void register_factory_i (LayerFilterAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	LayerFilter* make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class LayerFilterFactory;
	typedef ACE_Singleton <LayerFilterFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <LayerFilterFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<LayerFilterAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<LayerFilterAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for LayerFilter
class LayerFilterAbstractFactory : virtual public Core::IObject {
	friend class LayerFilterFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual LayerFilter* make () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for FindIterator

class FindIteratorAbstractFactory;

/// factory manager for FindIterator
class FindIteratorFactoryManager {
public:
	static void register_factory (FindIteratorAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	FindIteratorFactoryManager ();
	
	~FindIteratorFactoryManager ();
	
	void register_factory_i (FindIteratorAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	FindIterator* make (GTree::FindIterator* iterator) /*throw (Core::Root::NoActiveFactory)*/;

	friend class FindIteratorFactory;
	typedef ACE_Singleton <FindIteratorFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <FindIteratorFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<FindIteratorAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<FindIteratorAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for FindIterator
class FindIteratorAbstractFactory : virtual public Core::IObject {
	friend class FindIteratorFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual FindIterator* make (GTree::FindIterator* iterator) = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for NodesClipboard

class NodesClipboardAbstractFactory;

/// factory manager for NodesClipboard
class NodesClipboardFactoryManager {
public:
	static void register_factory (NodesClipboardAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	NodesClipboardFactoryManager ();
	
	~NodesClipboardFactoryManager ();
	
	void register_factory_i (NodesClipboardAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	NodesClipboard* make () /*throw (Core::Root::NoActiveFactory)*/;

	NodesClipboard* make (GTree::NodeHolder* node_holder) /*throw (Core::Root::NoActiveFactory)*/;

	friend class NodesClipboardFactory;
	typedef ACE_Singleton <NodesClipboardFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <NodesClipboardFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<NodesClipboardAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<NodesClipboardAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for NodesClipboard
class NodesClipboardAbstractFactory : virtual public Core::IObject {
	friend class NodesClipboardFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual NodesClipboard* make () = 0;

	virtual NodesClipboard* make (GTree::NodeHolder* node_holder) = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for NodeBase

class NodeBaseAbstractFactory;

/// factory manager for NodeBase
class NodeBaseFactoryManager {
public:
	static void register_factory (NodeBaseAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;
	
	static NodeBaseFactory::KeySet* keys ();

protected:
	NodeBaseFactoryManager ();
	
	~NodeBaseFactoryManager ();
	
	void register_factory_i (NodeBaseAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	NodeBase* make (const char* key) /*throw (Core::Root::UnknownFactoryKey, CanNotFindData)*/;

	NodeBase* make (
		FakeFacetForFactory* owner_tree
		, const GTree::Node& snode
		, const char* key
	) /*throw (Core::Root::UnknownFactoryKey)*/;

	friend class NodeBaseFactory;
	typedef ACE_Singleton <NodeBaseFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <NodeBaseFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<NodeBaseAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<NodeBaseAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for NodeBase
class NodeBaseAbstractFactory : virtual public Core::IObject {
	friend class NodeBaseFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual NodeBase* make () /*throw (CanNotFindData)*/ = 0;

	virtual NodeBase* make (FakeFacetForFactory* owner_tree, const GTree::Node& snode) = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for NodeIterator

class NodeIteratorAbstractFactory;

/// factory manager for NodeIterator
class NodeIteratorFactoryManager {
public:
	static void register_factory (NodeIteratorAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	NodeIteratorFactoryManager ();
	
	~NodeIteratorFactoryManager ();
	
	void register_factory_i (NodeIteratorAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	NodeIterator* make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class NodeIteratorFactory;
	typedef ACE_Singleton <NodeIteratorFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <NodeIteratorFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<NodeIteratorAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<NodeIteratorAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for NodeIterator
class NodeIteratorAbstractFactory : virtual public Core::IObject {
	friend class NodeIteratorFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual NodeIterator* make () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for TrimLeafFilter

class TrimLeafFilterAbstractFactory;

/// factory manager for TrimLeafFilter
class TrimLeafFilterFactoryManager {
public:
	static void register_factory (TrimLeafFilterAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	TrimLeafFilterFactoryManager ();
	
	~TrimLeafFilterFactoryManager ();
	
	void register_factory_i (TrimLeafFilterAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	TrimLeafFilter* make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class TrimLeafFilterFactory;
	typedef ACE_Singleton <TrimLeafFilterFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <TrimLeafFilterFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<TrimLeafFilterAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<TrimLeafFilterAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for TrimLeafFilter
class TrimLeafFilterAbstractFactory : virtual public Core::IObject {
	friend class TrimLeafFilterFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual TrimLeafFilter* make () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for CountryFilter

class CountryFilterAbstractFactory;

/// factory manager for CountryFilter
class CountryFilterFactoryManager {
public:
	static void register_factory (CountryFilterAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	CountryFilterFactoryManager ();
	
	~CountryFilterFactoryManager ();
	
	void register_factory_i (CountryFilterAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	CountryFilter* make (const NodeBase* country) /*throw (Core::Root::NoActiveFactory)*/;

	CountryFilter* make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class CountryFilterFactory;
	typedef ACE_Singleton <CountryFilterFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <CountryFilterFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<CountryFilterAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<CountryFilterAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for CountryFilter
class CountryFilterAbstractFactory : virtual public Core::IObject {
	friend class CountryFilterFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual CountryFilter* make (const NodeBase* country) = 0;

	virtual CountryFilter* make () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for CutToLeafCountFilter

class CutToLeafCountFilterAbstractFactory;

/// factory manager for CutToLeafCountFilter
class CutToLeafCountFilterFactoryManager {
public:
	static void register_factory (CutToLeafCountFilterAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	CutToLeafCountFilterFactoryManager ();
	
	~CutToLeafCountFilterFactoryManager ();
	
	void register_factory_i (CutToLeafCountFilterAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	CutToLeafCountFilter* make (unsigned long leaf_count) /*throw (Core::Root::NoActiveFactory)*/;

	CutToLeafCountFilter* make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class CutToLeafCountFilterFactory;
	typedef ACE_Singleton <CutToLeafCountFilterFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <CutToLeafCountFilterFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<CutToLeafCountFilterAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<CutToLeafCountFilterAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for CutToLeafCountFilter
class CutToLeafCountFilterAbstractFactory : virtual public Core::IObject {
	friend class CutToLeafCountFilterFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual CutToLeafCountFilter* make (unsigned long leaf_count) = 0;

	virtual CutToLeafCountFilter* make () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for BlocksFilter

class BlocksFilterAbstractFactory;

/// factory manager for BlocksFilter
class BlocksFilterFactoryManager {
public:
	static void register_factory (BlocksFilterAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	BlocksFilterFactoryManager ();
	
	~BlocksFilterFactoryManager ();
	
	void register_factory_i (BlocksFilterAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	BlocksFilter* make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class BlocksFilterFactory;
	typedef ACE_Singleton <BlocksFilterFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <BlocksFilterFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<BlocksFilterAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<BlocksFilterAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for BlocksFilter
class BlocksFilterAbstractFactory : virtual public Core::IObject {
	friend class BlocksFilterFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual BlocksFilter* make () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for InpharmFilter

class InpharmFilterAbstractFactory;

/// factory manager for InpharmFilter
class InpharmFilterFactoryManager {
public:
	static void register_factory (InpharmFilterAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	InpharmFilterFactoryManager ();
	
	~InpharmFilterFactoryManager ();
	
	void register_factory_i (InpharmFilterAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	InpharmFilter* make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class InpharmFilterFactory;
	typedef ACE_Singleton <InpharmFilterFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <InpharmFilterFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<InpharmFilterAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<InpharmFilterAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for InpharmFilter
class InpharmFilterAbstractFactory : virtual public Core::IObject {
	friend class InpharmFilterFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual InpharmFilter* make () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for VariantsForDocFilter

class VariantsForDocFilterAbstractFactory;

/// factory manager for VariantsForDocFilter
class VariantsForDocFilterFactoryManager {
public:
	static void register_factory (VariantsForDocFilterAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	VariantsForDocFilterFactoryManager ();
	
	~VariantsForDocFilterFactoryManager ();
	
	void register_factory_i (VariantsForDocFilterAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	VariantsForDocFilter* make (unsigned long doc_id) /*throw (Core::Root::NoActiveFactory)*/;

	VariantsForDocFilter* make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class VariantsForDocFilterFactory;
	typedef ACE_Singleton <VariantsForDocFilterFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <VariantsForDocFilterFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<VariantsForDocFilterAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<VariantsForDocFilterAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for VariantsForDocFilter
class VariantsForDocFilterAbstractFactory : virtual public Core::IObject {
	friend class VariantsForDocFilterFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual VariantsForDocFilter* make (unsigned long doc_id) = 0;

	virtual VariantsForDocFilter* make () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for ContextFilter

class ContextFilterAbstractFactory;

/// factory manager for ContextFilter
class ContextFilterFactoryManager {
public:
	static void register_factory (ContextFilterAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	ContextFilterFactoryManager ();
	
	~ContextFilterFactoryManager ();
	
	void register_factory_i (ContextFilterAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	ContextFilter* make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class ContextFilterFactory;
	typedef ACE_Singleton <ContextFilterFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <ContextFilterFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<ContextFilterAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<ContextFilterAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for ContextFilter
class ContextFilterAbstractFactory : virtual public Core::IObject {
	friend class ContextFilterFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual ContextFilter* make () = 0;
};

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

