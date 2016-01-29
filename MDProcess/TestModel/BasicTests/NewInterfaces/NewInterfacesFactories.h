////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/BasicTests/NewInterfaces/NewInterfacesFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Interfaces::Category>> TestModel::BasicTests::NewInterfaces
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __TESTMODEL_BASICTESTS_NEWINTERFACES_FCTR_H__
#define __TESTMODEL_BASICTESTS_NEWINTERFACES_FCTR_H__

#include "shared/Core/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "TestModel/BasicTests/NewInterfaces/NewInterfaces.h"

namespace BasicTests {
namespace NewInterfaces {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for DerivedInterface

class DerivedInterfaceAbstractFactory;

/// factory manager for DerivedInterface
class DerivedInterfaceFactoryManager {
public:
	static void register_factory (DerivedInterfaceAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	DerivedInterfaceFactoryManager ();
	
	~DerivedInterfaceFactoryManager ();
	
	void register_factory_i (DerivedInterfaceAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	DerivedInterface* factory () /*throw (Core::Root::NoActiveFactory)*/;

	friend class DerivedInterfaceFactory;
	typedef ACE_Singleton <DerivedInterfaceFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <DerivedInterfaceFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<DerivedInterfaceAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<DerivedInterfaceAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for DerivedInterface
class DerivedInterfaceAbstractFactory : virtual public Core::IObject {
	friend class DerivedInterfaceFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual DerivedInterface* factory () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for BaseInterface1

class BaseInterface1AbstractFactory;

/// factory manager for BaseInterface1
class BaseInterface1FactoryManager {
public:
	static void register_factory (BaseInterface1AbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	BaseInterface1FactoryManager ();
	
	~BaseInterface1FactoryManager ();
	
	void register_factory_i (BaseInterface1AbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	BaseInterface1* make (MultiSelector key) /*throw (Core::Root::UnknownFactoryKey)*/;

	friend class BaseInterface1Factory;
	typedef ACE_Singleton <BaseInterface1FactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <BaseInterface1FactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<BaseInterface1AbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <MultiSelector, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<BaseInterface1AbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for BaseInterface1
class BaseInterface1AbstractFactory : virtual public Core::IObject {
	friend class BaseInterface1FactoryManager;
protected:
	virtual const MultiSelector key () const = 0;

	virtual BaseInterface1* make () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for DerivedInterface1

class DerivedInterface1AbstractFactory;

/// factory manager for DerivedInterface1
class DerivedInterface1FactoryManager {
public:
	static void register_factory (DerivedInterface1AbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	DerivedInterface1FactoryManager ();
	
	~DerivedInterface1FactoryManager ();
	
	void register_factory_i (DerivedInterface1AbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	DerivedInterface1* make_derived (MultiSelector key) /*throw (Core::Root::UnknownFactoryKey)*/;

	DerivedInterface1* make (MultiSelector key) /*throw (Core::Root::UnknownFactoryKey)*/;

	friend class DerivedInterface1Factory;
	typedef ACE_Singleton <DerivedInterface1FactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <DerivedInterface1FactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<DerivedInterface1AbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <MultiSelector, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<DerivedInterface1AbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for DerivedInterface1
class DerivedInterface1AbstractFactory : virtual public Core::IObject {
	friend class DerivedInterface1FactoryManager;
protected:
	virtual const MultiSelector key () const = 0;

	virtual DerivedInterface1* make_derived () = 0;

	virtual DerivedInterface1* make () = 0;
};

} // namespace NewInterfaces
} // namespace BasicTests


#endif //__TESTMODEL_BASICTESTS_NEWINTERFACES_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

