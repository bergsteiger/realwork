////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/BuildSupportLib/RunSettings.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Settings::Class>> MDProcess::BuildSupportLib::LibSupport::RunSettings
//
// настройки для работы
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/Params/Params.h"
#include "MDProcess/BuildSupportLib/RunSettings.h"

namespace BuildSupportLib {

const std::string RunSettings::get_login () {
	if (false == Core::ParamManagerFactory::get ().is_exist ("-login")) {
		throw Core::ParameterIsMissing ("-login");
	}
	return Core::ParamManagerFactory::get ().get_string ("-login");
}

void RunSettings::set_login (const std::string& value) {
	Core::ParamManagerFactory::get ().set_string ("-login", value.c_str());
}

const char* RunSettings::login_param_name () {
	return "-login";
}

const std::string RunSettings::get_paswd () {
	if (false == Core::ParamManagerFactory::get ().is_exist ("-paswd")) {
		throw Core::ParameterIsMissing ("-paswd");
	}
	return Core::ParamManagerFactory::get ().get_string ("-paswd");
}

void RunSettings::set_paswd (const std::string& value) {
	Core::ParamManagerFactory::get ().set_string ("-paswd", value.c_str());
}

const char* RunSettings::paswd_param_name () {
	return "-paswd";
}

const std::string RunSettings::get_event () {
	if (false == Core::ParamManagerFactory::get ().is_exist ("-event")) {
		throw Core::ParameterIsMissing ("-event");
	}
	return Core::ParamManagerFactory::get ().get_string ("-event");
}

void RunSettings::set_event (const std::string& value) {
	Core::ParamManagerFactory::get ().set_string ("-event", value.c_str());
}

const char* RunSettings::event_param_name () {
	return "-event";
}

const std::string RunSettings::get_project () {
	if (false == Core::ParamManagerFactory::get ().is_exist ("-project")) {
		throw Core::ParameterIsMissing ("-project");
	}
	return Core::ParamManagerFactory::get ().get_string ("-project");
}

void RunSettings::set_project (const std::string& value) {
	Core::ParamManagerFactory::get ().set_string ("-project", value.c_str());
}

const char* RunSettings::project_param_name () {
	return "-project";
}

const std::string RunSettings::get_tag () {
	if (false == Core::ParamManagerFactory::get ().is_exist ("-tag")) {
		throw Core::ParameterIsMissing ("-tag");
	}
	return Core::ParamManagerFactory::get ().get_string ("-tag");
}

void RunSettings::set_tag (const std::string& value) {
	Core::ParamManagerFactory::get ().set_string ("-tag", value.c_str());
}

const char* RunSettings::tag_param_name () {
	return "-tag";
}

const std::string RunSettings::get_build () {
	if (false == Core::ParamManagerFactory::get ().is_exist ("-build")) {
		throw Core::ParameterIsMissing ("-build");
	}
	return Core::ParamManagerFactory::get ().get_string ("-build");
}

void RunSettings::set_build (const std::string& value) {
	Core::ParamManagerFactory::get ().set_string ("-build", value.c_str());
}

const char* RunSettings::build_param_name () {
	return "-build";
}

const std::string RunSettings::get_branch () {
	return Core::ParamManagerFactory::get ().get_string ("-branch", "0");
}

void RunSettings::set_branch (const std::string& value) {
	Core::ParamManagerFactory::get ().set_string ("-branch", value.c_str());
}

const char* RunSettings::branch_param_name () {
	return "-branch";
}

const std::string RunSettings::get_build_path () {
	return Core::ParamManagerFactory::get ().get_string ("-build_path", "");
}

void RunSettings::set_build_path (const std::string& value) {
	Core::ParamManagerFactory::get ().set_string ("-build_path", value.c_str());
}

const char* RunSettings::build_path_param_name () {
	return "-build_path";
}

const std::string RunSettings::get_build_log () {
	return Core::ParamManagerFactory::get ().get_string ("-build_log", "");
}

void RunSettings::set_build_log (const std::string& value) {
	Core::ParamManagerFactory::get ().set_string ("-build_log", value.c_str());
}

const char* RunSettings::build_log_param_name () {
	return "-build_log";
}

} // namespace BuildSupportLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
