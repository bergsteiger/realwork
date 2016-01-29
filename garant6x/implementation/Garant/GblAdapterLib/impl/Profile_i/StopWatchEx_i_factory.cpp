////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Profile_i/StopWatchEx_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Profile_i::StopWatchEx_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Profile_i/StopWatchEx_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Profile_i/StopWatchEx_i.h"

namespace GblAdapterLib {

StopWatchEx_i_factory::StopWatchEx_i_factory () {
}

void StopWatchEx_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	StopWatchExFactoryManager::register_factory (this, priority);
}

const char* StopWatchEx_i_factory::key () const {
	return "StopWatchEx_i";
}

StopWatchEx* StopWatchEx_i_factory::make (const char* id, const char* context) {
	StopWatchEx_i_var ret = new StopWatchEx_i (id, context);
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

