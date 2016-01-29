////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Logging_i/LogManager_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Logging_i::LogManager_i
// Заголовок реализации класса серванта для интерфеса LogManager
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_LOGGING_I_LOGMANAGER_I_H__
#define __GARANT6X_GBLADAPTERLIB_LOGGING_I_LOGMANAGER_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "ace/Singleton.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Logging/Logging.h"

namespace GblAdapterLib {

class LogManager_i; // self forward Var
typedef ::Core::Var<LogManager_i> LogManager_i_var;
typedef ::Core::Var<const LogManager_i> LogManager_i_cvar;

class LogManager_i_factory;

class LogManager_i:
	virtual public LogManager
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (LogManager_i)
	friend class LogManager_i_factory; // self factory

	// singleton declaration
	typedef ACE_Singleton <LogManager_i, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <LogManager_i, ACE_SYNCH_RECURSIVE_MUTEX>;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	LogManager_i ();

	virtual ~LogManager_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from LogManager
	virtual void add_event (LogEvent log_event, LogEventData* data);
}; // class LogManager_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_LOGGING_I_LOGMANAGER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
