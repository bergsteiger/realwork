////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/HCAdapterLib/HCInterfaces/HCInterfacesFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::HCAdapterLib::HCInterfaces
//
// Интерфейсы для взаимодействия с отделом Пащака
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_HCADAPTERLIB_HCINTERFACES_FCTR_H__
#define __GARANT6X_HCADAPTERLIB_HCINTERFACES_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "garant6x/implementation/Garant/HCAdapterLib/HCInterfaces/HCInterfaces.h"

namespace HCAdapterLib {
namespace HCInterfaces {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for OnlineData

class OnlineDataAbstractFactory;

/// factory manager for OnlineData
class OnlineDataFactoryManager {
public:
	static void register_factory (OnlineDataAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;
	
	static OnlineDataFactory::KeySet* keys ();

protected:
	OnlineDataFactoryManager ();
	
	~OnlineDataFactoryManager ();
	
	void register_factory_i (OnlineDataAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	OnlineData* make (
		GCI::IO::Stream* xml_stream
		, const GblConsultingDef::ConsultationID& consultation_id
		, const char* key
	) /*throw (Core::Root::UnknownFactoryKey)*/;

	friend class OnlineDataFactory;
	typedef ACE_Singleton <OnlineDataFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <OnlineDataFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<OnlineDataAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<OnlineDataAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for OnlineData
class OnlineDataAbstractFactory : virtual public Core::IObject {
	friend class OnlineDataFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual OnlineData* make (GCI::IO::Stream* xml_stream, const GblConsultingDef::ConsultationID& consultation_id) = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for BusinessLogicLifeCycle

class BusinessLogicLifeCycleAbstractFactory;

/// factory manager for BusinessLogicLifeCycle
class BusinessLogicLifeCycleFactoryManager {
public:
	static void register_factory (BusinessLogicLifeCycleAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	BusinessLogicLifeCycleFactoryManager ();
	
	~BusinessLogicLifeCycleFactoryManager ();
	
	void register_factory_i (BusinessLogicLifeCycleAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	BusinessLogicLifeCycle* make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class BusinessLogicLifeCycleFactory;
	typedef ACE_Singleton <BusinessLogicLifeCycleFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <BusinessLogicLifeCycleFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<BusinessLogicLifeCycleAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<BusinessLogicLifeCycleAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for BusinessLogicLifeCycle
class BusinessLogicLifeCycleAbstractFactory : virtual public Core::IObject {
	friend class BusinessLogicLifeCycleFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual BusinessLogicLifeCycle* make () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for ConsultingRequests

class ConsultingRequestsAbstractFactory;

/// factory manager for ConsultingRequests
class ConsultingRequestsFactoryManager {
public:
	static void register_factory (ConsultingRequestsAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	ConsultingRequestsFactoryManager ();
	
	~ConsultingRequestsFactoryManager ();
	
	void register_factory_i (ConsultingRequestsAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	ConsultingRequests* make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class ConsultingRequestsFactory;
	typedef ACE_Singleton <ConsultingRequestsFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <ConsultingRequestsFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<ConsultingRequestsAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<ConsultingRequestsAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for ConsultingRequests
class ConsultingRequestsAbstractFactory : virtual public Core::IObject {
	friend class ConsultingRequestsFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual ConsultingRequests* make () = 0;
};

} // namespace HCInterfaces
} // namespace HCAdapterLib


#endif //__GARANT6X_HCADAPTERLIB_HCINTERFACES_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

