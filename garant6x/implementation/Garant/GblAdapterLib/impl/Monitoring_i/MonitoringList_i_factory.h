////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Monitoring_i/MonitoringList_i_factory.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Monitoring_i::MonitoringList_i
// �������� ���������� ������ ��������� MonitoringList ��� �������� MonitoringList_i
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_MONITORING_I_MONITORINGLIST_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_MONITORING_I_MONITORINGLIST_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Monitoring/MonitoringFactories.h"

namespace GblAdapterLib {

/// Interface-factory implementation for MonitoringList_i
class MonitoringList_i_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public MonitoringListAbstractFactory
{
public:
	MonitoringList_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	MonitoringList* make (GblDocList::DocListTree* server_list, unsigned long document_count);

};

typedef ::Core::Var<MonitoringList_i_factory> MonitoringList_i_factory_var;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_MONITORING_I_MONITORINGLIST_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

