////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/RemoveRealized.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::RemoveRealized
// ��������� ���������� ������ �������� ��� ��������� 
//
// %S%f_remove_realized(<��� ��������>) - ������� �������� ����� ���������� ����� ������� ���������
// � ���������, �������� ���'��. ���� �� ������� ����� ������� � �������� ���'�� ��� � ����
// ��������� ��� ����� ���������� - ������������ ����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_REMOVEREALIZED_H__
#define __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_REMOVEREALIZED_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFunctionBase.h"

namespace VirtualElementsFuncionsImpl {

class RemoveRealized; // self forward Var
typedef ::Core::Var<RemoveRealized> RemoveRealized_var;
typedef ::Core::Var<const RemoveRealized> RemoveRealized_cvar;

class RemoveRealized_factory;

// %S%f_remove_realized(<��� ��������>) - ������� �������� ����� ���������� ����� ������� ���������
// � ���������, �������� ���'��. ���� �� ������� ����� ������� � �������� ���'�� ��� � ����
// ��������� ��� ����� ���������� - ������������ ����������
class RemoveRealized:
	virtual public VirtualElementsFunctionBase
{
	SET_OBJECT_COUNTER (RemoveRealized)
	friend class RemoveRealized_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	RemoveRealized ();

	virtual ~RemoveRealized ();

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
}; // class RemoveRealized

} // namespace VirtualElementsFuncionsImpl


#endif //__MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_REMOVEREALIZED_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
