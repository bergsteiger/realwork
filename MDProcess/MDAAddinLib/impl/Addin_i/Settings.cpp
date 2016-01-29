////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/impl/Addin_i/Settings.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Settings::Class>> MDProcess::MDAAddinLib::Addin_i::Settings
//
// Настройки генератора
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/Params/Params.h"
#include "MDProcess/MDAAddinLib/impl/Addin_i/Settings.h"


const std::string Settings::get_log_file () {
	return Core::ParamManagerFactory::get ().get_string ("-LogFile", "C:\\Program Files\\Rational\\Rose\\Garant\\MDAGenerator\\MDAGenerator.log");
}

void Settings::set_log_file (const std::string& value) {
	Core::ParamManagerFactory::get ().set_string ("-LogFile", value.c_str());
}

const char* Settings::log_file_param_name () {
	return "-LogFile";
}

const unsigned long Settings::get_tooltip_initial_delay () {
	return Core::ParamManagerFactory::get ().get_ulong ("-TooltipInitialDelay", 3000);
}

void Settings::set_tooltip_initial_delay (unsigned long value) {
	Core::ParamManagerFactory::get ().set_ulong ("-TooltipInitialDelay", value);
}

const char* Settings::tooltip_initial_delay_param_name () {
	return "-TooltipInitialDelay";
}

const std::string Settings::get_external_command_path () {
	return Core::ParamManagerFactory::get ().get_string ("-external_command_path", "");
}

void Settings::set_external_command_path (const std::string& value) {
	Core::ParamManagerFactory::get ().set_string ("-external_command_path", value.c_str());
}

const char* Settings::external_command_path_param_name () {
	return "-external_command_path";
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
