////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/WinGUI/Helpers/WindowHelper.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::WinGUI::Helpers::WindowHelper
//
// �������� ������� ��� ������ � ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_WINGUI_HELPERS_WINDOWHELPER_H__
#define __SHARED_WINGUI_HELPERS_WINDOWHELPER_H__

#include "shared/Core/sys/std_inc.h"

namespace WinGUI {

// ���� ���� ����� ����� from, � �������� ����� ��������� � caption, � ��� ������ ���� � class_name
// ���� �� ���������� �� ����� ����� �������������� ������ �� ����, ������� �����
HWND find_window (HWND from, const std::string& caption, const std::string& class_name);


} // namespace WinGUI


#endif //__SHARED_WINGUI_HELPERS_WINDOWHELPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
