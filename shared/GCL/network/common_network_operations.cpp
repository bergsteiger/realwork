////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/GCL/network/common_network_operations.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::GCL::network::common_network_operations
// ���� ���������� ���������� ������ common_network_operations
//
// ����� ������� ��� ������ � �����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "shared/GCL/network/common_network_operations.h"

//#UC START# *45753171035B_CUSTOM_INCLUDES*
#include "ace/INET_Addr.h"
//#UC END# *45753171035B_CUSTOM_INCLUDES*

namespace GCL {

//#UC START# *45753171035B*
//#UC END# *45753171035B*

//////////////////////////////////////////////////////////////////////////////////////////
// public member implementation


const char* CantGetIpList::uid () const /*throw ()*/ {
	return "5BD9D9D8-387F-4853-88C0-7A4CB1D5AFCD";
}

const char* CantGetIpList::what () const throw () {
	//#UC START# *457536350128_WHAT_IMPL*
	return "CantGetIpList (�� ������ �������� ������ ����������)";
	//#UC END# *457536350128_WHAT_IMPL*
}



// ���������� true, ���� �� ������ ��������� ip-������, �������� �� loopback ����������
bool is_ip_adresses_configured () /*throw (CantGetIpList)*/ {
	//#UC START# *457531C60280*
	Core::Aptr<ACE_INET_Addr, Core::ArrayDeleteDestructor<ACE_INET_Addr> > addrs (0);
	size_t count = 0;
	if (ACE::get_ip_interfaces (count, addrs.out ()) < 0) {
		LOG_E (("%s: auto_test failed, bad list of ip interfaces", GDS_CURRENT_FUNCTION));
		throw CantGetIpList ();
	} else {
		for (size_t i = 0; i < count; ++i) {
			if (!addrs.ptr ()[i].is_loopback ()) {
				return true;
			}
		}
	}

	return false;
	//#UC END# *457531C60280*
}

} // namespace GCL

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

