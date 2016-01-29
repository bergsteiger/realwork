////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Logging_i/LogManager_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Logging_i::LogManager_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Logging_i/LogManager_i.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

LogManager_i::LogManager_i ()
//#UC START# *45ED59950191_45ED5A0A021D_45ED5B070248_BASE_INIT*
//#UC END# *45ED59950191_45ED5A0A021D_45ED5B070248_BASE_INIT*
{
	//#UC START# *45ED59950191_45ED5A0A021D_45ED5B070248_BODY*
	//#UC END# *45ED59950191_45ED5A0A021D_45ED5B070248_BODY*
}

LogManager_i::~LogManager_i () {
	//#UC START# *45ED5B070248_DESTR_BODY*
	//#UC END# *45ED5B070248_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from LogManager
void LogManager_i::add_event (LogEvent log_event, LogEventData* data) {
	//#UC START# *45ED59950192_45ED5B070248*
	data->write_to_log (log_event);
	//#UC END# *45ED59950192_45ED5B070248*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

