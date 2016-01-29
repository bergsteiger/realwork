////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/SahiTestLib/TestPlaceSettings.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Settings::Class>> MDProcess::SahiTestLib::TestPerformer::TestPlaceSettings
//
// ��� ����� ���������� ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_SAHITESTLIB_TESTPERFORMER_TESTPLACESETTINGS_H__
#define __MDPROCESS_SAHITESTLIB_TESTPERFORMER_TESTPLACESETTINGS_H__

#include "shared/CoreSrv/sys/std_inc.h"

namespace SahiTestLib {

// ��� ����� ���������� ������
class TestPlaceSettings {

// static member methods and data
public:
	// �������� ���� � ������, ��� ����� ���������� ������ � �� ��������� ����
	static const std::string get_prefix_path () /* throw (Core::ParameterIsMissing) */;
	static void set_prefix_path (const std::string& value);
	static const char* prefix_path_param_name ();

}; // class TestPlaceSettings

} // namespace SahiTestLib


#endif //__MDPROCESS_SAHITESTLIB_TESTPERFORMER_TESTPLACESETTINGS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

