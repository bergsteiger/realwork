////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/CoreSrv/Root/ServerSettings.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Settings::Class>> shared::CoreSrv::Root::ServerSettings
//
// ��������� ��� ������������� ����������� ����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORESRV_ROOT_SERVERSETTINGS_H__
#define __SHARED_CORESRV_ROOT_SERVERSETTINGS_H__

#include "shared/Core/sys/std_inc.h"

namespace CoreSrv {
namespace Root {

// ��������� ��� ������������� ����������� ����������
class ServerSettings {

// static member methods and data
public:
	// ��� ��������� ��� NameService (������ namespace'�)
	static const std::string get_ns_context () /* throw (Core::ParameterIsMissing) */;
	static void set_ns_context (const std::string& value);
	static const char* ns_context_param_name ();

	// ������ ������������� ORB'� (�������� ����� NameService)
	static const std::string get_orb_init_ref () /* throw (Core::ParameterIsMissing) */;
	static void set_orb_init_ref (const std::string& value);
	static const char* orb_init_ref_param_name ();

}; // class ServerSettings

} // namespace Root
} // namespace CoreSrv


#endif //__SHARED_CORESRV_ROOT_SERVERSETTINGS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

