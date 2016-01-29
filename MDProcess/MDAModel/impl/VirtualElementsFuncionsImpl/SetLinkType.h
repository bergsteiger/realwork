////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetLinkType.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::SetLinkType
// ��������� ���������� ������ �������� ��� ��������� 
//
// %S%f_set_link_type(agr|lnk|ref) - ������������� ��� ����� ��� ��������. ��������� ������ ���
// ����������� ���������. ���� ��������������� ��� ����� �� ����� ��� ����������� � ������� -
// ������� ����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETLINKTYPE_H__
#define __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETLINKTYPE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFunctionBase.h"

namespace VirtualElementsFuncionsImpl {

class SetLinkType; // self forward Var
typedef ::Core::Var<SetLinkType> SetLinkType_var;
typedef ::Core::Var<const SetLinkType> SetLinkType_cvar;

class SetLinkType_factory;

// %S%f_set_link_type(agr|lnk|ref) - ������������� ��� ����� ��� ��������. ��������� ������ ���
// ����������� ���������. ���� ��������������� ��� ����� �� ����� ��� ����������� � ������� -
// ������� ����������
class SetLinkType:
	virtual public VirtualElementsFunctionBase
{
	SET_OBJECT_COUNTER (SetLinkType)
	friend class SetLinkType_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	SetLinkType ();

	virtual ~SetLinkType ();

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
}; // class SetLinkType

} // namespace VirtualElementsFuncionsImpl


#endif //__MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETLINKTYPE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
