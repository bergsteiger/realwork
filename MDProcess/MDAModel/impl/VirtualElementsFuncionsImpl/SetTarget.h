////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetTarget.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::SetTarget
// ��������� ���������� ������ �������� ��� ��������� 
//
// ���������� �������� (��������, ���������, ��������)  ����� ���
// %S%f_set_target(<���/��� �������� ��� ����� (� ������ void)>)
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETTARGET_H__
#define __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETTARGET_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFunctionBase.h"

namespace VirtualElementsFuncionsImpl {

class SetTarget; // self forward Var
typedef ::Core::Var<SetTarget> SetTarget_var;
typedef ::Core::Var<const SetTarget> SetTarget_cvar;

class SetTarget_factory;

// ���������� �������� (��������, ���������, ��������)  ����� ���
// %S%f_set_target(<���/��� �������� ��� ����� (� ������ void)>)
class SetTarget:
	virtual public VirtualElementsFunctionBase
{
	SET_OBJECT_COUNTER (SetTarget)
	friend class SetTarget_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	SetTarget ();

	virtual ~SetTarget ();

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
}; // class SetTarget

} // namespace VirtualElementsFuncionsImpl


#endif //__MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETTARGET_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
