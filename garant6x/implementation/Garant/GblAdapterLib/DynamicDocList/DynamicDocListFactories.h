////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/DynamicDocList/DynamicDocListFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::DynamicDocList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICDOCLIST_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICDOCLIST_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicDocList/DynamicDocList.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypesFactories.h"

namespace GblAdapterLib {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for ListEntryInfo

class ListEntryInfoAbstractFactory;

/// factory manager for ListEntryInfo
class ListEntryInfoFactoryManager {
public:
	static void register_factory (ListEntryInfoAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	ListEntryInfoFactoryManager ();
	
	~ListEntryInfoFactoryManager ();
	
	void register_factory_i (ListEntryInfoAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	ListEntryInfo* make (
		const GblPilot::ListEntryInfo& info
		, const NodeBase* root
	) /*throw (Core::Root::NoActiveFactory)*/;

	ListEntryInfo* make (const GblPilot::ListEntryInfo& info) /*throw (Core::Root::NoActiveFactory)*/;

	friend class ListEntryInfoFactory;
	typedef ACE_Singleton <ListEntryInfoFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <ListEntryInfoFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<ListEntryInfoAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<ListEntryInfoAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for ListEntryInfo
class ListEntryInfoAbstractFactory : virtual public Core::IObject {
	friend class ListEntryInfoFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual ListEntryInfo* make (const GblPilot::ListEntryInfo& info, const NodeBase* root) = 0;

	virtual ListEntryInfo* make (const GblPilot::ListEntryInfo& info) = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for DynList

class DynListAbstractFactory;

/// factory manager for DynList
class DynListFactoryManager {
public:
	static void register_factory (DynListAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	DynListFactoryManager ();
	
	~DynListFactoryManager ();
	
	void register_factory_i (DynListAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	DynList* make (GblDocList::DocListTree* server_list) /*throw (Core::Root::NoActiveFactory)*/;

	DynList* make (
		GblPilot::LegalDocument* legal_document
		, const GblPilotQueryDef::Query& query
		, DynListType type
	) /*throw (Core::Root::NoActiveFactory)*/;

	DynList* make (SpecialListKey key) /*throw (Core::Root::NoActiveFactory)*/;

	friend class DynListFactory;
	typedef ACE_Singleton <DynListFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <DynListFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<DynListAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<DynListAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for DynList
class DynListAbstractFactory : virtual public Core::IObject {
	friend class DynListFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual DynList* make (GblDocList::DocListTree* server_list) = 0;

	virtual DynList* make (
		GblPilot::LegalDocument* legal_document
		, const GblPilotQueryDef::Query& query
		, DynListType type
	) = 0;

	virtual DynList* make (SpecialListKey key) = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for SearchDynList

class SearchDynListAbstractFactory;

/// factory manager for SearchDynList
class SearchDynListFactoryManager {
public:
	static void register_factory (SearchDynListAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	SearchDynListFactoryManager ();
	
	~SearchDynListFactoryManager ();
	
	void register_factory_i (SearchDynListAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	SearchDynList* make (GblPilot::SearchDocList* search_doc_list) /*throw (Core::Root::NoActiveFactory)*/;

	friend class SearchDynListFactory;
	typedef ACE_Singleton <SearchDynListFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <SearchDynListFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<SearchDynListAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<SearchDynListAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for SearchDynList
class SearchDynListAbstractFactory : virtual public Core::IObject {
	friend class SearchDynListFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual SearchDynList* make (GblPilot::SearchDocList* search_doc_list) = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for DocListFactory

class DocListFactoryAbstractFactory;

/// factory manager for DocListFactory
class DocListFactoryFactoryManager {
public:
	static void register_factory (DocListFactoryAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	DocListFactoryFactoryManager ();
	
	~DocListFactoryFactoryManager ();
	
	void register_factory_i (DocListFactoryAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	DocListFactory* make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class DocListFactoryFactory;
	typedef ACE_Singleton <DocListFactoryFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <DocListFactoryFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<DocListFactoryAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<DocListFactoryAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for DocListFactory
class DocListFactoryAbstractFactory : virtual public Core::IObject {
	friend class DocListFactoryFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual DocListFactory* make () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for DynListNode

class DynListNodeAbstractFactory;

/// factory manager for DynListNode
class DynListNodeFactoryManager {
public:
	static void register_factory (DynListNodeAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	DynListNodeFactoryManager ();
	
	~DynListNodeFactoryManager ();
	
	void register_factory_i (DynListNodeAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	DynListNode* make (FakeFacetForFactory* owner_tree, const GTree::Node& snode) /*throw (Core::Root::NoActiveFactory)*/;

	friend class DynListNodeFactory;
	typedef ACE_Singleton <DynListNodeFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <DynListNodeFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<DynListNodeAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<DynListNodeAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for DynListNode
class DynListNodeAbstractFactory : virtual public Core::IObject {
	friend class DynListNodeFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual DynListNode* make (FakeFacetForFactory* owner_tree, const GTree::Node& snode) = 0;
};

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICDOCLIST_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

