////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/ExternalOperation/ExternalOperationFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::ExternalOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_EXTERNALOPERATION_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_EXTERNALOPERATION_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ExternalOperation/ExternalOperation.h"

namespace GblAdapterLib {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for ExternalOperation

class ExternalOperationAbstractFactory;

/// factory manager for ExternalOperation
class ExternalOperationFactoryManager {
public:
	static void register_factory (ExternalOperationAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	ExternalOperationFactoryManager ();
	
	~ExternalOperationFactoryManager ();
	
	void register_factory_i (ExternalOperationAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	ExternalOperation* make (ObjectId id) /*throw (Core::Root::NoActiveFactory)*/;

	friend class ExternalOperationFactory;
	typedef ACE_Singleton <ExternalOperationFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <ExternalOperationFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<ExternalOperationAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<ExternalOperationAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for ExternalOperation
class ExternalOperationAbstractFactory : virtual public Core::IObject {
	friend class ExternalOperationFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual ExternalOperation* make (ObjectId id) = 0;
};

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_EXTERNALOPERATION_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

