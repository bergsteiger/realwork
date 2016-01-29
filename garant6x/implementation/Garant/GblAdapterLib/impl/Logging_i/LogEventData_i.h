////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Logging_i/LogEventData_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Logging_i::LogEventData_i
// Заголовок реализации класса серванта для интерфеса LogEventData
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_LOGGING_I_LOGEVENTDATA_I_H__
#define __GARANT6X_GBLADAPTERLIB_LOGGING_I_LOGEVENTDATA_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Logging/Logging.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Logging_i/Logging_i.h"

namespace GblAdapterLib {

class LogEventData_i; // self forward Var
typedef ::Core::Var<LogEventData_i> LogEventData_i_var;
typedef ::Core::Var<const LogEventData_i> LogEventData_i_cvar;

class LogEventData_i_factory;

class LogEventData_i:
	virtual public LogEventData
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (LogEventData_i)
	friend class LogEventData_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	LogEventData_i ();

	virtual ~LogEventData_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	AnyVector m_data;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from LogEventData
	virtual void add_date (const Date& data);

	// implemented method from LogEventData
	virtual void add_object (const Core::IObject* data);

	// implemented method from LogEventData
	virtual void add_string (const char* data);

	// implemented method from LogEventData
	virtual void add_ulong (unsigned long data);

	// implemented method from LogEventData
	// Записать в лог
	virtual void write_to_log (LogEvent log_event) const;
}; // class LogEventData_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_LOGGING_I_LOGEVENTDATA_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
