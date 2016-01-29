////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/OverrideImplementBase.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::OverrideImplementBase
// ��������� ���������� ������ �������� ��� ��������� 
//
// ������� ���������� ������ ���������� �������� � ������ overload ��� implemented
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_OVERRIDEIMPLEMENTBASE_H__
#define __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_OVERRIDEIMPLEMENTBASE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFunctionBase.h"

namespace VirtualElementsFuncionsImpl {

class OverrideImplementBase; // self forward Var
typedef ::Core::Var<OverrideImplementBase> OverrideImplementBase_var;
typedef ::Core::Var<const OverrideImplementBase> OverrideImplementBase_cvar;

// ������� ���������� ������ ���������� �������� � ������ overload ��� implemented
class OverrideImplementBase:
	virtual public VirtualElementsFunctionBase
{
	SET_OBJECT_COUNTER (OverrideImplementBase)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	OverrideImplementBase ();


	// prop - ��� ��������, � ������� ����� ����������� ��������
	OverrideImplementBase (const std::string& prop, char list_tpl_command);

	virtual ~OverrideImplementBase ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// ������� �������, ��������������� ����������� ������
	char m_list_tpl_command;

	// ��� ��������, � ������ �������� ������ overload ��� implemented
	std::string m_property_name;

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
}; // class OverrideImplementBase

} // namespace VirtualElementsFuncionsImpl


#endif //__MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_OVERRIDEIMPLEMENTBASE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
