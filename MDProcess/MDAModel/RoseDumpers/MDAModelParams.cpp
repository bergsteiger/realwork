////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseDumpers/MDAModelParams.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Settings::Class>> MDProcess::MDAModel::RoseDumpers::MDAModelParams
//
// настройки
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/Params/Params.h"
#include "MDProcess/MDAModel/RoseDumpers/MDAModelParams.h"


const std::string MDAModelParams::get_templates_dir () {
	return Core::ParamManagerFactory::get ().get_string ("-TemplatesDir", "C:\\Program Files\\Rational\\Rose\\Garant\\MDAGenerator\\templates\\");
}

void MDAModelParams::set_templates_dir (const std::string& value) {
	Core::ParamManagerFactory::get ().set_string ("-TemplatesDir", value.c_str());
}

const char* MDAModelParams::templates_dir_param_name () {
	return "-TemplatesDir";
}

const std::string MDAModelParams::get_image_dir () {
	return Core::ParamManagerFactory::get ().get_string ("-ImageDir", "C:\\Program Files\\Rational\\Rose\\Garant\\MDAGenerator\\images\\");
}

void MDAModelParams::set_image_dir (const std::string& value) {
	Core::ParamManagerFactory::get ().set_string ("-ImageDir", value.c_str());
}

const char* MDAModelParams::image_dir_param_name () {
	return "-ImageDir";
}

const std::string MDAModelParams::get_path_component_to_control () {
	return Core::ParamManagerFactory::get ().get_string ("-PathComponentToControl", "shared\\models");
}

void MDAModelParams::set_path_component_to_control (const std::string& value) {
	Core::ParamManagerFactory::get ().set_string ("-PathComponentToControl", value.c_str());
}

const char* MDAModelParams::path_component_to_control_param_name () {
	return "-PathComponentToControl";
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
