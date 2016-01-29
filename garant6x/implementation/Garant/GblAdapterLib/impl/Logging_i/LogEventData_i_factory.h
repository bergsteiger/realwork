////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Logging_i/LogEventData_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Logging_i::LogEventData_i
// Заголовк реализации фабрик интерфеса LogEventData для серванта LogEventData_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_LOGGING_I_LOGEVENTDATA_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_LOGGING_I_LOGEVENTDATA_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Logging/LoggingFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Logging_i/Logging_i.h"

namespace GblAdapterLib {

/// Interface-factory implementation for LogEventData_i
class LogEventData_i_factory: virtual public ::Core::RefCountObjectBase, virtual public LogEventDataAbstractFactory {
public:
	LogEventData_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	LogEventData* make ();

};

typedef ::Core::Var<LogEventData_i_factory> LogEventData_i_factory_var;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_LOGGING_I_LOGEVENTDATA_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

