////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/GCI/impl/I18N_i/Params.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<Settings::Class>> shared::GCI::I18N_i::Params
//
// ��������� ������ � ��������������������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "shared/Core/Params/Params.h"
#include "shared/GCI/impl/I18N_i/Params.h"

namespace GCI {
namespace I18N_i {

const std::string Params::get_locale_path () {
	if (false == Core::ParamManagerFactory::get ().is_exist ("-LocalePath")) {
		throw Core::ParameterIsMissing ("-LocalePath");
	}
	return Core::ParamManagerFactory::get ().get_string ("-LocalePath");
}

void Params::set_locale_path (const std::string& value) {
	Core::ParamManagerFactory::get ().set_string ("-LocalePath", value.c_str());
}

const char* Params::locale_path_param_name () {
	return "-LocalePath";
}

} // namespace I18N_i
} // namespace GCI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
