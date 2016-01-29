////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Monitoring_i/MonitoringManager_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Monitoring_i::MonitoringManager_i
// Заголовк реализации фабрик интерфеса Monitoring для серванта MonitoringManager_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_MONITORING_I_MONITORINGMANAGER_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_MONITORING_I_MONITORINGMANAGER_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Monitoring/MonitoringFactories.h"

namespace GblAdapterLib {

/// Interface-factory implementation for MonitoringManager_i
class MonitoringManager_i_factory: virtual public ::Core::RefCountObjectBase, virtual public MonitoringAbstractFactory {
public:
	MonitoringManager_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	Monitoring* make ();

};

typedef ::Core::Var<MonitoringManager_i_factory> MonitoringManager_i_factory_var;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_MONITORING_I_MONITORINGMANAGER_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

