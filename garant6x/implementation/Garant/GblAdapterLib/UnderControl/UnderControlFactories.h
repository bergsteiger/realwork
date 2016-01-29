////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/UnderControl/UnderControlFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::UnderControl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_UNDERCONTROL_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_UNDERCONTROL_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "garant6x/implementation/Garant/GblAdapterLib/UnderControl/UnderControl.h"

namespace GblAdapterLib {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for ControlManager

class ControlManagerAbstractFactory;

/// factory manager for ControlManager
class ControlManagerFactoryManager {
public:
	static void register_factory (ControlManagerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	ControlManagerFactoryManager ();
	
	~ControlManagerFactoryManager ();
	
	void register_factory_i (ControlManagerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	ControlManager& make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class ControlManagerFactory;
	typedef ACE_Singleton <ControlManagerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <ControlManagerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<ControlManagerAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<ControlManagerAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;

	// for cached factory make
	ControlManager_var m_cached_object_for_make;

	Core::Mutex m_mutex_for_make;
};

/// abstract factory for ControlManager
class ControlManagerAbstractFactory : virtual public Core::IObject {
	friend class ControlManagerFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual ControlManager* make () = 0;
};

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_UNDERCONTROL_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

