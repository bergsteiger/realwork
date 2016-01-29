////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/BuildTestLib/impl/OnBuildDone/KLoginParams.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Settings::Class>> MDProcess::BuildTestLib::OnBuildDone::KLoginParams
//
// ��������� ������ � �
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_BUILDTESTLIB_ONBUILDDONE_KLOGINPARAMS_H__
#define __MDPROCESS_BUILDTESTLIB_ONBUILDDONE_KLOGINPARAMS_H__

#include "shared/CoreSrv/sys/std_inc.h"

namespace BuildTestLib {
namespace OnBuildDone {

// ��������� ������ � �
class KLoginParams {

// static member methods and data
public:
	// �����/������ ��� ������� BuildTestServer ������ � �
	static const std::string get_login () /* throw (Core::ParameterIsMissing) */;
	static void set_login (const std::string& value);
	static const char* login_param_name ();

	// �����/������ ��� ������� BuildTestServer ������ � �
	static const std::string get_password () /* throw (Core::ParameterIsMissing) */;
	static void set_password (const std::string& value);
	static const char* password_param_name ();

}; // class KLoginParams

} // namespace OnBuildDone
} // namespace BuildTestLib


#endif //__MDPROCESS_BUILDTESTLIB_ONBUILDDONE_KLOGINPARAMS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

