////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/WinGUI/Helpers/WinControlHelper.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<UtilityClass::Class>> shared::WinGUI::Helpers::WinControlHelper
//
// ��������������� �������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/WinGUI/Helpers/WinControlHelper.h"

namespace WinGUI {

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// ���������� ������� ��������� ������� � ������ ������-�����
CRect* WinControlHelper::get_client_rect_sb (CWnd& wnd) {
	//#UC START# *4652C2D5001F*
    CRect winRect;
    wnd.GetWindowRect(&winRect);
    wnd.ScreenToClient(&winRect);
	
	Core::Aptr<CRect> rect = new CRect;
	wnd.GetClientRect(rect.ptr ());

    int cxSB = ::GetSystemMetrics(SM_CXVSCROLL);
    int cySB = ::GetSystemMetrics(SM_CYHSCROLL);

	if (winRect.right >= (rect->right + cxSB)) {
		rect->right += cxSB;
	}

	if (winRect.bottom >= (rect->bottom + cySB)) {
        rect->bottom += cySB;
	}
	return rect.forget ();
	//#UC END# *4652C2D5001F*
}

// true - ���� ctrl �������� �����������, ����� false
bool WinControlHelper::is_combobox (CWnd& ctrl) {
	//#UC START# *4652C29901F4*

    return ctrl.IsKindOf (RUNTIME_CLASS(CComboBox));        
	//#UC END# *4652C29901F4*
}

} // namespace WinGUI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

