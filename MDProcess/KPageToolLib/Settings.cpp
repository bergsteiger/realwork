////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/KPageToolLib/Settings.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Settings::Class>> MDProcess::KPageToolLib::LibSupport::Settings
//
// Блок настроек
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/Params/Params.h"
#include "MDProcess/KPageToolLib/Settings.h"

namespace KPageToolLib {

const std::string Settings::get_login () {
	if (false == Core::ParamManagerFactory::get ().is_exist ("-login")) {
		throw Core::ParameterIsMissing ("-login");
	}
	return Core::ParamManagerFactory::get ().get_string ("-login");
}

void Settings::set_login (const std::string& value) {
	Core::ParamManagerFactory::get ().set_string ("-login", value.c_str());
}

const char* Settings::login_param_name () {
	return "-login";
}

const std::string Settings::get_password () {
	if (false == Core::ParamManagerFactory::get ().is_exist ("-password")) {
		throw Core::ParameterIsMissing ("-password");
	}
	return Core::ParamManagerFactory::get ().get_string ("-password");
}

void Settings::set_password (const std::string& value) {
	Core::ParamManagerFactory::get ().set_string ("-password", value.c_str());
}

const char* Settings::password_param_name () {
	return "-password";
}

const Actions::PageActionsEnum Settings::get_operation () {
	if (false == Core::ParamManagerFactory::get ().is_exist ("-operation")) {
		throw Core::ParameterIsMissing ("-operation");
	}
	std::string enum_val = Core::ParamManagerFactory::get ().get_string ("-operation");
	if (enum_val == "PA_GET") return Actions::PA_GET;
	if (enum_val == "PA_SET") return Actions::PA_SET;
	if (enum_val == "PA_APPEND") return Actions::PA_APPEND;
	if (enum_val == "PA_ATTACH") return Actions::PA_ATTACH;
	if (enum_val == "PA_GET_LABEL") return Actions::PA_GET_LABEL;
	if (enum_val == "PA_SET_LABEL") return Actions::PA_SET_LABEL;
	
	throw Core::ParameterIsMissing ("-operation");
}

void Settings::set_operation (Actions::PageActionsEnum value) {
	std::string enum_val;
	switch (value) {
		case Actions::PA_GET: enum_val = "PA_GET";
			break;
		case Actions::PA_SET: enum_val = "PA_SET";
			break;
		case Actions::PA_APPEND: enum_val = "PA_APPEND";
			break;
		case Actions::PA_ATTACH: enum_val = "PA_ATTACH";
			break;
		case Actions::PA_GET_LABEL: enum_val = "PA_GET_LABEL";
			break;
		case Actions::PA_SET_LABEL: enum_val = "PA_SET_LABEL";
			break;
		default: break;
	}
	Core::ParamManagerFactory::get ().set_string("-operation", enum_val.c_str());
}

const char* Settings::operation_param_name () {
	return "-operation";
}

const unsigned long Settings::get_page_id () {
	if (false == Core::ParamManagerFactory::get ().is_exist ("-page_id")) {
		throw Core::ParameterIsMissing ("-page_id");
	}
	return Core::ParamManagerFactory::get ().get_ulong ("-page_id");
}

void Settings::set_page_id (unsigned long value) {
	Core::ParamManagerFactory::get ().set_ulong ("-page_id", value);
}

const char* Settings::page_id_param_name () {
	return "-page_id";
}

const std::string Settings::get_file () {
	if (false == Core::ParamManagerFactory::get ().is_exist ("-file")) {
		throw Core::ParameterIsMissing ("-file");
	}
	return Core::ParamManagerFactory::get ().get_string ("-file");
}

void Settings::set_file (const std::string& value) {
	Core::ParamManagerFactory::get ().set_string ("-file", value.c_str());
}

const char* Settings::file_param_name () {
	return "-file";
}

} // namespace KPageToolLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
