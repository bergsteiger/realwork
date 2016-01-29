////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/SahiTestLib/SahiSettings.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Settings::Class>> MDProcess::SahiTestLib::TestPerformer::SahiSettings
//
// ��������� ������ sahi
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_SAHITESTLIB_TESTPERFORMER_SAHISETTINGS_H__
#define __MDPROCESS_SAHITESTLIB_TESTPERFORMER_SAHISETTINGS_H__

#include "shared/CoreSrv/sys/std_inc.h"

namespace SahiTestLib {

// ��������� ������ sahi
class SahiSettings {

// static member methods and data
public:
	// bat-���� ����������� ����� sahi
	static const std::string get_bat_file_path () /* throw (Core::ParameterIsMissing) */;
	static void set_bat_file_path (const std::string& value);
	static const char* bat_file_path_param_name ();

	// ���������� ������ sahi � ��������� �����
	static const std::string get_text_file_path () /* throw (Core::ParameterIsMissing) */;
	static void set_text_file_path (const std::string& value);
	static const char* text_file_path_param_name ();

}; // class SahiSettings

} // namespace SahiTestLib


#endif //__MDPROCESS_SAHITESTLIB_TESTPERFORMER_SAHISETTINGS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

