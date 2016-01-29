////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/WinGUI/Helpers/WinControlHelper.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<UtilityClass::Class>> shared::WinGUI::Helpers::WinControlHelper
//
// ��������������� �������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_WINGUI_HELPERS_WINCONTROLHELPER_H__
#define __SHARED_WINGUI_HELPERS_WINCONTROLHELPER_H__

#include "shared/Core/sys/std_inc.h"

namespace WinGUI {

// ��������������� �������
class WinControlHelper {
	SET_OBJECT_COUNTER (WinControlHelper)
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// ���������� ������� ��������� ������� � ������ ������-�����
	static CRect* get_client_rect_sb (CWnd& wnd);

	// true - ���� ctrl �������� �����������, ����� false
	static bool is_combobox (CWnd& ctrl);

}; // class WinControlHelper

} // namespace WinGUI


#endif //__SHARED_WINGUI_HELPERS_WINCONTROLHELPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

