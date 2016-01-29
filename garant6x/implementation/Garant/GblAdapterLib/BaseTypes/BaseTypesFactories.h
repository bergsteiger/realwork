////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypesFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::BaseTypes
//
// Базовые типы, используемые в адаптере
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_BASETYPES_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_BASETYPES_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"

namespace GblAdapterLib {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for SearchEntity

class SearchEntityAbstractFactory;

/// factory manager for SearchEntity
class SearchEntityFactoryManager {
public:
	static void register_factory (SearchEntityAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	SearchEntityFactoryManager ();
	
	~SearchEntityFactoryManager ();
	
	void register_factory_i (SearchEntityAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	SearchEntity* make (
		SearchResultType result_type
		, size_t document_count
		, size_t entry_count
		, size_t edition_count
	) /*throw (Core::Root::NoActiveFactory)*/;

	SearchEntity* make (GblPilotQueryDef::SearchEntity* search_entity) /*throw (Core::Root::NoActiveFactory)*/;

	friend class SearchEntityFactory;
	typedef ACE_Singleton <SearchEntityFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <SearchEntityFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<SearchEntityAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<SearchEntityAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for SearchEntity
class SearchEntityAbstractFactory : virtual public Core::IObject {
	friend class SearchEntityFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual SearchEntity* make (
		SearchResultType result_type
		, size_t document_count
		, size_t entry_count
		, size_t edition_count
	) = 0;

	virtual SearchEntity* make (GblPilotQueryDef::SearchEntity* search_entity) = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for Variant

class VariantAbstractFactory;

/// factory manager for Variant
class VariantFactoryManager {
public:
	static void register_factory (VariantAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	VariantFactoryManager ();
	
	~VariantFactoryManager ();
	
	void register_factory_i (VariantAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	Variant* make () /*throw (Core::Root::NoActiveFactory)*/;

	Variant* make_long (long value) /*throw (Core::Root::NoActiveFactory)*/;

	Variant* make_bool (bool value) /*throw (Core::Root::NoActiveFactory)*/;

	Variant* make_string (GCI::IO::String* value) /*throw (Core::Root::NoActiveFactory)*/;

	Variant* make_object (Core::IObject* value) /*throw (Core::Root::NoActiveFactory)*/;

	friend class VariantFactory;
	typedef ACE_Singleton <VariantFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <VariantFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<VariantAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<VariantAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for Variant
class VariantAbstractFactory : virtual public Core::IObject {
	friend class VariantFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual Variant* make () = 0;

	virtual Variant* make_long (long value) = 0;

	virtual Variant* make_bool (bool value) = 0;

	virtual Variant* make_string (GCI::IO::String* value) = 0;

	virtual Variant* make_object (Core::IObject* value) = 0;
};

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_BASETYPES_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

