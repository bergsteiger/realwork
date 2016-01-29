////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/MakeAccessable.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::MakeAccessable
// ��������� ���������� ������ �������� ��� ��������� 
//
// %S%f_make_accessable(������������� ��������) - ������ ������� ������� - ����������� �����������
// ����� (�����������), ��� ���� ����� ������������� ����� ���������� ���� ���������, ����� ������
// ���������� ������� ����� ������ �� �����������!. ������:
// {code}
// %S%f_make_accessable(%T�)
// {code}
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_MAKEACCESSABLE_H__
#define __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_MAKEACCESSABLE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFunctionBase.h"

namespace VirtualElementsFuncionsImpl {

class MakeAccessable; // self forward Var
typedef ::Core::Var<MakeAccessable> MakeAccessable_var;
typedef ::Core::Var<const MakeAccessable> MakeAccessable_cvar;

class MakeAccessable_factory;

// %S%f_make_accessable(������������� ��������) - ������ ������� ������� - ����������� �����������
// ����� (�����������), ��� ���� ����� ������������� ����� ���������� ���� ���������, ����� ������
// ���������� ������� ����� ������ �� �����������!. ������:
// {code}
// %S%f_make_accessable(%T�)
// {code}
class MakeAccessable:
	virtual public VirtualElementsFunctionBase
{
	SET_OBJECT_COUNTER (MakeAccessable)
	friend class MakeAccessable_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	MakeAccessable ();

	virtual ~MakeAccessable ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from BaseFunctionImpl::InternalStereotypeFunctionBase
	// ���������� ���������� ���������� �������. ������ ���������� ������� ��������� ��� �����
	virtual const std::string execute_impl (
		const AbstractDumperBase* self
		, const TemplateFunctions::FunctionParams& params
		, TemplatePainter* painter
	) const /*throw (
		TemplateFunctions::BadParams
	)*/;
}; // class MakeAccessable

} // namespace VirtualElementsFuncionsImpl


#endif //__MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_MAKEACCESSABLE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
