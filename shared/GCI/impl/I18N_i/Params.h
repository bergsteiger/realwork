////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/GCI/impl/I18N_i/Params.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Settings::Class>> shared::GCI::I18N_i::Params
//
// ��������� ������ � ��������������������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCI_I18N_I_PARAMS_H__
#define __SHARED_GCI_I18N_I_PARAMS_H__

#include "shared/Core/sys/std_inc.h"

namespace GCI {
namespace I18N_i {

// ��������� ������ � ��������������������
class Params {

// static member methods and data
public:
	// ���������� ������������ ������
	static const std::string get_locale_path () /* throw (Core::ParameterIsMissing) */;
	static void set_locale_path (const std::string& value);
	static const char* locale_path_param_name ();

}; // class Params

} // namespace I18N_i
} // namespace GCI


#endif //__SHARED_GCI_I18N_I_PARAMS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

