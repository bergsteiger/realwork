////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/Commands/CommandsFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Interfaces::Category>> MDProcess::MDAAddinLib::Commands
//
// интерфейсы для обработки MDA-команд
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_COMMANDS_FCTR_H__
#define __MDPROCESS_MDAADDINLIB_COMMANDS_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "MDProcess/MDAAddinLib/Commands/Commands.h"

namespace Commands {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for CmdManager

class CmdManagerAbstractFactory;

/// factory manager for CmdManager
class CmdManagerFactoryManager {
public:
	static void register_factory (CmdManagerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	CmdManagerFactoryManager ();
	
	~CmdManagerFactoryManager ();
	
	void register_factory_i (CmdManagerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	CmdManager& get () /*throw (Core::Root::NoActiveFactory)*/;

	friend class CmdManagerFactory;
	typedef ACE_Singleton <CmdManagerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <CmdManagerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<CmdManagerAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<CmdManagerAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;

	// for cached factory get
	CmdManager_var m_cached_object_for_get;

	Core::Mutex m_mutex_for_get;
};

/// abstract factory for CmdManager
class CmdManagerAbstractFactory : virtual public Core::IObject {
	friend class CmdManagerFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual CmdManager* get () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for DblClickAction

class DblClickActionAbstractFactory;

/// factory manager for DblClickAction
class DblClickActionFactoryManager {
public:
	static void register_factory (DblClickActionAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	DblClickActionFactoryManager ();
	
	~DblClickActionFactoryManager ();
	
	void register_factory_i (DblClickActionAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	DblClickAction* make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class DblClickActionFactory;
	typedef ACE_Singleton <DblClickActionFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <DblClickActionFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<DblClickActionAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<DblClickActionAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for DblClickAction
class DblClickActionAbstractFactory : virtual public Core::IObject {
	friend class DblClickActionFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual DblClickAction* make () = 0;
};

} // namespace Commands


#endif //__MDPROCESS_MDAADDINLIB_COMMANDS_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

