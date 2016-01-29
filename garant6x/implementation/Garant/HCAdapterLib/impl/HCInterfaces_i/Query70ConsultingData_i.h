////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/HCAdapterLib/impl/HCInterfaces_i/Query70ConsultingData_i.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::HCAdapterLib::HCInterfaces_i::Query70ConsultingData_i
// ��������� ���������� ������ �������� ��� ��������� 
//
// ���������� ���������� ������� ��� �� �������� 2007 ���� (�1 ������ 7.0).
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_HCADAPTERLIB_HCINTERFACES_I_QUERY70CONSULTINGDATA_I_H__
#define __GARANT6X_HCADAPTERLIB_HCINTERFACES_I_QUERY70CONSULTINGDATA_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/HCAdapterLib/HCInterfaces/HCInterfaces.h"
#include "garant6x/implementation/Garant/HCAdapterLib/impl/HCInterfaces_i/ConsultingData_i.h"

//#UC START# *46BB2250035B_CUSTOM_INCLUDES*
//#UC END# *46BB2250035B_CUSTOM_INCLUDES*

namespace HCAdapterLib {
namespace HCInterfaces_i {

class Query70ConsultingData_i; // self forward Var
typedef ::Core::Var<Query70ConsultingData_i> Query70ConsultingData_i_var;
typedef ::Core::Var<const Query70ConsultingData_i> Query70ConsultingData_i_cvar;

class Query70ConsultingData_i_factory;

// ���������� ���������� ������� ��� �� �������� 2007 ���� (�1 ������ 7.0).
class Query70ConsultingData_i:
	virtual public ConsultingData_i
{
	SET_OBJECT_COUNTER (Query70ConsultingData_i)
	friend class Query70ConsultingData_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
private:
	Query70ConsultingData_i (GCI::IO::Stream* xml_stream, const GblConsultingDef::ConsultationID& consultation_id);

	~Query70ConsultingData_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from HCInterfaces::ConsultingData
	// ������������� ��������� ������ �������� �������. ��� ������ ����� ������ ������ ���������� ���
	// ���������� �� ��������� (��� ��������� ������, ��� ��������� ������������).
	void data_received () const;

//#UC START# *46BB2250035B*
//#UC END# *46BB2250035B*
}; // class Query70ConsultingData_i

} // namespace HCInterfaces_i
} // namespace HCAdapterLib


#endif //__GARANT6X_HCADAPTERLIB_HCINTERFACES_I_QUERY70CONSULTINGDATA_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
