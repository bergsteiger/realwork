////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Consulting/ConsultingFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Consulting
//
// Интерфейсы для работы со службой ПП
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_CONSULTING_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_CONSULTING_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Consulting/Consulting.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypesFactories.h"

namespace GblAdapterLib {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for Estimation

class EstimationAbstractFactory;

/// factory manager for Estimation
class EstimationFactoryManager {
public:
	static void register_factory (EstimationAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	EstimationFactoryManager ();
	
	~EstimationFactoryManager ();
	
	void register_factory_i (EstimationAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	Estimation* make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class EstimationFactory;
	typedef ACE_Singleton <EstimationFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <EstimationFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<EstimationAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<EstimationAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for Estimation
class EstimationAbstractFactory : virtual public Core::IObject {
	friend class EstimationFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual Estimation* make () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for Consultation

class ConsultationAbstractFactory;

/// factory manager for Consultation
class ConsultationFactoryManager {
public:
	static void register_factory (ConsultationAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	ConsultationFactoryManager ();
	
	~ConsultationFactoryManager ();
	
	void register_factory_i (ConsultationAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	Consultation* make (
		GblConsultingClient::Consultation* server_consultation
		, FoldersNode* folders_node
	) /*throw (Core::Root::NoActiveFactory)*/;

	friend class ConsultationFactory;
	typedef ACE_Singleton <ConsultationFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <ConsultationFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<ConsultationAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<ConsultationAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for Consultation
class ConsultationAbstractFactory : virtual public Core::IObject {
	friend class ConsultationFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual Consultation* make (GblConsultingClient::Consultation* server_consultation, FoldersNode* folders_node) = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for ConsultationManager

class ConsultationManagerAbstractFactory;

/// factory manager for ConsultationManager
class ConsultationManagerFactoryManager {
public:
	static void register_factory (ConsultationManagerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	ConsultationManagerFactoryManager ();
	
	~ConsultationManagerFactoryManager ();
	
	void register_factory_i (ConsultationManagerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	ConsultationManager* make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class ConsultationManagerFactory;
	typedef ACE_Singleton <ConsultationManagerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <ConsultationManagerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<ConsultationManagerAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<ConsultationManagerAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for ConsultationManager
class ConsultationManagerAbstractFactory : virtual public Core::IObject {
	friend class ConsultationManagerFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual ConsultationManager* make () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for ConsultingTemplateInfo

class ConsultingTemplateInfoAbstractFactory;

/// factory manager for ConsultingTemplateInfo
class ConsultingTemplateInfoFactoryManager {
public:
	static void register_factory (ConsultingTemplateInfoAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	ConsultingTemplateInfoFactoryManager ();
	
	~ConsultingTemplateInfoFactoryManager ();
	
	void register_factory_i (ConsultingTemplateInfoAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	ConsultingTemplateInfo* make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class ConsultingTemplateInfoFactory;
	typedef ACE_Singleton <ConsultingTemplateInfoFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <ConsultingTemplateInfoFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<ConsultingTemplateInfoAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<ConsultingTemplateInfoAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for ConsultingTemplateInfo
class ConsultingTemplateInfoAbstractFactory : virtual public Core::IObject {
	friend class ConsultingTemplateInfoFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual ConsultingTemplateInfo* make () = 0;
};

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_CONSULTING_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

