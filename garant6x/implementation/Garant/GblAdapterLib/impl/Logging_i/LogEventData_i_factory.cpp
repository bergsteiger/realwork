////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Logging_i/LogEventData_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Logging_i::LogEventData_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Logging_i/LogEventData_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Logging_i/LogEventData_i.h"

namespace GblAdapterLib {

LogEventData_i_factory::LogEventData_i_factory () {
}

void LogEventData_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	LogEventDataFactoryManager::register_factory (this, priority);
}

const char* LogEventData_i_factory::key () const {
	return "LogEventData_i";
}

LogEventData* LogEventData_i_factory::make () {
	LogEventData_i_var ret = new LogEventData_i ();
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

