////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetStereotype.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::SetStereotype
// ��������� ���������� ������ �������� ��� ��������� 
//
// %f_set_stereotype(<���������>) - ������������� ��������� ��������. ��������� ������ �
// ����������� ���������, ��� �������� ��������� ����� ��������� ����������. ���� ������� �� �����
// ����� �������� ��������� - ������������� ����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETSTEREOTYPE_H__
#define __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETSTEREOTYPE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFunctionBase.h"

namespace VirtualElementsFuncionsImpl {

class SetStereotype; // self forward Var
typedef ::Core::Var<SetStereotype> SetStereotype_var;
typedef ::Core::Var<const SetStereotype> SetStereotype_cvar;

class SetStereotype_factory;

// %f_set_stereotype(<���������>) - ������������� ��������� ��������. ��������� ������ �
// ����������� ���������, ��� �������� ��������� ����� ��������� ����������. ���� ������� �� �����
// ����� �������� ��������� - ������������� ����������
class SetStereotype:
	virtual public VirtualElementsFunctionBase
{
	SET_OBJECT_COUNTER (SetStereotype)
	friend class SetStereotype_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	SetStereotype ();

	virtual ~SetStereotype ();

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
}; // class SetStereotype

} // namespace VirtualElementsFuncionsImpl


#endif //__MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETSTEREOTYPE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
