////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/TemplateFunctions/TemplateFunctionsFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Interfaces::Category>> MDProcess::MDAModel::TemplateFunctions
//
// пакет интерфейсов для работы с встроенными функциями генератора
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_TEMPLATEFUNCTIONS_FCTR_H__
#define __MDPROCESS_MDAMODEL_TEMPLATEFUNCTIONS_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "MDProcess/MDAModel/TemplateFunctions/TemplateFunctions.h"

namespace TemplateFunctions {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for InternalStereotypeFunction

class InternalStereotypeFunctionAbstractFactory;

/// factory manager for InternalStereotypeFunction
class InternalStereotypeFunctionFactoryManager {
public:
	static void register_factory (InternalStereotypeFunctionAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;
	
	static InternalStereotypeFunctionFactory::KeySet* keys ();

protected:
	InternalStereotypeFunctionFactoryManager ();
	
	~InternalStereotypeFunctionFactoryManager ();
	
	void register_factory_i (InternalStereotypeFunctionAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	InternalStereotypeFunction& make (const std::string& key) /*throw (Core::Root::UnknownFactoryKey)*/;

	friend class InternalStereotypeFunctionFactory;
	typedef ACE_Singleton <InternalStereotypeFunctionFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <InternalStereotypeFunctionFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<InternalStereotypeFunctionAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<InternalStereotypeFunctionAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;

	// for cached factory make
	struct ObjectCreationIdForMake {
		std::string key_arg;

		ObjectCreationIdForMake (const std::string& key) : key_arg(key) {
		}

		bool operator < (const ObjectCreationIdForMake& c) const {
			return  key_arg < c.key_arg;
		}
	};

	typedef std::map<ObjectCreationIdForMake, InternalStereotypeFunction_var> CachedObjectsForMake;
	typedef std::map<const InternalStereotypeFunction*, CachedObjectsForMake::iterator> CachedObjectsIndexForMake;
	CachedObjectsForMake m_cached_objects_for_make;
	CachedObjectsIndexForMake m_cached_objects_index_for_make;

	Core::Mutex m_mutex_for_make;
};

/// abstract factory for InternalStereotypeFunction
class InternalStereotypeFunctionAbstractFactory : virtual public Core::IObject {
	friend class InternalStereotypeFunctionFactoryManager;
protected:
	virtual const std::string key () const = 0;

	virtual InternalStereotypeFunction* make () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for InternalFunction

class InternalFunctionAbstractFactory;

/// factory manager for InternalFunction
class InternalFunctionFactoryManager {
public:
	static void register_factory (InternalFunctionAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;
	
	static InternalFunctionFactory::KeySet* keys ();

protected:
	InternalFunctionFactoryManager ();
	
	~InternalFunctionFactoryManager ();
	
	void register_factory_i (InternalFunctionAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	InternalFunction& make (const std::string& key) /*throw (Core::Root::UnknownFactoryKey)*/;

	friend class InternalFunctionFactory;
	typedef ACE_Singleton <InternalFunctionFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <InternalFunctionFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<InternalFunctionAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<InternalFunctionAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;

	// for cached factory make
	struct ObjectCreationIdForMake {
		std::string key_arg;

		ObjectCreationIdForMake (const std::string& key) : key_arg(key) {
		}

		bool operator < (const ObjectCreationIdForMake& c) const {
			return  key_arg < c.key_arg;
		}
	};

	typedef std::map<ObjectCreationIdForMake, InternalFunction_var> CachedObjectsForMake;
	typedef std::map<const InternalFunction*, CachedObjectsForMake::iterator> CachedObjectsIndexForMake;
	CachedObjectsForMake m_cached_objects_for_make;
	CachedObjectsIndexForMake m_cached_objects_index_for_make;

	Core::Mutex m_mutex_for_make;
};

/// abstract factory for InternalFunction
class InternalFunctionAbstractFactory : virtual public Core::IObject {
	friend class InternalFunctionFactoryManager;
protected:
	virtual const std::string key () const = 0;

	virtual InternalFunction* make () = 0;
};

} // namespace TemplateFunctions


#endif //__MDPROCESS_MDAMODEL_TEMPLATEFUNCTIONS_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

