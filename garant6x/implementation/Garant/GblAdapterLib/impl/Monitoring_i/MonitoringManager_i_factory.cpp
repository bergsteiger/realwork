////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Monitoring_i/MonitoringManager_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Monitoring_i::MonitoringManager_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Monitoring_i/MonitoringManager_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Monitoring_i/MonitoringManager_i.h"

namespace GblAdapterLib {

MonitoringManager_i_factory::MonitoringManager_i_factory () {
}

void MonitoringManager_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	MonitoringFactoryManager::register_factory (this, priority);
}

const char* MonitoringManager_i_factory::key () const {
	return "MonitoringManager_i";
}

Monitoring* MonitoringManager_i_factory::make () {
	MonitoringManager_i_var ret = new MonitoringManager_i ();
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

