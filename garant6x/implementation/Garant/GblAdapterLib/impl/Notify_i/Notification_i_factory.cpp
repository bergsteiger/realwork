////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Notify_i/Notification_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Notify_i::Notification_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Notify_i/Notification_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Notify_i/Notification_i.h"

namespace GblAdapterLib {

Notification_i_factory::Notification_i_factory () {
}

void Notification_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	NotificationFactoryManager::register_factory (this, priority);
}

const char* Notification_i_factory::key () const {
	return "Notification_i";
}

Notification* Notification_i_factory::make () {
	Notification_i_var ret = new Notification_i ();
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

