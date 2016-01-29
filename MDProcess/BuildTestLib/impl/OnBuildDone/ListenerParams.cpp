////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/BuildTestLib/impl/OnBuildDone/ListenerParams.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Settings::Class>> MDProcess::BuildTestLib::OnBuildDone::ListenerParams
//
// настройки копирования файлов сборки
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/Params/Params.h"
#include "MDProcess/BuildTestLib/impl/OnBuildDone/ListenerParams.h"

namespace BuildTestLib {
namespace OnBuildDone {

const std::string ListenerParams::get_local_path () {
	return Core::ParamManagerFactory::get ().get_string ("-local_path", "C:/DATA/work/build");
}

void ListenerParams::set_local_path (const std::string& value) {
	Core::ParamManagerFactory::get ().set_string ("-local_path", value.c_str());
}

const char* ListenerParams::local_path_param_name () {
	return "-local_path";
}

const std::string ListenerParams::get_script_name () {
	return Core::ParamManagerFactory::get ().get_string ("-script_name", "run.bat");
}

void ListenerParams::set_script_name (const std::string& value) {
	Core::ParamManagerFactory::get ().set_string ("-script_name", value.c_str());
}

const char* ListenerParams::script_name_param_name () {
	return "-script_name";
}

const std::string ListenerParams::get_release_name () {
	if (false == Core::ParamManagerFactory::get ().is_exist ("-release_name")) {
		throw Core::ParameterIsMissing ("-release_name");
	}
	return Core::ParamManagerFactory::get ().get_string ("-release_name");
}

void ListenerParams::set_release_name (const std::string& value) {
	Core::ParamManagerFactory::get ().set_string ("-release_name", value.c_str());
}

const char* ListenerParams::release_name_param_name () {
	return "-release_name";
}

} // namespace OnBuildDone
} // namespace BuildTestLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
