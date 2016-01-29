////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Monitoring/Monitoring.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Monitoring
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Monitoring/Monitoring.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Monitoring/MonitoringFactories.h"

namespace GblAdapterLib {

// factory interface wrapper for MonitoringList
MonitoringList* MonitoringListFactory::make (
	GblDocList::DocListTree* server_list
	, unsigned long document_count
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return MonitoringListFactoryManager::Singleton::instance ()->make (server_list, document_count);
}

// factory interface wrapper for Monitoring
Monitoring* MonitoringFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return MonitoringFactoryManager::Singleton::instance ()->make ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

