////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/CopyUP.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::CopyUP
// ��������� ���������� ������ �������� ��� ��������� 
//
// %S%f_copy_up(<��� ��� ��� ��������>) - �������� �������� UP �� ��������-��������� � �������-
// ����, ��� ���� � ��������-���� ����� ������� �� ���������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_COPYUP_H__
#define __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_COPYUP_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFunctionBase.h"

namespace VirtualElementsFuncionsImpl {

class CopyUP; // self forward Var
typedef ::Core::Var<CopyUP> CopyUP_var;
typedef ::Core::Var<const CopyUP> CopyUP_cvar;

class CopyUP_factory;

// %S%f_copy_up(<��� ��� ��� ��������>) - �������� �������� UP �� ��������-��������� � �������-
// ����, ��� ���� � ��������-���� ����� ������� �� ���������.
class CopyUP:
	virtual public VirtualElementsFunctionBase
{
	SET_OBJECT_COUNTER (CopyUP)
	friend class CopyUP_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	CopyUP ();

	virtual ~CopyUP ();

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
}; // class CopyUP

} // namespace VirtualElementsFuncionsImpl


#endif //__MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_COPYUP_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
