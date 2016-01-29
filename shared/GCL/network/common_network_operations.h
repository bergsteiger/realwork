////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/GCL/network/common_network_operations.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::GCL::network::common_network_operations
//
// ����� ������� ��� ������ � �����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCL_NETWORK_COMMON_NETWORK_OPERATIONS_H__
#define __SHARED_GCL_NETWORK_COMMON_NETWORK_OPERATIONS_H__

#include "shared/Core/sys/std_inc.h"

//#UC START# *45753171035B_USER_INCLUDES*
//#UC END# *45753171035B_USER_INCLUDES*

namespace GCL {

// �� ������ �������� ������ ����������
class CantGetIpList : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ���������� true, ���� �� ������ ��������� ip-������, �������� �� loopback ����������
bool is_ip_adresses_configured () /*throw (CantGetIpList)*/;

//#UC START# *45753171035B_USER_DEFINITION*
//#UC END# *45753171035B_USER_DEFINITION*

} // namespace GCL


#endif //__SHARED_GCL_NETWORK_COMMON_NETWORK_OPERATIONS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
