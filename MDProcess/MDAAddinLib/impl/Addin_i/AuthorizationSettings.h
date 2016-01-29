////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/impl/Addin_i/AuthorizationSettings.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Settings::Class>> MDProcess::MDAAddinLib::Addin_i::AuthorizationSettings
//
// параметры авторизации на сервере MDP
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_ADDIN_I_AUTHORIZATIONSETTINGS_H__
#define __MDPROCESS_MDAADDINLIB_ADDIN_I_AUTHORIZATIONSETTINGS_H__

#include "shared/CoreSrv/sys/std_inc.h"


// параметры авторизации на сервере MDP
class AuthorizationSettings {

// static member methods and data
public:
	static const std::string get_saved_mdp_login () /* throw (Core::ParameterIsMissing) */;
	static void set_saved_mdp_login (const std::string& value);
	static const char* saved_mdp_login_param_name ();

	static const std::string get_saved_mdp_paswd () /* throw (Core::ParameterIsMissing) */;
	static void set_saved_mdp_paswd (const std::string& value);
	static const char* saved_mdp_paswd_param_name ();

	static const unsigned long get_use_saved_mdp_auth () /* throw (Core::ParameterIsMissing) */;
	static void set_use_saved_mdp_auth (unsigned long value);
	static const char* use_saved_mdp_auth_param_name ();

}; // class AuthorizationSettings



#endif //__MDPROCESS_MDAADDINLIB_ADDIN_I_AUTHORIZATIONSETTINGS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

