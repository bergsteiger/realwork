////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GSI/NotifyService/NotifyServiceFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Interfaces::Category>> shared::GSI::NotifyService
//
// Сервис для рассылки нотификаций между процессами, которые могут быть запущены на разных машинах.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GSI_NOTIFYSERVICE_FCTR_H__
#define __SHARED_GSI_NOTIFYSERVICE_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "shared/GSI/NotifyService/NotifyService.h"

namespace GSI {
namespace NotifyService {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for Supplier

class SupplierAbstractFactory;

/// factory manager for Supplier
class SupplierFactoryManager {
public:
	static void register_factory (SupplierAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	SupplierFactoryManager ();
	
	~SupplierFactoryManager ();
	
	void register_factory_i (SupplierAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	Supplier* make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class SupplierFactory;
	typedef ACE_Singleton <SupplierFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <SupplierFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<SupplierAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<SupplierAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for Supplier
class SupplierAbstractFactory : virtual public Core::IObject {
	friend class SupplierFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual Supplier* make () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for Manager

class ManagerAbstractFactory;

/// factory manager for Manager
class ManagerFactoryManager {
public:
	static void register_factory (ManagerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	ManagerFactoryManager ();
	
	~ManagerFactoryManager ();
	
	void register_factory_i (ManagerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	Manager& make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class ManagerFactory;
	typedef ACE_Singleton <ManagerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <ManagerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<ManagerAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<ManagerAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;

	// for cached factory make
	Manager_var m_cached_object_for_make;

	Core::Mutex m_mutex_for_make;
};

/// abstract factory for Manager
class ManagerAbstractFactory : virtual public Core::IObject {
	friend class ManagerFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual Manager* make () = 0;
};

} // namespace NotifyService
} // namespace GSI


#endif //__SHARED_GSI_NOTIFYSERVICE_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

