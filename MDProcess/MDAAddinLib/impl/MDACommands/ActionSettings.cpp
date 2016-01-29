////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/impl/MDACommands/ActionSettings.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Settings::Class>> MDProcess::MDAAddinLib::MDACommands::ActionSettings
//
// параметры, для управления реакцией на действия мыши
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/Params/Params.h"
#include "MDProcess/MDAAddinLib/impl/MDACommands/ActionSettings.h"

namespace MDACommands {

const std::string ActionSettings::get_class_dbl_click_action () {
	return Core::ParamManagerFactory::get ().get_string ("-ClassDblClickAction", "OPEN_DIAGRAM_IF_EXISTS_ELSE_PROPERTIES");
}

void ActionSettings::set_class_dbl_click_action (const std::string& value) {
	Core::ParamManagerFactory::get ().set_string ("-ClassDblClickAction", value.c_str());
}

const char* ActionSettings::class_dbl_click_action_param_name () {
	return "-ClassDblClickAction";
}

const std::string ActionSettings::get_package_dbl_click_action () {
	return Core::ParamManagerFactory::get ().get_string ("-PackageDblClickAction", "OPEN_DIAGRAM");
}

void ActionSettings::set_package_dbl_click_action (const std::string& value) {
	Core::ParamManagerFactory::get ().set_string ("-PackageDblClickAction", value.c_str());
}

const char* ActionSettings::package_dbl_click_action_param_name () {
	return "-PackageDblClickAction";
}

} // namespace MDACommands

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
