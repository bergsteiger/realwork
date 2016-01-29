////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAAddinLib/impl/Addin_i/MenuFactory.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> MDProcess::MDAAddinLib::Addin_i::MenuFactory
//
// ������� ��� �������� ����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_ADDIN_I_MENUFACTORY_H__
#define __MDPROCESS_MDAADDINLIB_ADDIN_I_MENUFACTORY_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"

//#UC START# *462DB25701A5_USER_INCLUDES*
//#UC END# *462DB25701A5_USER_INCLUDES*

namespace MenuFactory {

// ��� ����: ��� ��������, ��� ������
enum MenuType {
	TREE_MENU // ���� ��� �������� � ��������
	, DIAG_MENU // ���� ��� �������� �� ���������
};

// ������� ���� ��� ��������
CMenu* create_menu (MenuType type, IRoseElementPtr elem);

// ������� ���� ��� �������� ������
CMenu* create_tree_menu (IRoseElementPtr elem);

// ������� ���� ��� �������� �� ��������
CMenu* create_diag_menu (IRoseElementPtr elem);

//#UC START# *462DB25701A5_USER_DEFINITION*
//#UC END# *462DB25701A5_USER_DEFINITION*

} // namespace MenuFactory


#endif //__MDPROCESS_MDAADDINLIB_ADDIN_I_MENUFACTORY_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
