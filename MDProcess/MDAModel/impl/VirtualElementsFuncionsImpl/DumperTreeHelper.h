////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/DumperTreeHelper.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<UtilityClass::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::DumperTreeHelper
//
// ��������������� ����� ��� ������ � ������� ��������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_DUMPERTREEHELPER_H__
#define __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_DUMPERTREEHELPER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDumper.h"

namespace VirtualElementsFuncionsImpl {

// ��������������� ����� ��� ������ � ������� ��������
class DumperTreeHelper {
	SET_OBJECT_COUNTER (DumperTreeHelper)
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// ������� ������� � ������ �������� �� �����
	static RoseAbstractDumper* find_in_tree (const std::string& guid);

}; // class DumperTreeHelper

} // namespace VirtualElementsFuncionsImpl


#endif //__MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_DUMPERTREEHELPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

