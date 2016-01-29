////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/SahiTestLib/SahiSettings.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Settings::Class>> MDProcess::SahiTestLib::TestPerformer::SahiSettings
//
// настройки тестов sahi
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/Params/Params.h"
#include "MDProcess/SahiTestLib/SahiSettings.h"

namespace SahiTestLib {

const std::string SahiSettings::get_bat_file_path () {
	if (false == Core::ParamManagerFactory::get ().is_exist ("-bat_file_path")) {
		throw Core::ParameterIsMissing ("-bat_file_path");
	}
	return Core::ParamManagerFactory::get ().get_string ("-bat_file_path");
}

void SahiSettings::set_bat_file_path (const std::string& value) {
	Core::ParamManagerFactory::get ().set_string ("-bat_file_path", value.c_str());
}

const char* SahiSettings::bat_file_path_param_name () {
	return "-bat_file_path";
}

const std::string SahiSettings::get_text_file_path () {
	if (false == Core::ParamManagerFactory::get ().is_exist ("-text_file_path")) {
		throw Core::ParameterIsMissing ("-text_file_path");
	}
	return Core::ParamManagerFactory::get ().get_string ("-text_file_path");
}

void SahiSettings::set_text_file_path (const std::string& value) {
	Core::ParamManagerFactory::get ().set_string ("-text_file_path", value.c_str());
}

const char* SahiSettings::text_file_path_param_name () {
	return "-text_file_path";
}

} // namespace SahiTestLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
