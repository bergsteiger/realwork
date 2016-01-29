////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualFunctionsHelper.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<UtilityClass::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::VirtualFunctionsHelper
//
// ����� ��������������� �������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_VIRTUALFUNCTIONSHELPER_H__
#define __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_VIRTUALFUNCTIONSHELPER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumper.h"

namespace VirtualElementsFuncionsImpl {

// ����� ��������������� �������
class VirtualFunctionsHelper {
	SET_OBJECT_COUNTER (VirtualFunctionsHelper)
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// ��������� ��������� spell'� ��� ��������, �������������� ������� spell �� ���������, ���
	// ������� �� "������" �������
	static void run_spell_with_suppliers (const AbstractDumper* elem);

}; // class VirtualFunctionsHelper

} // namespace VirtualElementsFuncionsImpl


#endif //__MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_VIRTUALFUNCTIONSHELPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

