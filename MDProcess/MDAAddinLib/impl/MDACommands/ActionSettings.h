////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAAddinLib/impl/MDACommands/ActionSettings.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Settings::Class>> MDProcess::MDAAddinLib::MDACommands::ActionSettings
//
// ���������, ��� ���������� �������� �� �������� ����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_MDACOMMANDS_ACTIONSETTINGS_H__
#define __MDPROCESS_MDAADDINLIB_MDACOMMANDS_ACTIONSETTINGS_H__

#include "shared/CoreSrv/sys/std_inc.h"

namespace MDACommands {

// ���������, ��� ���������� �������� �� �������� ����
class ActionSettings {

// static member methods and data
public:
	// ���� �������� ������������ �������� ��� ����-����� �� ������
	static const std::string get_class_dbl_click_action () /* throw (Core::ParameterIsMissing) */;
	static void set_class_dbl_click_action (const std::string& value);
	static const char* class_dbl_click_action_param_name ();

	// ���� �������� ������������ �������� ��� ����-����� �� ������
	static const std::string get_package_dbl_click_action () /* throw (Core::ParameterIsMissing) */;
	static void set_package_dbl_click_action (const std::string& value);
	static const char* package_dbl_click_action_param_name ();

}; // class ActionSettings

} // namespace MDACommands


#endif //__MDPROCESS_MDAADDINLIB_MDACOMMANDS_ACTIONSETTINGS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

