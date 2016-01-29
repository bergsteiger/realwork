////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/ContainerOperations/ContainerOperationsFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Interfaces::Category>> MDProcess::MDAModel::ContainerOperations
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_CONTAINEROPERATIONS_FCTR_H__
#define __MDPROCESS_MDAMODEL_CONTAINEROPERATIONS_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "MDProcess/MDAModel/ContainerOperations/ContainerOperations.h"

namespace ContainerOperations {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for ContainerTemplateOperations

class ContainerTemplateOperationsAbstractFactory;

/// factory manager for ContainerTemplateOperations
class ContainerTemplateOperationsFactoryManager {
public:
	static void register_factory (ContainerTemplateOperationsAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	ContainerTemplateOperationsFactoryManager ();
	
	~ContainerTemplateOperationsFactoryManager ();
	
	void register_factory_i (ContainerTemplateOperationsAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	ContainerTemplateOperations& get () /*throw (Core::Root::NoActiveFactory)*/;

	friend class ContainerTemplateOperationsFactory;
	typedef ACE_Singleton <ContainerTemplateOperationsFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <ContainerTemplateOperationsFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<ContainerTemplateOperationsAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<ContainerTemplateOperationsAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;

	// for cached factory get
	ContainerTemplateOperations_var m_cached_object_for_get;

	Core::Mutex m_mutex_for_get;
};

/// abstract factory for ContainerTemplateOperations
class ContainerTemplateOperationsAbstractFactory : virtual public Core::IObject {
	friend class ContainerTemplateOperationsFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual ContainerTemplateOperations* get () = 0;
};

} // namespace ContainerOperations


#endif //__MDPROCESS_MDAMODEL_CONTAINEROPERATIONS_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

