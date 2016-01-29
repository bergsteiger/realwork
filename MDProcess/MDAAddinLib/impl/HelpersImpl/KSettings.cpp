////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAAddinLib/impl/HelpersImpl/KSettings.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<Settings::Class>> MDProcess::MDAAddinLib::HelpersImpl::KSettings
//
// ��������� ������� � �
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/Params/Params.h"
#include "MDProcess/MDAAddinLib/impl/HelpersImpl/KSettings.h"

namespace HelpersImpl {

const std::string KSettings::get_k_link () {
	return Core::ParamManagerFactory::get ().get_string ("-KLink", "http://mdp.garant.ru");
}

void KSettings::set_k_link (const std::string& value) {
	Core::ParamManagerFactory::get ().set_string ("-KLink", value.c_str());
}

const char* KSettings::k_link_param_name () {
	return "-KLink";
}

} // namespace HelpersImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
