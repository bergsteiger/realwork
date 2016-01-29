////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddAttribute.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::AddAttribute
// ��������� ���������� ������ �������� ��� ��������� 
//
// %S%f_add_attribute(<GUID ������ ��������>, <���������>,<��������� ��������>,<��� ����������>) -
// ���������� _add_operation, �� ��������� ����� �������, �������� ��-��������� ����� ���� ������
// ������ ��������� �������� ���� ������ ������� (���������� ����).
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_ADDATTRIBUTE_H__
#define __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_ADDATTRIBUTE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFunctionBase.h"

namespace VirtualElementsFuncionsImpl {

class AddAttribute; // self forward Var
typedef ::Core::Var<AddAttribute> AddAttribute_var;
typedef ::Core::Var<const AddAttribute> AddAttribute_cvar;

class AddAttribute_factory;

// %S%f_add_attribute(<GUID ������ ��������>, <���������>,<��������� ��������>,<��� ����������>) -
// ���������� _add_operation, �� ��������� ����� �������, �������� ��-��������� ����� ���� ������
// ������ ��������� �������� ���� ������ ������� (���������� ����).
class AddAttribute:
	virtual public VirtualElementsFunctionBase
{
	SET_OBJECT_COUNTER (AddAttribute)
	friend class AddAttribute_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	AddAttribute ();

	virtual ~AddAttribute ();

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
}; // class AddAttribute

} // namespace VirtualElementsFuncionsImpl


#endif //__MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_ADDATTRIBUTE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
