////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/KPageToolLib/Settings.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Settings::Class>> MDProcess::KPageToolLib::LibSupport::Settings
//
// ���� ��������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_KPAGETOOLLIB_LIBSUPPORT_SETTINGS_H__
#define __MDPROCESS_KPAGETOOLLIB_LIBSUPPORT_SETTINGS_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/KPageToolLib/Actions/Actions.h"

namespace KPageToolLib {

// ���� ��������
class Settings {

// static member methods and data
public:
	// ���� �� �����, ����������� ������ ��� ���������� �������
	static const std::string get_file () /* throw (Core::ParameterIsMissing) */;
	static void set_file (const std::string& value);
	static const char* file_param_name ();

	// ����� ��� ����������� �� ������ �
	static const std::string get_login () /* throw (Core::ParameterIsMissing) */;
	static void set_login (const std::string& value);
	static const char* login_param_name ();

	// ��������, ������� ����� ���������, �������� �������, ����������� � ��������� �������������� �
	// ������������, ��������� �� ������������ �������� � ���� ���������.
	static const Actions::PageActionsEnum get_operation () /* throw (Core::ParameterIsMissing) */;
	static void set_operation (Actions::PageActionsEnum value);
	static const char* operation_param_name ();

	// ID ��������, �������� ����� ���������
	static const unsigned long get_page_id () /* throw (Core::ParameterIsMissing) */;
	static void set_page_id (unsigned long value);
	static const char* page_id_param_name ();

	// ������ ��� ����������� �� ������� �
	static const std::string get_password () /* throw (Core::ParameterIsMissing) */;
	static void set_password (const std::string& value);
	static const char* password_param_name ();

}; // class Settings

} // namespace KPageToolLib


#endif //__MDPROCESS_KPAGETOOLLIB_LIBSUPPORT_SETTINGS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

