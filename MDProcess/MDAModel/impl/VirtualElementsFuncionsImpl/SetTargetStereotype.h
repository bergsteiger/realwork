////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetTargetStereotype.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::SetTargetStereotype
// ��������� ���������� ������ �������� ��� ��������� 
//
// %S%f_set_target_stereotype(agr|lnk|ref) - ������������� target_stereotyp ��� �������� ���
// ��������. ��������� ������ ��� ����������� ���������. ���� ��������������� target_stereotyp ��
// ������ ��� ����������� � ������� - ������� ����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETTARGETSTEREOTYPE_H__
#define __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETTARGETSTEREOTYPE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFunctionBase.h"

namespace VirtualElementsFuncionsImpl {

class SetTargetStereotype; // self forward Var
typedef ::Core::Var<SetTargetStereotype> SetTargetStereotype_var;
typedef ::Core::Var<const SetTargetStereotype> SetTargetStereotype_cvar;

class SetTargetStereotype_factory;

// %S%f_set_target_stereotype(agr|lnk|ref) - ������������� target_stereotyp ��� �������� ���
// ��������. ��������� ������ ��� ����������� ���������. ���� ��������������� target_stereotyp ��
// ������ ��� ����������� � ������� - ������� ����������
class SetTargetStereotype:
	virtual public VirtualElementsFunctionBase
{
	SET_OBJECT_COUNTER (SetTargetStereotype)
	friend class SetTargetStereotype_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	SetTargetStereotype ();

	virtual ~SetTargetStereotype ();

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
}; // class SetTargetStereotype

} // namespace VirtualElementsFuncionsImpl


#endif //__MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETTARGETSTEREOTYPE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
