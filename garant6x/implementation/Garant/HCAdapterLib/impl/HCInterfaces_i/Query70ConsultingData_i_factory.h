////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/HCAdapterLib/impl/HCInterfaces_i/Query70ConsultingData_i_factory.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::HCAdapterLib::HCInterfaces_i::Query70ConsultingData_i
// �������� ���������� ������ ���������  ��� �������� Query70ConsultingData_i
//
// ���������� ���������� ������� ��� �� �������� 2007 ���� (�1 ������ 7.0).
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_HCADAPTERLIB_HCINTERFACES_I_QUERY70CONSULTINGDATA_I_FCTR_H__
#define __GARANT6X_HCADAPTERLIB_HCINTERFACES_I_QUERY70CONSULTINGDATA_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/HCAdapterLib/HCInterfaces/HCInterfacesFactories.h"

namespace HCAdapterLib {
namespace HCInterfaces_i {

/// Interface-factory implementation for Query70ConsultingData_i
class Query70ConsultingData_i_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public HCInterfaces::OnlineDataAbstractFactory
{
public:
	Query70ConsultingData_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	HCInterfaces::OnlineData* make (GCI::IO::Stream* xml_stream, const GblConsultingDef::ConsultationID& consultation_id);

};

typedef ::Core::Var<Query70ConsultingData_i_factory> Query70ConsultingData_i_factory_var;

} // namespace HCInterfaces_i
} // namespace HCAdapterLib


#endif //__GARANT6X_HCADAPTERLIB_HCINTERFACES_I_QUERY70CONSULTINGDATA_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

