////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/WinGUI/Helpers/ClipboardHelper.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<UtilityClass::Class>> shared::WinGUI::Helpers::ClipboardHelper
//
// ��������������� ����� ��� ������ � ������� ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_WINGUI_HELPERS_CLIPBOARDHELPER_H__
#define __SHARED_WINGUI_HELPERS_CLIPBOARDHELPER_H__

#include "shared/Core/sys/std_inc.h"

namespace WinGUI {

// ��������������� ����� ��� ������ � ������� ������
class ClipboardHelper {
	SET_OBJECT_COUNTER (ClipboardHelper)
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// �������� ����� � ����� ������, ���������� true, ���� ��� ������ �������
	static bool copy_text_to_clipboard (const std::string& text);

}; // class ClipboardHelper

} // namespace WinGUI


#endif //__SHARED_WINGUI_HELPERS_CLIPBOARDHELPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

