////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Monitoring_i/MonitoringList_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Monitoring_i::MonitoringList_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Monitoring_i/MonitoringList_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Monitoring_i/MonitoringList_i.h"

namespace GblAdapterLib {

MonitoringList_i_factory::MonitoringList_i_factory () {
}

void MonitoringList_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	MonitoringListFactoryManager::register_factory (this, priority);
}

const char* MonitoringList_i_factory::key () const {
	return "MonitoringList_i";
}

MonitoringList* MonitoringList_i_factory::make (GblDocList::DocListTree* server_list, unsigned long document_count) {
	MonitoringList_i_var ret = new MonitoringList_i (server_list, document_count);
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

