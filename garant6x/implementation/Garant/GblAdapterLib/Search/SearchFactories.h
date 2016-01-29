////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Search/SearchFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Search
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SEARCH_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_SEARCH_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Search/Search.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypesFactories.h"

namespace GblAdapterLib {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for QueryPhoneNumberAttribute

class QueryPhoneNumberAttributeAbstractFactory;

/// factory manager for QueryPhoneNumberAttribute
class QueryPhoneNumberAttributeFactoryManager {
public:
	static void register_factory (QueryPhoneNumberAttributeAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	QueryPhoneNumberAttributeFactoryManager ();
	
	~QueryPhoneNumberAttributeFactoryManager ();
	
	void register_factory_i (QueryPhoneNumberAttributeAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	QueryPhoneNumberAttribute* make (AttributeTag_const attribute_tag) /*throw (Core::Root::NoActiveFactory)*/;

	friend class QueryPhoneNumberAttributeFactory;
	typedef ACE_Singleton <QueryPhoneNumberAttributeFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <QueryPhoneNumberAttributeFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<QueryPhoneNumberAttributeAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<QueryPhoneNumberAttributeAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for QueryPhoneNumberAttribute
class QueryPhoneNumberAttributeAbstractFactory : virtual public Core::IObject {
	friend class QueryPhoneNumberAttributeFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual QueryPhoneNumberAttribute* make (AttributeTag_const attribute_tag) = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for QueryDateAttribute

class QueryDateAttributeAbstractFactory;

/// factory manager for QueryDateAttribute
class QueryDateAttributeFactoryManager {
public:
	static void register_factory (QueryDateAttributeAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	QueryDateAttributeFactoryManager ();
	
	~QueryDateAttributeFactoryManager ();
	
	void register_factory_i (QueryDateAttributeAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	QueryDateAttribute* make (AttributeTag_const attribute_tag) /*throw (Core::Root::NoActiveFactory)*/;

	friend class QueryDateAttributeFactory;
	typedef ACE_Singleton <QueryDateAttributeFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <QueryDateAttributeFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<QueryDateAttributeAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<QueryDateAttributeAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for QueryDateAttribute
class QueryDateAttributeAbstractFactory : virtual public Core::IObject {
	friend class QueryDateAttributeFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual QueryDateAttribute* make (AttributeTag_const attribute_tag) = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for QueryNodeAttribute

class QueryNodeAttributeAbstractFactory;

/// factory manager for QueryNodeAttribute
class QueryNodeAttributeFactoryManager {
public:
	static void register_factory (QueryNodeAttributeAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	QueryNodeAttributeFactoryManager ();
	
	~QueryNodeAttributeFactoryManager ();
	
	void register_factory_i (QueryNodeAttributeAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	QueryNodeAttribute* make (AttributeTag_const attribute_tag) /*throw (Core::Root::NoActiveFactory)*/;

	friend class QueryNodeAttributeFactory;
	typedef ACE_Singleton <QueryNodeAttributeFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <QueryNodeAttributeFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<QueryNodeAttributeAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<QueryNodeAttributeAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for QueryNodeAttribute
class QueryNodeAttributeAbstractFactory : virtual public Core::IObject {
	friend class QueryNodeAttributeFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual QueryNodeAttribute* make (AttributeTag_const attribute_tag) = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for QueryContextAttribute

class QueryContextAttributeAbstractFactory;

/// factory manager for QueryContextAttribute
class QueryContextAttributeFactoryManager {
public:
	static void register_factory (QueryContextAttributeAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	QueryContextAttributeFactoryManager ();
	
	~QueryContextAttributeFactoryManager ();
	
	void register_factory_i (QueryContextAttributeAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	QueryContextAttribute* make (AttributeTag_const attribute_tag) /*throw (Core::Root::NoActiveFactory)*/;

	friend class QueryContextAttributeFactory;
	typedef ACE_Singleton <QueryContextAttributeFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <QueryContextAttributeFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<QueryContextAttributeAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<QueryContextAttributeAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for QueryContextAttribute
class QueryContextAttributeAbstractFactory : virtual public Core::IObject {
	friend class QueryContextAttributeFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual QueryContextAttribute* make (AttributeTag_const attribute_tag) = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for AttributeInfo

class AttributeInfoAbstractFactory;

/// factory manager for AttributeInfo
class AttributeInfoFactoryManager {
public:
	static void register_factory (AttributeInfoAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	AttributeInfoFactoryManager ();
	
	~AttributeInfoFactoryManager ();
	
	void register_factory_i (AttributeInfoAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	AttributeInfo* make (AttributeTag_const tag) /*throw (Core::Root::NoActiveFactory)*/;

	friend class AttributeInfoFactory;
	typedef ACE_Singleton <AttributeInfoFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <AttributeInfoFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<AttributeInfoAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<AttributeInfoAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for AttributeInfo
class AttributeInfoAbstractFactory : virtual public Core::IObject {
	friend class AttributeInfoFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual AttributeInfo* make (AttributeTag_const tag) = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for Query

class QueryAbstractFactory;

/// factory manager for Query
class QueryFactoryManager {
public:
	static void register_factory (QueryAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	QueryFactoryManager ();
	
	~QueryFactoryManager ();
	
	void register_factory_i (QueryAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	Query* make (QueryType type) /*throw (Core::Root::NoActiveFactory)*/;

	friend class QueryFactory;
	typedef ACE_Singleton <QueryFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <QueryFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<QueryAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<QueryAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for Query
class QueryAbstractFactory : virtual public Core::IObject {
	friend class QueryFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual Query* make (QueryType type) = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for Search

class SearchAbstractFactory;

/// factory manager for Search
class SearchFactoryManager {
public:
	static void register_factory (SearchAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	SearchFactoryManager ();
	
	~SearchFactoryManager ();
	
	void register_factory_i (SearchAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	Search* make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class SearchFactory;
	typedef ACE_Singleton <SearchFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <SearchFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<SearchAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<SearchAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for Search
class SearchAbstractFactory : virtual public Core::IObject {
	friend class SearchFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual Search* make () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for QueryCreator

class QueryCreatorAbstractFactory;

/// factory manager for QueryCreator
class QueryCreatorFactoryManager {
public:
	static void register_factory (QueryCreatorAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	QueryCreatorFactoryManager ();
	
	~QueryCreatorFactoryManager ();
	
	void register_factory_i (QueryCreatorAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	QueryCreator* make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class QueryCreatorFactory;
	typedef ACE_Singleton <QueryCreatorFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <QueryCreatorFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<QueryCreatorAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<QueryCreatorAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for QueryCreator
class QueryCreatorAbstractFactory : virtual public Core::IObject {
	friend class QueryCreatorFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual QueryCreator* make () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for FiltersQuery

class FiltersQueryAbstractFactory;

/// factory manager for FiltersQuery
class FiltersQueryFactoryManager {
public:
	static void register_factory (FiltersQueryAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	FiltersQueryFactoryManager ();
	
	~FiltersQueryFactoryManager ();
	
	void register_factory_i (FiltersQueryAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	FiltersQuery* make (FilterFromQuery* filter) /*throw (Core::Root::NoActiveFactory)*/;

	friend class FiltersQueryFactory;
	typedef ACE_Singleton <FiltersQueryFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <FiltersQueryFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<FiltersQueryAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<FiltersQueryAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for FiltersQuery
class FiltersQueryAbstractFactory : virtual public Core::IObject {
	friend class FiltersQueryFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual FiltersQuery* make (FilterFromQuery* filter) = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for AdapterFiltersQuery

class AdapterFiltersQueryAbstractFactory;

/// factory manager for AdapterFiltersQuery
class AdapterFiltersQueryFactoryManager {
public:
	static void register_factory (AdapterFiltersQueryAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	AdapterFiltersQueryFactoryManager ();
	
	~AdapterFiltersQueryFactoryManager ();
	
	void register_factory_i (AdapterFiltersQueryAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	AdapterFiltersQuery* make (QueryType type) /*throw (Core::Root::NoActiveFactory)*/;

	friend class AdapterFiltersQueryFactory;
	typedef ACE_Singleton <AdapterFiltersQueryFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <AdapterFiltersQueryFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<AdapterFiltersQueryAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<AdapterFiltersQueryAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for AdapterFiltersQuery
class AdapterFiltersQueryAbstractFactory : virtual public Core::IObject {
	friend class AdapterFiltersQueryFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual AdapterFiltersQuery* make (QueryType type) = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for FullAttributeInfo

class FullAttributeInfoAbstractFactory;

/// factory manager for FullAttributeInfo
class FullAttributeInfoFactoryManager {
public:
	static void register_factory (FullAttributeInfoAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	FullAttributeInfoFactoryManager ();
	
	~FullAttributeInfoFactoryManager ();
	
	void register_factory_i (FullAttributeInfoAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	FullAttributeInfo* make (
		const GblPilotQueryDef::FullAttributeInfo& full_info
	) /*throw (Core::Root::NoActiveFactory)*/;

	friend class FullAttributeInfoFactory;
	typedef ACE_Singleton <FullAttributeInfoFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <FullAttributeInfoFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<FullAttributeInfoAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<FullAttributeInfoAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for FullAttributeInfo
class FullAttributeInfoAbstractFactory : virtual public Core::IObject {
	friend class FullAttributeInfoFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual FullAttributeInfo* make (const GblPilotQueryDef::FullAttributeInfo& full_info) = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for QueryCardInfo

class QueryCardInfoAbstractFactory;

/// factory manager for QueryCardInfo
class QueryCardInfoFactoryManager {
public:
	static void register_factory (QueryCardInfoAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;
	
	static QueryCardInfoFactory::KeySet* keys ();

protected:
	QueryCardInfoFactoryManager ();
	
	~QueryCardInfoFactoryManager ();
	
	void register_factory_i (QueryCardInfoAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	QueryCardInfo* create (const char* key) /*throw (Core::Root::UnknownFactoryKey)*/;

	friend class QueryCardInfoFactory;
	typedef ACE_Singleton <QueryCardInfoFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <QueryCardInfoFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<QueryCardInfoAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<QueryCardInfoAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for QueryCardInfo
class QueryCardInfoAbstractFactory : virtual public Core::IObject {
	friend class QueryCardInfoFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual QueryCardInfo* create () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for AttributesHelper

class AttributesHelperAbstractFactory;

/// factory manager for AttributesHelper
class AttributesHelperFactoryManager {
public:
	static void register_factory (AttributesHelperAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	AttributesHelperFactoryManager ();
	
	~AttributesHelperFactoryManager ();
	
	void register_factory_i (AttributesHelperAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	AttributesHelper* make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class AttributesHelperFactory;
	typedef ACE_Singleton <AttributesHelperFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <AttributesHelperFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<AttributesHelperAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<AttributesHelperAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for AttributesHelper
class AttributesHelperAbstractFactory : virtual public Core::IObject {
	friend class AttributesHelperFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual AttributesHelper* make () = 0;
};

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_SEARCH_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

