////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/PharmFirmList/PharmFirmListFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::PharmFirmList
//
// Список фирм
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_PHARMFIRMLIST_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_PHARMFIRMLIST_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "garant6x/implementation/Garant/GblAdapterLib/PharmFirmList/PharmFirmList.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypesFactories.h"

namespace GblAdapterLib {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for PharmFirmListEntry

class PharmFirmListEntryAbstractFactory;

/// factory manager for PharmFirmListEntry
class PharmFirmListEntryFactoryManager {
public:
	static void register_factory (PharmFirmListEntryAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	PharmFirmListEntryFactoryManager ();
	
	~PharmFirmListEntryFactoryManager ();
	
	void register_factory_i (PharmFirmListEntryAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	PharmFirmListEntry* make (GCD::ObjectID id) /*throw (Core::Root::NoActiveFactory)*/;

	friend class PharmFirmListEntryFactory;
	typedef ACE_Singleton <PharmFirmListEntryFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <PharmFirmListEntryFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<PharmFirmListEntryAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<PharmFirmListEntryAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for PharmFirmListEntry
class PharmFirmListEntryAbstractFactory : virtual public Core::IObject {
	friend class PharmFirmListEntryFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual PharmFirmListEntry* make (GCD::ObjectID id) = 0;
};

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_PHARMFIRMLIST_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

