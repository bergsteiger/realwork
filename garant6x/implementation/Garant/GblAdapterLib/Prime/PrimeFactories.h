////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Prime/PrimeFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Prime
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_PRIME_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_PRIME_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Prime/Prime.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Settings/SettingsFactories.h"

namespace GblAdapterLib {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for Prime

class PrimeAbstractFactory;

/// factory manager for Prime
class PrimeFactoryManager {
public:
	static void register_factory (PrimeAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	PrimeFactoryManager ();
	
	~PrimeFactoryManager ();
	
	void register_factory_i (PrimeAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	Prime* make (
		PrimeKey key
		, const char* name
		, GblFoldersAdap::SavedQueryData query
	) /*throw (Core::Root::NoActiveFactory)*/;

	friend class PrimeFactory;
	typedef ACE_Singleton <PrimeFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <PrimeFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<PrimeAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<PrimeAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for Prime
class PrimeAbstractFactory : virtual public Core::IObject {
	friend class PrimeFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual Prime* make (PrimeKey key, const char* name, GblFoldersAdap::SavedQueryData query) = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for PrimeManager

class PrimeManagerAbstractFactory;

/// factory manager for PrimeManager
class PrimeManagerFactoryManager {
public:
	static void register_factory (PrimeManagerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	PrimeManagerFactoryManager ();
	
	~PrimeManagerFactoryManager ();
	
	void register_factory_i (PrimeManagerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	PrimeManager& make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class PrimeManagerFactory;
	typedef ACE_Singleton <PrimeManagerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <PrimeManagerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<PrimeManagerAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<PrimeManagerAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;

	// for cached factory make
	PrimeManager_var m_cached_object_for_make;

	Core::Mutex m_mutex_for_make;
};

/// abstract factory for PrimeManager
class PrimeManagerAbstractFactory : virtual public Core::IObject {
	friend class PrimeManagerFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual PrimeManager* make () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for PrimeSettingsManager

class PrimeSettingsManagerAbstractFactory;

/// factory manager for PrimeSettingsManager
class PrimeSettingsManagerFactoryManager {
public:
	static void register_factory (PrimeSettingsManagerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	PrimeSettingsManagerFactoryManager ();
	
	~PrimeSettingsManagerFactoryManager ();
	
	void register_factory_i (PrimeSettingsManagerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	PrimeSettingsManager* make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class PrimeSettingsManagerFactory;
	typedef ACE_Singleton <PrimeSettingsManagerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <PrimeSettingsManagerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<PrimeSettingsManagerAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<PrimeSettingsManagerAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for PrimeSettingsManager
class PrimeSettingsManagerAbstractFactory : virtual public Core::IObject {
	friend class PrimeSettingsManagerFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual PrimeSettingsManager* make () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for PrimeContractData

class PrimeContractDataAbstractFactory;

/// factory manager for PrimeContractData
class PrimeContractDataFactoryManager {
public:
	static void register_factory (PrimeContractDataAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	PrimeContractDataFactoryManager ();
	
	~PrimeContractDataFactoryManager ();
	
	void register_factory_i (PrimeContractDataAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	PrimeContractData* get_contract_data (Query* query) /*throw (Core::Root::NoActiveFactory)*/;

	friend class PrimeContractDataFactory;
	typedef ACE_Singleton <PrimeContractDataFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <PrimeContractDataFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<PrimeContractDataAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<PrimeContractDataAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for PrimeContractData
class PrimeContractDataAbstractFactory : virtual public Core::IObject {
	friend class PrimeContractDataFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual PrimeContractData* get_contract_data (Query* query) = 0;
};

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_PRIME_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

