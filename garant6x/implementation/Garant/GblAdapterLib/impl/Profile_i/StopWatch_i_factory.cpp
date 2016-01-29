////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Profile_i/StopWatch_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Profile_i::StopWatch_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Profile_i/StopWatch_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Profile_i/StopWatch_i.h"

namespace GblAdapterLib {

StopWatch_i_factory::StopWatch_i_factory () {
}

void StopWatch_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	StopWatchFactoryManager::register_factory (this, priority);
}

const char* StopWatch_i_factory::key () const {
	return "StopWatch_i";
}

StopWatch* StopWatch_i_factory::make (const char* context) {
	StopWatch_i_var ret = new StopWatch_i (context);
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

