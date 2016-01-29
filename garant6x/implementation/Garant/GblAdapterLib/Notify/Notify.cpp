////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Notify/Notify.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Notify
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Notify/Notify.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Notify/NotifyFactories.h"

namespace GblAdapterLib {

// factory interface wrapper for Notification
Notification* NotificationFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return NotificationFactoryManager::Singleton::instance ()->make ();
}

// factory interface wrapper for NotifyManager
NotifyManager& NotifyManagerFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return NotifyManagerFactoryManager::Singleton::instance ()->make ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

