////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAAddinLib/impl/Addin_i/MenuHelper.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> MDProcess::MDAAddinLib::Addin_i::MenuHelper
//
// �����-�������� ��� ������ � MFC-���� ����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_ADDIN_I_MENUHELPER_H__
#define __MDPROCESS_MDAADDINLIB_ADDIN_I_MENUHELPER_H__

#include "shared/CoreSrv/sys/std_inc.h"

namespace MenuHelper {

// �������� �������� ���� ���� � ��������� ����������� � menu_string �� new_menu_string
bool modify_menu_item (CMenu& menu, const char* menu_string, const char* new_menu_string);

// �������� �������� ���� ���� � ��������������� ����������� � id �� new_menu_string
bool modify_menu_item (CMenu& menu, unsigned int id, const char* new_menu_string);

// ������� ������ ����, �� ��������������
bool remove_menu_item (CMenu& menu, unsigned int id);

// ������� ������ ���� �� ��������
bool remove_menu_item (CMenu& menu, const char* menu_string);

// ��������/��������� ������ ���� �� ��������������
bool enable_menu_item (CMenu& menu, unsigned int id, bool enable);

// ��������/�������� ������ ���� �� ��������
bool enable_menu_item (CMenu& menu, const char* menu_string, bool enable);

// ���������� ��� ���� ������ ���� � ��������� menu_string
CMenu* get_sub_menu (CMenu& menu, const char* menu_string);

// ������� ���� �� ���� ������ ������ �����������
void clear_duplicate_separator (CMenu& menu);


} // namespace MenuHelper


#endif //__MDPROCESS_MDAADDINLIB_ADDIN_I_MENUHELPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
