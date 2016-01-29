////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/AddToList.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VarFunctionsImpl::AddToList
// ��������� ���������� ������ �������� ��� ��������� 
//
// ���������� ���������� ������� ���������� _add_to_list.
// _add_to_list (��������������, ���������) - ��������� � ������ c �������� ���������������
// ������� (����� ���� ������� ������ ��� ������).
// %f_add_to_list (LIST, S)
// %f_add_to_list (LIST, "test str")
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_ADDTOLIST_H__
#define __MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_ADDTOLIST_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/ContainerOperationsImpl/ListOperationBaseImpl.h"

namespace VarFunctionsImpl {

class AddToList; // self forward Var
typedef ::Core::Var<AddToList> AddToList_var;
typedef ::Core::Var<const AddToList> AddToList_cvar;

class AddToList_factory;

// ���������� ���������� ������� ���������� _add_to_list.
// _add_to_list (��������������, ���������) - ��������� � ������ c �������� ���������������
// ������� (����� ���� ������� ������ ��� ������).
// %f_add_to_list (LIST, S)
// %f_add_to_list (LIST, "test str")
class AddToList:
	virtual public ContainerOperationsImpl::ListOperationBaseImpl
{
	SET_OBJECT_COUNTER (AddToList)
	friend class AddToList_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	AddToList ();

	virtual ~AddToList ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from BaseFunctionImpl::InternalFunctionBase
	// ���������� ���������� ���������� �������. ������ ���������� ������� ��������� ��� �����
	virtual const std::string execute_impl (
		const TemplateFunctions::FunctionParams& params
		, TemplatePainter* painter
	) const /*throw (
		TemplateFunctions::BadParams
	)*/;
}; // class AddToList

} // namespace VarFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_ADDTOLIST_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
