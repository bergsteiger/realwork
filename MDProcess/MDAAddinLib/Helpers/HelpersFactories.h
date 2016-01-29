////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/Helpers/HelpersFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Interfaces::Category>> MDProcess::MDAAddinLib::Helpers
//
// набор вспомогательных интерфейсов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_HELPERS_FCTR_H__
#define __MDPROCESS_MDAADDINLIB_HELPERS_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "MDProcess/MDAAddinLib/Helpers/Helpers.h"

namespace Helpers {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for StereotypeManager

class StereotypeManagerAbstractFactory;

/// factory manager for StereotypeManager
class StereotypeManagerFactoryManager {
public:
	static void register_factory (StereotypeManagerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	StereotypeManagerFactoryManager ();
	
	~StereotypeManagerFactoryManager ();
	
	void register_factory_i (StereotypeManagerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	StereotypeManager* make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class StereotypeManagerFactory;
	typedef ACE_Singleton <StereotypeManagerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <StereotypeManagerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<StereotypeManagerAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<StereotypeManagerAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for StereotypeManager
class StereotypeManagerAbstractFactory : virtual public Core::IObject {
	friend class StereotypeManagerFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual StereotypeManager* make () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for KViewElement

class KViewElementAbstractFactory;

/// factory manager for KViewElement
class KViewElementFactoryManager {
public:
	static void register_factory (KViewElementAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	KViewElementFactoryManager ();
	
	~KViewElementFactoryManager ();
	
	void register_factory_i (KViewElementAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	KViewElement& get () /*throw (Core::Root::NoActiveFactory)*/;

	friend class KViewElementFactory;
	typedef ACE_Singleton <KViewElementFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <KViewElementFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<KViewElementAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<KViewElementAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;

	// for cached factory get
	KViewElement_var m_cached_object_for_get;

	Core::Mutex m_mutex_for_get;
};

/// abstract factory for KViewElement
class KViewElementAbstractFactory : virtual public Core::IObject {
	friend class KViewElementFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual KViewElement* get () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for ReportBuilder

class ReportBuilderAbstractFactory;

/// factory manager for ReportBuilder
class ReportBuilderFactoryManager {
public:
	static void register_factory (ReportBuilderAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	ReportBuilderFactoryManager ();
	
	~ReportBuilderFactoryManager ();
	
	void register_factory_i (ReportBuilderAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	ReportBuilder* make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class ReportBuilderFactory;
	typedef ACE_Singleton <ReportBuilderFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <ReportBuilderFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<ReportBuilderAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<ReportBuilderAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for ReportBuilder
class ReportBuilderAbstractFactory : virtual public Core::IObject {
	friend class ReportBuilderFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual ReportBuilder* make () = 0;
};

} // namespace Helpers


#endif //__MDPROCESS_MDAADDINLIB_HELPERS_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

