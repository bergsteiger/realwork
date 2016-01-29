////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/StereotypeFunctionsImpl/ClearList.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StereotypeFunctionsImpl::ClearList
// ��������� ���������� ������ �������� ��� ��������� 
//
// %S%f_clear_list(LIST_ID) - ������� ��������� ������ � ��������������� LIST_ID, ���� � %S �� ����
// ������� ���������� ���� ������ � ����� ���������������, ������ ��������� � �����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_STEREOTYPEFUNCTIONSIMPL_CLEARLIST_H__
#define __MDPROCESS_MDAMODEL_STEREOTYPEFUNCTIONSIMPL_CLEARLIST_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalStereotypeFunctionBase.h"

namespace StereotypeFunctionsImpl {

class ClearList; // self forward Var
typedef ::Core::Var<ClearList> ClearList_var;
typedef ::Core::Var<const ClearList> ClearList_cvar;

class ClearList_factory;

// %S%f_clear_list(LIST_ID) - ������� ��������� ������ � ��������������� LIST_ID, ���� � %S �� ����
// ������� ���������� ���� ������ � ����� ���������������, ������ ��������� � �����������
class ClearList:
	virtual public BaseFunctionImpl::InternalStereotypeFunctionBase
{
	SET_OBJECT_COUNTER (ClearList)
	friend class ClearList_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ClearList ();

	virtual ~ClearList ();

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
}; // class ClearList

} // namespace StereotypeFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_STEREOTYPEFUNCTIONSIMPL_CLEARLIST_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
