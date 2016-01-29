////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddRealized.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::AddRealized
// ��������� ���������� ������ �������� ��� ��������� 
//
// %S%f_add_realized(<���� ��������� �������� ��� ������ ���>, <������������ - true | false>) -
// ��������� � ������ ����������� ��������� �������, ��������������� �����, ���� ����� �� ����, �
// ������ ��� ������ - ������� � ������ ������� � ����� ������ � ��������� ���, ���� �����������
// ������������ �����, �� ��� ��� �� ����� ����������� �������� ����������� � ���������, � �����,
// ����� ����� �� ����� ����������� � ����� �����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_ADDREALIZED_H__
#define __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_ADDREALIZED_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFunctionBase.h"

namespace VirtualElementsFuncionsImpl {

class AddRealized; // self forward Var
typedef ::Core::Var<AddRealized> AddRealized_var;
typedef ::Core::Var<const AddRealized> AddRealized_cvar;

class AddRealized_factory;

// %S%f_add_realized(<���� ��������� �������� ��� ������ ���>, <������������ - true | false>) -
// ��������� � ������ ����������� ��������� �������, ��������������� �����, ���� ����� �� ����, �
// ������ ��� ������ - ������� � ������ ������� � ����� ������ � ��������� ���, ���� �����������
// ������������ �����, �� ��� ��� �� ����� ����������� �������� ����������� � ���������, � �����,
// ����� ����� �� ����� ����������� � ����� �����������
class AddRealized:
	virtual public VirtualElementsFunctionBase
{
	SET_OBJECT_COUNTER (AddRealized)
	friend class AddRealized_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	AddRealized ();

	virtual ~AddRealized ();

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
}; // class AddRealized

} // namespace VirtualElementsFuncionsImpl


#endif //__MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_ADDREALIZED_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
