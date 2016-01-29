////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAAddinLib/impl/Addin_i/Settings.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Settings::Class>> MDProcess::MDAAddinLib::Addin_i::Settings
//
// ��������� ����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_ADDIN_I_SETTINGS_H__
#define __MDPROCESS_MDAADDINLIB_ADDIN_I_SETTINGS_H__

#include "shared/CoreSrv/sys/std_inc.h"


// ��������� ����������
class Settings {

// static member methods and data
public:
	// ���� � ���-�����
	static const std::string get_log_file () /* throw (Core::ParameterIsMissing) */;
	static void set_log_file (const std::string& value);
	static const char* log_file_param_name ();

	// ����� �������� � ��. ����� ������� ����������� ���������
	static const unsigned long get_tooltip_initial_delay () /* throw (Core::ParameterIsMissing) */;
	static void set_tooltip_initial_delay (unsigned long value);
	static const char* tooltip_initial_delay_param_name ();

	// ���� � �������� ����������, ������� ������ ���� ��������
	static const std::string get_external_command_path () /* throw (Core::ParameterIsMissing) */;
	static void set_external_command_path (const std::string& value);
	static const char* external_command_path_param_name ();

}; // class Settings



#endif //__MDPROCESS_MDAADDINLIB_ADDIN_I_SETTINGS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

