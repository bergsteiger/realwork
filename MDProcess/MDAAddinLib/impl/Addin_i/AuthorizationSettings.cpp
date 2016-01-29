////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/impl/Addin_i/AuthorizationSettings.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Settings::Class>> MDProcess::MDAAddinLib::Addin_i::AuthorizationSettings
//
// параметры авторизации на сервере MDP
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/Params/Params.h"
#include "MDProcess/MDAAddinLib/impl/Addin_i/AuthorizationSettings.h"


const std::string AuthorizationSettings::get_saved_mdp_login () {
	return Core::ParamManagerFactory::get ().get_string ("-saved_mdp_login", "");
}

void AuthorizationSettings::set_saved_mdp_login (const std::string& value) {
	Core::ParamManagerFactory::get ().set_string ("-saved_mdp_login", value.c_str());
}

const char* AuthorizationSettings::saved_mdp_login_param_name () {
	return "-saved_mdp_login";
}

const std::string AuthorizationSettings::get_saved_mdp_paswd () {
	return Core::ParamManagerFactory::get ().get_string ("-saved_mdp_paswd", "");
}

void AuthorizationSettings::set_saved_mdp_paswd (const std::string& value) {
	Core::ParamManagerFactory::get ().set_string ("-saved_mdp_paswd", value.c_str());
}

const char* AuthorizationSettings::saved_mdp_paswd_param_name () {
	return "-saved_mdp_paswd";
}

const unsigned long AuthorizationSettings::get_use_saved_mdp_auth () {
	return Core::ParamManagerFactory::get ().get_ulong ("-use_saved_mdp_auth", 0);
}

void AuthorizationSettings::set_use_saved_mdp_auth (unsigned long value) {
	Core::ParamManagerFactory::get ().set_ulong ("-use_saved_mdp_auth", value);
}

const char* AuthorizationSettings::use_saved_mdp_auth_param_name () {
	return "-use_saved_mdp_auth";
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
