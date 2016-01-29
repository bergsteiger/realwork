////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/BuildTestLib/impl/OnBuildDone/KLoginParams.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Settings::Class>> MDProcess::BuildTestLib::OnBuildDone::KLoginParams
//
// настройки логина в К
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_BUILDTESTLIB_ONBUILDDONE_KLOGINPARAMS_H__
#define __MDPROCESS_BUILDTESTLIB_ONBUILDDONE_KLOGINPARAMS_H__

#include "shared/CoreSrv/sys/std_inc.h"

namespace BuildTestLib {
namespace OnBuildDone {

// настройки логина в К
class KLoginParams {

// static member methods and data
public:
	// логин/пароль под которым BuildTestServer входит в К
	static const std::string get_login () /* throw (Core::ParameterIsMissing) */;
	static void set_login (const std::string& value);
	static const char* login_param_name ();

	// логин/пароль под которым BuildTestServer входит в К
	static const std::string get_password () /* throw (Core::ParameterIsMissing) */;
	static void set_password (const std::string& value);
	static const char* password_param_name ();

}; // class KLoginParams

} // namespace OnBuildDone
} // namespace BuildTestLib


#endif //__MDPROCESS_BUILDTESTLIB_ONBUILDDONE_KLOGINPARAMS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

