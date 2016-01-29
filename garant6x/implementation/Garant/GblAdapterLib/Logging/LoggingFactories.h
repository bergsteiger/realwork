////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Logging/LoggingFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Logging
//
// Операции логирования действий пользователя
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_LOGGING_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_LOGGING_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Logging/Logging.h"

namespace GblAdapterLib {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for LogEventData

class LogEventDataAbstractFactory;

/// factory manager for LogEventData
class LogEventDataFactoryManager {
public:
	static void register_factory (LogEventDataAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	LogEventDataFactoryManager ();
	
	~LogEventDataFactoryManager ();
	
	void register_factory_i (LogEventDataAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	LogEventData* make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class LogEventDataFactory;
	typedef ACE_Singleton <LogEventDataFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <LogEventDataFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<LogEventDataAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<LogEventDataAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for LogEventData
class LogEventDataAbstractFactory : virtual public Core::IObject {
	friend class LogEventDataFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual LogEventData* make () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for LogManager

class LogManagerAbstractFactory;

/// factory manager for LogManager
class LogManagerFactoryManager {
public:
	static void register_factory (LogManagerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	LogManagerFactoryManager ();
	
	~LogManagerFactoryManager ();
	
	void register_factory_i (LogManagerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	LogManager* make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class LogManagerFactory;
	typedef ACE_Singleton <LogManagerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <LogManagerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<LogManagerAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<LogManagerAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for LogManager
class LogManagerAbstractFactory : virtual public Core::IObject {
	friend class LogManagerFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual LogManager* make () = 0;
};

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_LOGGING_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

