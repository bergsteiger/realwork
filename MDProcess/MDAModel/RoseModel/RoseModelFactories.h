////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseModel/RoseModelFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Interfaces::Category>> MDProcess::MDAModel::RoseModel
//
// Собственные обёртки над розовскими типами. Обёртки нужны, чтобы не складывать алгоритмы в одну
// кучу (сейчас это RoseHelper)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEMODEL_FCTR_H__
#define __MDPROCESS_MDAMODEL_ROSEMODEL_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "MDProcess/MDAModel/RoseModel/RoseModel.h"


////////////////////////////////////////////////////////////////////////////////////
// factories definition for Category

class CategoryAbstractFactory;

/// factory manager for Category
class CategoryFactoryManager {
public:
	static void register_factory (CategoryAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	CategoryFactoryManager ();
	
	~CategoryFactoryManager ();
	
	void register_factory_i (CategoryAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	Category* make (IRoseCategoryPtr cat) /*throw (Core::Root::NoActiveFactory)*/;

	friend class CategoryFactory;
	typedef ACE_Singleton <CategoryFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <CategoryFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<CategoryAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<CategoryAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for Category
class CategoryAbstractFactory : virtual public Core::IObject {
	friend class CategoryFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual Category* make (IRoseCategoryPtr cat) = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for IsVirtual

class IsVirtualAbstractFactory;

/// factory manager for IsVirtual
class IsVirtualFactoryManager {
public:
	static void register_factory (IsVirtualAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	IsVirtualFactoryManager ();
	
	~IsVirtualFactoryManager ();
	
	void register_factory_i (IsVirtualAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	IsVirtual& get () /*throw (Core::Root::NoActiveFactory)*/;

	friend class IsVirtualFactory;
	typedef ACE_Singleton <IsVirtualFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <IsVirtualFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<IsVirtualAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<IsVirtualAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;

	// for cached factory get
	IsVirtual_var m_cached_object_for_get;

	Core::Mutex m_mutex_for_get;
};

/// abstract factory for IsVirtual
class IsVirtualAbstractFactory : virtual public Core::IObject {
	friend class IsVirtualFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual IsVirtual* get () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for PropertyHelper

class PropertyHelperAbstractFactory;

/// factory manager for PropertyHelper
class PropertyHelperFactoryManager {
public:
	static void register_factory (PropertyHelperAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	PropertyHelperFactoryManager ();
	
	~PropertyHelperFactoryManager ();
	
	void register_factory_i (PropertyHelperAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	PropertyHelper& get () /*throw (Core::Root::NoActiveFactory)*/;

	friend class PropertyHelperFactory;
	typedef ACE_Singleton <PropertyHelperFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <PropertyHelperFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<PropertyHelperAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<PropertyHelperAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;

	// for cached factory get
	PropertyHelper_var m_cached_object_for_get;

	Core::Mutex m_mutex_for_get;
};

/// abstract factory for PropertyHelper
class PropertyHelperAbstractFactory : virtual public Core::IObject {
	friend class PropertyHelperFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual PropertyHelper* get () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for ModelPropertiesHelper

class ModelPropertiesHelperAbstractFactory;

/// factory manager for ModelPropertiesHelper
class ModelPropertiesHelperFactoryManager {
public:
	static void register_factory (ModelPropertiesHelperAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	ModelPropertiesHelperFactoryManager ();
	
	~ModelPropertiesHelperFactoryManager ();
	
	void register_factory_i (ModelPropertiesHelperAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	ModelPropertiesHelper& get () /*throw (Core::Root::NoActiveFactory)*/;

	friend class ModelPropertiesHelperFactory;
	typedef ACE_Singleton <ModelPropertiesHelperFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <ModelPropertiesHelperFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<ModelPropertiesHelperAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<ModelPropertiesHelperAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;

	// for cached factory get
	ModelPropertiesHelper_var m_cached_object_for_get;

	Core::Mutex m_mutex_for_get;
};

/// abstract factory for ModelPropertiesHelper
class ModelPropertiesHelperAbstractFactory : virtual public Core::IObject {
	friend class ModelPropertiesHelperFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual ModelPropertiesHelper* get () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for TypeLinkHelper

class TypeLinkHelperAbstractFactory;

/// factory manager for TypeLinkHelper
class TypeLinkHelperFactoryManager {
public:
	static void register_factory (TypeLinkHelperAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	TypeLinkHelperFactoryManager ();
	
	~TypeLinkHelperFactoryManager ();
	
	void register_factory_i (TypeLinkHelperAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	TypeLinkHelper& get () /*throw (Core::Root::NoActiveFactory)*/;

	friend class TypeLinkHelperFactory;
	typedef ACE_Singleton <TypeLinkHelperFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <TypeLinkHelperFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<TypeLinkHelperAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<TypeLinkHelperAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;

	// for cached factory get
	TypeLinkHelper_var m_cached_object_for_get;

	Core::Mutex m_mutex_for_get;
};

/// abstract factory for TypeLinkHelper
class TypeLinkHelperAbstractFactory : virtual public Core::IObject {
	friend class TypeLinkHelperFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual TypeLinkHelper* get () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for OverloadedItem

class OverloadedItemAbstractFactory;

/// factory manager for OverloadedItem
class OverloadedItemFactoryManager {
public:
	static void register_factory (OverloadedItemAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	OverloadedItemFactoryManager ();
	
	~OverloadedItemFactoryManager ();
	
	void register_factory_i (OverloadedItemAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	OverloadedItem* make (const std::string& uid, bool need_collect_child) /*throw (Core::Root::NoActiveFactory)*/;

	friend class OverloadedItemFactory;
	typedef ACE_Singleton <OverloadedItemFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <OverloadedItemFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<OverloadedItemAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<OverloadedItemAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for OverloadedItem
class OverloadedItemAbstractFactory : virtual public Core::IObject {
	friend class OverloadedItemFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual OverloadedItem* make (const std::string& uid, bool need_collect_child) = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for ImplementedItem

class ImplementedItemAbstractFactory;

/// factory manager for ImplementedItem
class ImplementedItemFactoryManager {
public:
	static void register_factory (ImplementedItemAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	ImplementedItemFactoryManager ();
	
	~ImplementedItemFactoryManager ();
	
	void register_factory_i (ImplementedItemAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	ImplementedItem* make (const std::string& uid, bool need_collect_child) /*throw (Core::Root::NoActiveFactory)*/;

	friend class ImplementedItemFactory;
	typedef ACE_Singleton <ImplementedItemFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <ImplementedItemFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<ImplementedItemAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<ImplementedItemAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for ImplementedItem
class ImplementedItemAbstractFactory : virtual public Core::IObject {
	friend class ImplementedItemFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual ImplementedItem* make (const std::string& uid, bool need_collect_child) = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for InheritedItemHelper

class InheritedItemHelperAbstractFactory;

/// factory manager for InheritedItemHelper
class InheritedItemHelperFactoryManager {
public:
	static void register_factory (InheritedItemHelperAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	InheritedItemHelperFactoryManager ();
	
	~InheritedItemHelperFactoryManager ();
	
	void register_factory_i (InheritedItemHelperAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	InheritedItemHelper& get () /*throw (Core::Root::NoActiveFactory)*/;

	friend class InheritedItemHelperFactory;
	typedef ACE_Singleton <InheritedItemHelperFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <InheritedItemHelperFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<InheritedItemHelperAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<InheritedItemHelperAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;

	// for cached factory get
	InheritedItemHelper_var m_cached_object_for_get;

	Core::Mutex m_mutex_for_get;
};

/// abstract factory for InheritedItemHelper
class InheritedItemHelperAbstractFactory : virtual public Core::IObject {
	friend class InheritedItemHelperFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual InheritedItemHelper* get () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for ModelSearcher

class ModelSearcherAbstractFactory;

/// factory manager for ModelSearcher
class ModelSearcherFactoryManager {
public:
	static void register_factory (ModelSearcherAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	ModelSearcherFactoryManager ();
	
	~ModelSearcherFactoryManager ();
	
	void register_factory_i (ModelSearcherAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	ModelSearcher& get () /*throw (Core::Root::NoActiveFactory)*/;

	friend class ModelSearcherFactory;
	typedef ACE_Singleton <ModelSearcherFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <ModelSearcherFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<ModelSearcherAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<ModelSearcherAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;

	// for cached factory get
	ModelSearcher_var m_cached_object_for_get;

	Core::Mutex m_mutex_for_get;
};

/// abstract factory for ModelSearcher
class ModelSearcherAbstractFactory : virtual public Core::IObject {
	friend class ModelSearcherFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual ModelSearcher* get () = 0;
};



#endif //__MDPROCESS_MDAMODEL_ROSEMODEL_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

