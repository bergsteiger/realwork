////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetVisibilityType.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::SetVisibilityType
// ��������� ���������� ������ �������� ��� ��������� 
//
// %S%f_set_visability_type(PublicAccess|ProtectedAccess|PrivateAccess|ImplementationAccess) -
// ������������ ��� �������� ��������. ��������� ������ ��� ����������� ���������. ���� ���
// ��������� �� ������ � ������ ����������� �������� - ������������� ����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETVISIBILITYTYPE_H__
#define __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETVISIBILITYTYPE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFunctionBase.h"

namespace VirtualElementsFuncionsImpl {

class SetVisibilityType; // self forward Var
typedef ::Core::Var<SetVisibilityType> SetVisibilityType_var;
typedef ::Core::Var<const SetVisibilityType> SetVisibilityType_cvar;

class SetVisibilityType_factory;

// %S%f_set_visability_type(PublicAccess|ProtectedAccess|PrivateAccess|ImplementationAccess) -
// ������������ ��� �������� ��������. ��������� ������ ��� ����������� ���������. ���� ���
// ��������� �� ������ � ������ ����������� �������� - ������������� ����������
class SetVisibilityType:
	virtual public VirtualElementsFunctionBase
{
	SET_OBJECT_COUNTER (SetVisibilityType)
	friend class SetVisibilityType_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	SetVisibilityType ();

	virtual ~SetVisibilityType ();

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
}; // class SetVisibilityType

} // namespace VirtualElementsFuncionsImpl


#endif //__MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETVISIBILITYTYPE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
