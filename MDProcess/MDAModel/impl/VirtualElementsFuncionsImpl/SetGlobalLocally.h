////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetGlobalLocally.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::SetGlobalLocally
// ��������� ���������� ������ �������� ��� ��������� 
//
// %S%f_set_global_locally(true|false) - ����� ��� ��������� "��������� ������������"
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETGLOBALLOCALLY_H__
#define __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETGLOBALLOCALLY_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalStereotypeFunctionBase.h"

namespace VirtualElementsFuncionsImpl {

class SetGlobalLocally; // self forward Var
typedef ::Core::Var<SetGlobalLocally> SetGlobalLocally_var;
typedef ::Core::Var<const SetGlobalLocally> SetGlobalLocally_cvar;

class SetGlobalLocally_factory;

// %S%f_set_global_locally(true|false) - ����� ��� ��������� "��������� ������������"
class SetGlobalLocally:
	virtual public BaseFunctionImpl::InternalStereotypeFunctionBase
{
	SET_OBJECT_COUNTER (SetGlobalLocally)
	friend class SetGlobalLocally_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	SetGlobalLocally ();

	virtual ~SetGlobalLocally ();

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
}; // class SetGlobalLocally

} // namespace VirtualElementsFuncionsImpl


#endif //__MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETGLOBALLOCALLY_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
