////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/NotifyLocal/NotifyLocalFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::NotifyLocal
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_NOTIFYLOCAL_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_NOTIFYLOCAL_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "garant6x/implementation/Garant/GblAdapterLib/NotifyLocal/NotifyLocal.h"

namespace GblAdapterLib {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for DataTransformer

class DataTransformerAbstractFactory;

/// factory manager for DataTransformer
class DataTransformerFactoryManager {
public:
	static void register_factory (DataTransformerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;
	
	static DataTransformerFactory::KeySet* keys ();

protected:
	DataTransformerFactoryManager ();
	
	~DataTransformerFactoryManager ();
	
	void register_factory_i (DataTransformerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	DataTransformer* make (const char* key) /*throw (Core::Root::UnknownFactoryKey)*/;

	friend class DataTransformerFactory;
	typedef ACE_Singleton <DataTransformerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <DataTransformerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<DataTransformerAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<DataTransformerAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for DataTransformer
class DataTransformerAbstractFactory : virtual public Core::IObject {
	friend class DataTransformerFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual DataTransformer* make () = 0;
};

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_NOTIFYLOCAL_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

