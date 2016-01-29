////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/CoreSrv/Root/ServerSettings.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Settings::Class>> shared::CoreSrv::Root::ServerSettings
//
// Настройки для инициализации сереверного фрэймворка
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/Params/Params.h"
#include "shared/CoreSrv/Root/ServerSettings.h"

namespace CoreSrv {
namespace Root {

const std::string ServerSettings::get_orb_init_ref () {
	if (false == Core::ParamManagerFactory::get ().is_exist ("-ORBInitRef")) {
		throw Core::ParameterIsMissing ("-ORBInitRef");
	}
	return Core::ParamManagerFactory::get ().get_string ("-ORBInitRef");
}

void ServerSettings::set_orb_init_ref (const std::string& value) {
	Core::ParamManagerFactory::get ().set_string ("-ORBInitRef", value.c_str());
}

const char* ServerSettings::orb_init_ref_param_name () {
	return "-ORBInitRef";
}

const std::string ServerSettings::get_ns_context () {
	if (false == Core::ParamManagerFactory::get ().is_exist ("-NSContext")) {
		throw Core::ParameterIsMissing ("-NSContext");
	}
	return Core::ParamManagerFactory::get ().get_string ("-NSContext");
}

void ServerSettings::set_ns_context (const std::string& value) {
	Core::ParamManagerFactory::get ().set_string ("-NSContext", value.c_str());
}

const char* ServerSettings::ns_context_param_name () {
	return "-NSContext";
}

} // namespace Root
} // namespace CoreSrv

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
