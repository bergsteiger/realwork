////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/IntegrationProject/IntegrationProjectFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::IntegrationProject
//
// Пакет для проекта интеграции
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_INTEGRATIONPROJECT_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_INTEGRATIONPROJECT_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "garant6x/implementation/Garant/GblAdapterLib/IntegrationProject/IntegrationProject.h"

namespace GblAdapterLib {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for Integration

class IntegrationAbstractFactory;

/// factory manager for Integration
class IntegrationFactoryManager {
public:
	static void register_factory (IntegrationAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	IntegrationFactoryManager ();
	
	~IntegrationFactoryManager ();
	
	void register_factory_i (IntegrationAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	Integration* make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class IntegrationFactory;
	typedef ACE_Singleton <IntegrationFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <IntegrationFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<IntegrationAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<IntegrationAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for Integration
class IntegrationAbstractFactory : virtual public Core::IObject {
	friend class IntegrationFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual Integration* make () = 0;
};

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_INTEGRATIONPROJECT_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

