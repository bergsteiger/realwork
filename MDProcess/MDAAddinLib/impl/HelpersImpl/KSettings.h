////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAAddinLib/impl/HelpersImpl/KSettings.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Settings::Class>> MDProcess::MDAAddinLib::HelpersImpl::KSettings
//
// ��������� ������� � �
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_HELPERSIMPL_KSETTINGS_H__
#define __MDPROCESS_MDAADDINLIB_HELPERSIMPL_KSETTINGS_H__

#include "shared/CoreSrv/sys/std_inc.h"

namespace HelpersImpl {

// ��������� ������� � �
class KSettings {

// static member methods and data
public:
	// ������ K
	static const std::string get_k_link () /* throw (Core::ParameterIsMissing) */;
	static void set_k_link (const std::string& value);
	static const char* k_link_param_name ();

}; // class KSettings

} // namespace HelpersImpl


#endif //__MDPROCESS_MDAADDINLIB_HELPERSIMPL_KSETTINGS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

