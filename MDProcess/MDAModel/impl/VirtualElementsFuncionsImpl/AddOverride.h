////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddOverride.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::AddOverride
// ��������� ���������� ������ �������� ��� ��������� 
//
// %S%f_add_override(<GUID ��������>) - ��������� �������� �������� GUID'�� � ������
// ���������������� �������� (%O), ��� ���� �������� ������ ������������ ������ �� �������
// ���������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_ADDOVERRIDE_H__
#define __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_ADDOVERRIDE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/OverrideImplementBase.h"

namespace VirtualElementsFuncionsImpl {

class AddOverride; // self forward Var
typedef ::Core::Var<AddOverride> AddOverride_var;
typedef ::Core::Var<const AddOverride> AddOverride_cvar;

class AddOverride_factory;

// %S%f_add_override(<GUID ��������>) - ��������� �������� �������� GUID'�� � ������
// ���������������� �������� (%O), ��� ���� �������� ������ ������������ ������ �� �������
// ���������.
class AddOverride:
	virtual public OverrideImplementBase
{
	SET_OBJECT_COUNTER (AddOverride)
	friend class AddOverride_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	AddOverride ();

	virtual ~AddOverride ();
}; // class AddOverride

} // namespace VirtualElementsFuncionsImpl


#endif //__MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_ADDOVERRIDE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
