////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/SahiTestLib/TestPlaceSettings.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Settings::Class>> MDProcess::SahiTestLib::TestPerformer::TestPlaceSettings
//
// где лежат результаты тестов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/Params/Params.h"
#include "MDProcess/SahiTestLib/TestPlaceSettings.h"

namespace SahiTestLib {

const std::string TestPlaceSettings::get_prefix_path () {
	if (false == Core::ParamManagerFactory::get ().is_exist ("-prefix_path")) {
		throw Core::ParameterIsMissing ("-prefix_path");
	}
	return Core::ParamManagerFactory::get ().get_string ("-prefix_path");
}

void TestPlaceSettings::set_prefix_path (const std::string& value) {
	Core::ParamManagerFactory::get ().set_string ("-prefix_path", value.c_str());
}

const char* TestPlaceSettings::prefix_path_param_name () {
	return "-prefix_path";
}

} // namespace SahiTestLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
