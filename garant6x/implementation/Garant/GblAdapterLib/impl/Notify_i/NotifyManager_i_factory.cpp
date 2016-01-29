////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Notify_i/NotifyManager_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Notify_i::NotifyManager_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Notify_i/NotifyManager_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Notify_i/NotifyManager_i.h"

namespace GblAdapterLib {

NotifyManager_i_factory::NotifyManager_i_factory () {
}

void NotifyManager_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	NotifyManagerFactoryManager::register_factory (this, priority);
}

const char* NotifyManager_i_factory::key () const {
	return "NotifyManager_i";
}

NotifyManager* NotifyManager_i_factory::make () {
	NotifyManager_i_var ret = new NotifyManager_i ();
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

