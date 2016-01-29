////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/BuildTestLib/impl/OnBuildDone/KLoginParams.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Settings::Class>> MDProcess::BuildTestLib::OnBuildDone::KLoginParams
//
// настройки логина в К
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/Params/Params.h"
#include "MDProcess/BuildTestLib/impl/OnBuildDone/KLoginParams.h"

namespace BuildTestLib {
namespace OnBuildDone {

const std::string KLoginParams::get_login () {
	return Core::ParamManagerFactory::get ().get_string ("-login", "tester");
}

void KLoginParams::set_login (const std::string& value) {
	Core::ParamManagerFactory::get ().set_string ("-login", value.c_str());
}

const char* KLoginParams::login_param_name () {
	return "-login";
}

const std::string KLoginParams::get_password () {
	if (false == Core::ParamManagerFactory::get ().is_exist ("-password")) {
		throw Core::ParameterIsMissing ("-password");
	}
	return Core::ParamManagerFactory::get ().get_string ("-password");
}

void KLoginParams::set_password (const std::string& value) {
	Core::ParamManagerFactory::get ().set_string ("-password", value.c_str());
}

const char* KLoginParams::password_param_name () {
	return "-password";
}

} // namespace OnBuildDone
} // namespace BuildTestLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
