////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/CountInList.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VarFunctionsImpl::CountInList
// ��������� ���������� ������ �������� ��� ��������� 
//
// ���������� ���������� ������� ���������� _count_in_list.
// _count_in_list(��������������, ���������) - ���������� ������� ��� ����������� � ������
// ������� (����� ���� ������� ������ ��� ������).
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_COUNTINLIST_H__
#define __MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_COUNTINLIST_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/ContainerOperationsImpl/ListOperationBaseImpl.h"

namespace VarFunctionsImpl {

class CountInList; // self forward Var
typedef ::Core::Var<CountInList> CountInList_var;
typedef ::Core::Var<const CountInList> CountInList_cvar;

class CountInList_factory;

// ���������� ���������� ������� ���������� _count_in_list.
// _count_in_list(��������������, ���������) - ���������� ������� ��� ����������� � ������
// ������� (����� ���� ������� ������ ��� ������).
class CountInList:
	virtual public ContainerOperationsImpl::ListOperationBaseImpl
{
	SET_OBJECT_COUNTER (CountInList)
	friend class CountInList_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	CountInList ();

	virtual ~CountInList ();

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
}; // class CountInList

} // namespace VarFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_COUNTINLIST_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
